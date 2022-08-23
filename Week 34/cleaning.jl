using DataFrames
using CSV
using Chain
using Dates

# Read in Data
filename = "data/chip_dataset.csv"
filepath = joinpath(@__DIR__, filename)
raw_data = CSV.read(filepath, DataFrame)

# Select GPU's only
parse_date(d::AbstractString) = Dates.year(Date.(d, DateFormat("y-m-d")))
is_gpu(type::AbstractString) = type=="GPU"
is_nat(date::AbstractString) = date=="NaT"
date_range(y::Int) = y==2011 || y==2021
bad_max(y::Int, v::AbstractString) = y==2011 && v=="Max"
bad_min(y::Int, v::AbstractString) = y==2021 && v=="Min"

gpu_data = @chain raw_data begin
    filter(:Type=>is_gpu, _)
    filter(Symbol("Release Date")=>!is_nat, _)
    transform(Symbol("Release Date")=>ByRow(parse_date)=>:Year)
    filter(:Year=>date_range, _)
    select(_, [:Year, :Vendor, Symbol("Freq (MHz)")])
end

figure_data = @chain gpu_data begin
	groupby(_, [:Year, :Vendor])
	combine(_, [Symbol("Freq (MHz)")=>minimum=>:Min, Symbol("Freq (MHz)")=>maximum=>:Max])
	stack(_, [:Min, :Max])
	filter([:Year, :variable]=>!bad_max, _)
	filter([:Year, :variable]=>!bad_min, _)
	select(_, [:Year, :Vendor, :value])
end

CSV.write(joinpath(@__DIR__, "data/figure_data.csv"), figure_data)
