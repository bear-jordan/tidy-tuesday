### A Pluto.jl notebook ###
# v0.19.11

#> [frontmatter]
#> title = "TidyTuesday: Week 31, 2022"
#> tags = ["EDA", "Julia", "Frogs", "TidyTuesday"]
#> description = "Exploratory Data Analysis"

using Markdown
using InteractiveUtils

# ╔═╡ f8b9fec9-f521-4069-86ad-a302dc4024ff
begin
	using CSV
	using DataFrames
	using Gadfly
	using Statistics
end

# ╔═╡ ad83c1bf-8343-4ede-9c96-b7fd2218b8ff
md"""
# Week 31: Frogs EDA
## Background

> The Oregon spotted frog (Rana pretiosa) is a medium-sized anuran native to the northwestern United States. Body coloration ranges from brown or tan to brick red, usually overlaid with dark, ragged spots. Oregon spotted frogs can be distinguished from other native species by their relatively short hind legs, orange or red wash of color on underside of abdomen and legs, and upturned chartreuse eyes. They are associated with freshwater marshes and lakes where they breed in early spring in warm emergent vegetated shallows. The Oregon spotted frog is highly aquatic and reliant on connected seasonal habitats for breeding, summer foraging, and overwintering.
> 
> Oregon spotted frogs once occurred from southwest British Columbia to northeastern California. They appear to be lost from California and Oregon’s Willamette Valley. Hypothesized reasons for their decline include habitat loss and alteration, invasive predators and competitors, and water quality degradation. Most of known populations are currently located along the Cascade Range in central Oregon. The Oregon spotted frog was listed as Threatened under the Endangered Species Act in 2014.
> 
> USGS Research – Status and Trends, Threat Assessments
> 
> The USGS Forest and Rangeland Ecosystem Science Center (FRESC) is the Pacific Northwest hub for the US Department of Interior’s Amphibian Research and Monitoring Initiative (ARMI). Over the past 15 years, biologists in Dr. Michael Adams’s laboratory at FRESC have monitored occupancy patterns, abundance, and population demography to better understand the status of Oregon spotted frog in Oregon. Through a combination of observational, experimental, and modeling techniques, researchers examine relationships between Oregon spotted frog population trends and habitat variables to understand factors contributing to Oregon spotted frog declines.
> 
> USGS and partners have also evaluated interagency efforts to translocate Oregon spotted frogs. Long-term monitoring of relocated populations through mark-recapture efforts allows researchers to estimate probabilities of site colonization or extinction, as well as survival and growth rates for different sexes and life stages. This information can help managers plan for future translocations by understanding the underlying causes for a project’s success or failure.
> 
> USGS researchers disseminate their findings on Oregon spotted frog conservation to the public through various modes, including formal Oregon spotted frog status reports, peer-reviewed journal publications, and the popular media.
> 
> The Herpetology Lab works with a variety of academic, non profit, and federal and state agency partners. Results are disseminated in a variety of ways, including peer-reviewed journal publications, scientific meetings, public presentations, and the popular media.

[Source](https://www.usgs.gov/centers/forest-and-rangeland-ecosystem-science-center/science/oregon-spotted-frog)
"""

# ╔═╡ 4c253e1c-005b-499c-88be-313d88323844
md"""
### What Stands out

- The Oregon spotted frog are are in decline potentially due to habitat loss and alteration, invasive predators and competitors, and water quality degredation.

- It's population has shrunk from a range of BC to northeastern California all the way to the Cascade Range in central Oregon.

- Researchers use mark and recapture to track species.
"""

# ╔═╡ bad52c6c-0239-4ae7-a947-310e5bbd176a
md"""
## Initial Ideas

I think it could be fun to do a map of showing the where the species used to exist and where they exist now. I could do a scrolly showing the decline with major events.
"""


# ╔═╡ 72db4913-d3f8-4075-9b10-dac79e59a4c7
md"""
## EDA
Looking through the data, I can immediately say that my initial idea will not work. All the data has been collected in 2018.

Each row of data represents one detection of a frog, and the categorical variables help describe the context around where the frog was seen.
"""

# ╔═╡ 15a747b5-d2e4-432d-8991-9f78e19643a5
RawData = CSV.read("frogs.csv", DataFrame);

# ╔═╡ 6b7dbe09-dd76-4421-ba9a-13233ac3230e
md"""
### Data Dictionary
- SurveyDate: Date telemetry data were collected.
- Ordinal: Ordinal day from January 1, 2018 on which telemetry data were collected.
- Frequency: Unique transmitter frequency associated with each individual frog.
- UTME_83: Universal Transverse Mercator (UTM) easting coordinate in North American Datum (NAD 83) for the frog location or triangulated estimate. All UTMs are in Zone 10. Null values indicate data unavailable.
- UTMN_83: Universal Transverse Mercator (UTM) northing coordinate in North American Datum (NAD 83) for the frog location or triangulated estimate. All UTMs are in Zone 10. Null values indicate data unavailable.
- Site: Name of study site, used to identify location and populations.
- Subsite: Name of subsite within main Site, used to identify discrete habitat types and spatial congregations of frogs.
- HabType: Habitat type associated with the given frog location.
    - Reservoir: Frog location is in the main lacustrine body of Crane Prairie Reservoir.
    - Pond: Frog location is in a palustrine pond habitat off the main reservoir.
    - River: Frog location is in a riverine or channelized habitat off the main reservoir.
- Interval: Tracking interval for each individual, starting with the capture location (interval 0) and ending on the last tracking event.
- Female: A numeric identifier for the sex of the individual frog.
- Water: A variable describing water presence and depth at the frog location.
    - Deep Water: Water is greater than 50 cm deep.
    - Shallow Water: Water is less than 50 cm deep.
    - No Water: No standing water is present.
    - Unknown Water: Unable to determine because signal is from location obscured from view and where water is possible.
- Type: A variable describing general hydrology in the area surrounding the frog location.
    - Reservoir: Lentic (lacking flow) and connected to or in the main body of reservoir.
    - Marsh/Pond: Lentic (lacking flow), smaller, and separated from the main body of reservoir.
    - Stream/Canal: Lotic (flow present).
    - Non-aquatic: No visible standing water.
- Structure: A variable describing the dominant structure present at the frog location that may provide cover.
    - Herbaceous veg: Aquatic or terrestrial herbaceous vegetation.
    - Leaf litter: Deposited leaves or needles.
    - Woody debris: Sticks or logs.
    - Woody veg: Woody vegetation, such as shrubs.
    - Open: Open water or soil/rock with no vegetation present.
- Substrate: A variable describing the substrate in and around the frog signal location.
    - Flocc: Unconsolidated watery organic muck.
    - Organic soil: Smooth, dark soil of organic origin.
    - Mineral soil: Gritty, light soil or rock of mineral origin.
    - Unknown substrate: Unknown substrate type.
- Beaver: A variable describing the presence of any beaver-made features in which the frog signal is located.
    - Burrow: Beaver burrow in bank.
    - Channel/runway: Narrow linear excavation running from main water body toward or along bank or lodge.
    - Lodge: Sticks/mud piled in a circular fashion, indicative of a beaver lodge.
    - No beaver: No beaver feature present at the frog location.
- Detection: Indicates whether the frog was visualized or captured when signal was located.
    - Captured: Frog was captured and released by the surveyor.
    - Visual: Frog was visible to the surveyor, but not captured.
    - No visual: Frog was not visible to the surveyor.


None of the data has missing rows.
"""

# ╔═╡ 3d0f4384-c15c-42dd-a43e-8f71aaad5410
describe(RawData)

# ╔═╡ aa052c19-53eb-479f-8c8c-193192080c92
head(RawData)

# ╔═╡ 021ee57d-033d-449b-8e41-ead465c2d4e8
md"""
All data was taken from the \"Crane Prarie\" site, but there is variation within the subsite.

I wonder why some reservoirs have more observations than others?
"""

# ╔═╡ 2c36c2d9-9639-48bb-9e23-60679f1d85b7
combine(groupby(RawData, :Subsite), nrow)

# ╔═╡ 7f347746-468a-4970-90d2-b128c8d6b5c9
plot(RawData,
	 x="UTME_83",
	 y="UTMN_83",
	 color="Subsite",
	 Geom.point)

# ╔═╡ 52fb5c53-8d06-4574-a302-7d8df13ca7b8
md"""
The popularity of sites follow a power law (Reservoir>>Pond>>River).
"""

# ╔═╡ ec9c54b7-c417-4233-a06f-807bd560c97d
combine(groupby(RawData, :HabType), nrow)

# ╔═╡ 3eeb39cf-c3e9-4a79-a21b-1088a1d39174
plot(RawData,
	 x="UTME_83",
	 y="UTMN_83",
	 color="HabType",
	 Geom.point)

# ╔═╡ 02b4711d-53fc-4ddb-9c0f-8eb50405a647
md"""
Females were almost three-times as detected as males. Frogs change species I think though---I wonder if that has any relation. Is there any temporal variation?
"""

# ╔═╡ a426a09a-7f7f-4b50-b135-e1a0b40f35eb
combine(groupby(RawData, :Female), nrow)

# ╔═╡ 8f1e7c0d-202c-419f-95da-bb8e5277ac42
plot(RawData,
	 x="UTME_83",
	 y="UTMN_83",
	 color="Female",
	 Geom.point)

# ╔═╡ efab7b0c-9b7b-4646-913c-2316a0c35768
md"""
The frogs prefered shallow water. I really hope there is a detailed map for this. It would be cool to map the occurances and then model a probabilistic map too.
"""

# ╔═╡ db7717b1-69eb-45e0-b65d-1c6f0edf75e6
combine(groupby(RawData, :Water), nrow)

# ╔═╡ cd1e0571-f90a-4ff9-b79f-662a0b283347
plot(RawData,
	 x="UTME_83",
	 y="UTMN_83",
	 color="Water",
	 Geom.point)

# ╔═╡ 0a5d936e-06da-499b-aed8-b76afae5b25b
md"""
Consistent with other observations---standing water seems prefered over moving water.
"""

# ╔═╡ 4a0f5288-0947-49bb-bdfb-caf1c6e1bf54
combine(groupby(RawData, :Type), nrow)

# ╔═╡ dc042ab5-e98e-407a-9980-538af0be5371
plot(RawData,
	 x="UTME_83",
	 y="UTMN_83",
	 color="Type",
	 Geom.point)

# ╔═╡ aa79699b-b573-4b86-8b71-e059510bb3b2
md"""
Vegetated areas are more popular. I wonder why open areas are more popular than woody vegetation or leaf litter.
"""

# ╔═╡ 0c215d3a-bd91-4106-98c3-7da7a3f6a503
combine(groupby(RawData, :Structure), nrow)

# ╔═╡ 00c10302-797b-473f-a9c0-2fb851620836
plot(RawData,
	 x="UTME_83",
	 y="UTMN_83",
	 color="Structure",
	 Geom.point)

# ╔═╡ 2bce8bc8-7ddb-493b-b5ae-bf9cca98fbf6
md"""
I expect some correlation in the data here.
"""

# ╔═╡ 0aa72455-4c59-4529-b916-1a6ac7f3e021
combine(groupby(RawData, :Substrate), nrow)

# ╔═╡ 0f8e51e6-d162-478c-ae81-922d701a5871
plot(RawData,
	 x="UTME_83",
	 y="UTMN_83",
	 color="Substrate",
	 Geom.point)

# ╔═╡ d3fd6cae-a2dc-44aa-9546-3ef661d376cc
md"""
Wow, these frogs were not found in the same locations as beavers. I keep thinking of causal relationships. This one definetly seems interesting though.
"""

# ╔═╡ ac720c44-7615-4491-aa70-c810ef9ceca9
combine(groupby(RawData, :Beaver), nrow)

# ╔═╡ 8e3a1a8b-4475-496a-a5b7-ed7456806eeb
plot(RawData,
	 x="UTME_83",
	 y="UTMN_83",
	 color="Beaver",
	 Geom.point)

# ╔═╡ c6b35c28-7b52-46b4-ade9-9293160b5ac9
md"""
Mostly the frogs were not capture or spotted.
"""

# ╔═╡ 962116e4-aa18-4454-8a0c-450c13485d1d
combine(groupby(RawData, :Detection), nrow)

# ╔═╡ 09ac1d33-6cf7-4bed-a16b-76a5e612e74d
plot(RawData,
	 x="UTME_83",
	 y="UTMN_83",
	 color="Detection",
	 Geom.point)

# ╔═╡ 7d9665c4-11a8-43a6-8345-3d28cf89f176
md"""
### Updated thoughts
Well, I think it could be interesting to plot some contour maps of the no beaver locations. Maybe something weird like using the frog locations to predict beaver locations?

Some abstract visual could be really fun.

Also, I think I want to check the correlation between the categorical variables. I would be looking at Pearson's Chi-square test. I wonder if there is a Bayesian equivalent.

Maybe I can ask, when is the best time to catch a frog?

Maybe a scrolly with the probability contours of finding a frog in the area updating through time? Priors could just be a flat distance away from the water edge?
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
CSV = "336ed68f-0bac-5ca0-87d4-7b16caf5d00b"
DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
Gadfly = "c91e804a-d5a3-530f-b6f0-dfbca275c004"
Statistics = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[compat]
CSV = "~0.10.4"
DataFrames = "~1.3.4"
Gadfly = "~1.3.4"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.7.3"
manifest_format = "2.0"

[[deps.AbstractFFTs]]
deps = ["ChainRulesCore", "LinearAlgebra"]
git-tree-sha1 = "69f7020bd72f069c219b5e8c236c1fa90d2cb409"
uuid = "621f4979-c628-5d54-868e-fcf4e3e8185c"
version = "1.2.1"

[[deps.Adapt]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "195c5505521008abea5aee4f96930717958eac6f"
uuid = "79e6a3ab-5dfb-504d-930d-738a2a938a0e"
version = "3.4.0"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.AxisAlgorithms]]
deps = ["LinearAlgebra", "Random", "SparseArrays", "WoodburyMatrices"]
git-tree-sha1 = "66771c8d21c8ff5e3a93379480a2307ac36863f7"
uuid = "13072b0f-2c55-5437-9ae7-d433b7a33950"
version = "1.0.1"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.CSV]]
deps = ["CodecZlib", "Dates", "FilePathsBase", "InlineStrings", "Mmap", "Parsers", "PooledArrays", "SentinelArrays", "Tables", "Unicode", "WeakRefStrings"]
git-tree-sha1 = "873fb188a4b9d76549b81465b1f75c82aaf59238"
uuid = "336ed68f-0bac-5ca0-87d4-7b16caf5d00b"
version = "0.10.4"

[[deps.Calculus]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "f641eb0a4f00c343bbc32346e1217b86f3ce9dad"
uuid = "49dc2e85-a5d0-5ad3-a950-438e2897f1b9"
version = "0.5.1"

[[deps.CategoricalArrays]]
deps = ["DataAPI", "Future", "Missings", "Printf", "Requires", "Statistics", "Unicode"]
git-tree-sha1 = "5f5a975d996026a8dd877c35fe26a7b8179c02ba"
uuid = "324d7699-5711-5eae-9e2f-1d82baa6b597"
version = "0.10.6"

[[deps.ChainRulesCore]]
deps = ["Compat", "LinearAlgebra", "SparseArrays"]
git-tree-sha1 = "80ca332f6dcb2508adba68f22f551adb2d00a624"
uuid = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
version = "1.15.3"

[[deps.ChangesOfVariables]]
deps = ["ChainRulesCore", "LinearAlgebra", "Test"]
git-tree-sha1 = "38f7a08f19d8810338d4f5085211c7dfa5d5bdd8"
uuid = "9e997f8a-9a97-42d5-a9f1-ce6bfc15e2c0"
version = "0.1.4"

[[deps.CodecZlib]]
deps = ["TranscodingStreams", "Zlib_jll"]
git-tree-sha1 = "ded953804d019afa9a3f98981d99b33e3db7b6da"
uuid = "944b1d66-785c-5afd-91f1-9de20f533193"
version = "0.7.0"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "eb7f0f8307f71fac7c606984ea5fb2817275d6e4"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.4"

[[deps.Colors]]
deps = ["ColorTypes", "FixedPointNumbers", "Reexport"]
git-tree-sha1 = "417b0ed7b8b838aa6ca0a87aadf1bb9eb111ce40"
uuid = "5ae59095-9a9b-59fe-a467-6f913c188581"
version = "0.12.8"

[[deps.Compat]]
deps = ["Base64", "Dates", "DelimitedFiles", "Distributed", "InteractiveUtils", "LibGit2", "Libdl", "LinearAlgebra", "Markdown", "Mmap", "Pkg", "Printf", "REPL", "Random", "SHA", "Serialization", "SharedArrays", "Sockets", "SparseArrays", "Statistics", "Test", "UUIDs", "Unicode"]
git-tree-sha1 = "9be8be1d8a6f44b96482c8af52238ea7987da3e3"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "3.45.0"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"

[[deps.Compose]]
deps = ["Base64", "Colors", "DataStructures", "Dates", "IterTools", "JSON", "LinearAlgebra", "Measures", "Printf", "Random", "Requires", "Statistics", "UUIDs"]
git-tree-sha1 = "d853e57661ba3a57abcdaa201f4c9917a93487a2"
uuid = "a81c6b42-2e10-5240-aca2-a61377ecd94b"
version = "0.9.4"

[[deps.Contour]]
deps = ["StaticArrays"]
git-tree-sha1 = "9f02045d934dc030edad45944ea80dbd1f0ebea7"
uuid = "d38c429a-6771-53c6-b99e-75d170b6e991"
version = "0.5.7"

[[deps.CoupledFields]]
deps = ["LinearAlgebra", "Statistics", "StatsBase"]
git-tree-sha1 = "6c9671364c68c1158ac2524ac881536195b7e7bc"
uuid = "7ad07ef1-bdf2-5661-9d2b-286fd4296dac"
version = "0.2.0"

[[deps.Crayons]]
git-tree-sha1 = "249fe38abf76d48563e2f4556bebd215aa317e15"
uuid = "a8cc5b0e-0ffa-5ad4-8c14-923d3ee1735f"
version = "4.1.1"

[[deps.DataAPI]]
git-tree-sha1 = "fb5f5316dd3fd4c5e7c30a24d50643b73e37cd40"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.10.0"

[[deps.DataFrames]]
deps = ["Compat", "DataAPI", "Future", "InvertedIndices", "IteratorInterfaceExtensions", "LinearAlgebra", "Markdown", "Missings", "PooledArrays", "PrettyTables", "Printf", "REPL", "Reexport", "SortingAlgorithms", "Statistics", "TableTraits", "Tables", "Unicode"]
git-tree-sha1 = "daa21eb85147f72e41f6352a57fccea377e310a9"
uuid = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
version = "1.3.4"

[[deps.DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "d1fff3a548102f48987a52a2e0d114fa97d730f0"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.13"

[[deps.DataValueInterfaces]]
git-tree-sha1 = "bfc1187b79289637fa0ef6d4436ebdfe6905cbd6"
uuid = "e2d170a0-9d28-54be-80f0-106bbe20a464"
version = "1.0.0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.DelimitedFiles]]
deps = ["Mmap"]
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"

[[deps.DensityInterface]]
deps = ["InverseFunctions", "Test"]
git-tree-sha1 = "80c3e8639e3353e5d2912fb3a1916b8455e2494b"
uuid = "b429d917-457f-4dbc-8f4c-0cc954292b1d"
version = "0.4.0"

[[deps.Distances]]
deps = ["LinearAlgebra", "SparseArrays", "Statistics", "StatsAPI"]
git-tree-sha1 = "3258d0659f812acde79e8a74b11f17ac06d0ca04"
uuid = "b4f34e82-e78d-54a5-968a-f98e89d6e8f7"
version = "0.10.7"

[[deps.Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"

[[deps.Distributions]]
deps = ["ChainRulesCore", "DensityInterface", "FillArrays", "LinearAlgebra", "PDMats", "Printf", "QuadGK", "Random", "SparseArrays", "SpecialFunctions", "Statistics", "StatsBase", "StatsFuns", "Test"]
git-tree-sha1 = "aafa0665e3db0d3d0890cdc8191ea03dc279b042"
uuid = "31c24e10-a181-5473-b8eb-7969acd0382f"
version = "0.25.66"

[[deps.DocStringExtensions]]
deps = ["LibGit2"]
git-tree-sha1 = "b19534d1895d702889b219c382a6e18010797f0b"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.8.6"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"

[[deps.DualNumbers]]
deps = ["Calculus", "NaNMath", "SpecialFunctions"]
git-tree-sha1 = "5837a837389fccf076445fce071c8ddaea35a566"
uuid = "fa6b7ba4-c1ee-5f82-b5fc-ecf0adba8f74"
version = "0.6.8"

[[deps.FFTW]]
deps = ["AbstractFFTs", "FFTW_jll", "LinearAlgebra", "MKL_jll", "Preferences", "Reexport"]
git-tree-sha1 = "90630efff0894f8142308e334473eba54c433549"
uuid = "7a1cc6ca-52ef-59f5-83cd-3a7055c09341"
version = "1.5.0"

[[deps.FFTW_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "c6033cc3892d0ef5bb9cd29b7f2f0331ea5184ea"
uuid = "f5851436-0d7a-5f13-b9de-f02708fd171a"
version = "3.3.10+0"

[[deps.FilePathsBase]]
deps = ["Compat", "Dates", "Mmap", "Printf", "Test", "UUIDs"]
git-tree-sha1 = "129b104185df66e408edd6625d480b7f9e9823a0"
uuid = "48062228-2e41-5def-b9a4-89aafe57970f"
version = "0.9.18"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"

[[deps.FillArrays]]
deps = ["LinearAlgebra", "Random", "SparseArrays", "Statistics"]
git-tree-sha1 = "246621d23d1f43e3b9c368bf3b72b2331a27c286"
uuid = "1a297f60-69ca-5386-bcde-b61e274b549b"
version = "0.13.2"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

[[deps.Formatting]]
deps = ["Printf"]
git-tree-sha1 = "8339d61043228fdd3eb658d86c926cb282ae72a8"
uuid = "59287772-0a20-5a39-b81b-1366585eb4c0"
version = "0.4.2"

[[deps.Future]]
deps = ["Random"]
uuid = "9fa8497b-333b-5362-9e8d-4d0656e87820"

[[deps.Gadfly]]
deps = ["Base64", "CategoricalArrays", "Colors", "Compose", "Contour", "CoupledFields", "DataAPI", "DataStructures", "Dates", "Distributions", "DocStringExtensions", "Hexagons", "IndirectArrays", "IterTools", "JSON", "Juno", "KernelDensity", "LinearAlgebra", "Loess", "Measures", "Printf", "REPL", "Random", "Requires", "Showoff", "Statistics"]
git-tree-sha1 = "13b402ae74c0558a83c02daa2f3314ddb2d515d3"
uuid = "c91e804a-d5a3-530f-b6f0-dfbca275c004"
version = "1.3.4"

[[deps.Grisu]]
git-tree-sha1 = "53bb909d1151e57e2484c3d1b53e19552b887fb2"
uuid = "42e2da0e-8278-4e71-bc24-59509adca0fe"
version = "1.0.2"

[[deps.Hexagons]]
deps = ["Test"]
git-tree-sha1 = "de4a6f9e7c4710ced6838ca906f81905f7385fd6"
uuid = "a1b4810d-1bce-5fbd-ac56-80944d57a21f"
version = "0.2.0"

[[deps.HypergeometricFunctions]]
deps = ["DualNumbers", "LinearAlgebra", "OpenLibm_jll", "SpecialFunctions", "Test"]
git-tree-sha1 = "709d864e3ed6e3545230601f94e11ebc65994641"
uuid = "34004b35-14d8-5ef3-9330-4cdb6864b03a"
version = "0.3.11"

[[deps.IndirectArrays]]
git-tree-sha1 = "012e604e1c7458645cb8b436f8fba789a51b257f"
uuid = "9b13fd28-a010-5f03-acff-a1bbcff69959"
version = "1.0.0"

[[deps.InlineStrings]]
deps = ["Parsers"]
git-tree-sha1 = "d19f9edd8c34760dca2de2b503f969d8700ed288"
uuid = "842dd82b-1e85-43dc-bf29-5d0ee9dffc48"
version = "1.1.4"

[[deps.IntelOpenMP_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "d979e54b71da82f3a65b62553da4fc3d18c9004c"
uuid = "1d5cc7b8-4909-519e-a0f8-d0f5ad9712d0"
version = "2018.0.3+2"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.Interpolations]]
deps = ["Adapt", "AxisAlgorithms", "ChainRulesCore", "LinearAlgebra", "OffsetArrays", "Random", "Ratios", "Requires", "SharedArrays", "SparseArrays", "StaticArrays", "WoodburyMatrices"]
git-tree-sha1 = "23e651bbb8d00e9971015d0dd306b780edbdb6b9"
uuid = "a98d9a8b-a2ab-59e6-89dd-64a1c18fca59"
version = "0.14.3"

[[deps.InverseFunctions]]
deps = ["Test"]
git-tree-sha1 = "b3364212fb5d870f724876ffcd34dd8ec6d98918"
uuid = "3587e190-3f89-42d0-90ee-14403ec27112"
version = "0.1.7"

[[deps.InvertedIndices]]
git-tree-sha1 = "bee5f1ef5bf65df56bdd2e40447590b272a5471f"
uuid = "41ab1584-1d38-5bbf-9106-f11c6c58b48f"
version = "1.1.0"

[[deps.IrrationalConstants]]
git-tree-sha1 = "7fd44fd4ff43fc60815f8e764c0f352b83c49151"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.1.1"

[[deps.IterTools]]
git-tree-sha1 = "fa6287a4469f5e048d763df38279ee729fbd44e5"
uuid = "c8e1da08-722c-5040-9ed9-7db0dc04731e"
version = "1.4.0"

[[deps.IteratorInterfaceExtensions]]
git-tree-sha1 = "a3f24677c21f5bbe9d2a714f95dcd58337fb2856"
uuid = "82899510-4779-5014-852e-03e436cf321d"
version = "1.0.0"

[[deps.JLLWrappers]]
deps = ["Preferences"]
git-tree-sha1 = "abc9885a7ca2052a736a600f7fa66209f96506e1"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.4.1"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "3c837543ddb02250ef42f4738347454f95079d4e"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.3"

[[deps.Juno]]
deps = ["Base64", "Logging", "Media", "Profile"]
git-tree-sha1 = "07cb43290a840908a771552911a6274bc6c072c7"
uuid = "e5e0dc1b-0480-54bc-9374-aad01c23163d"
version = "0.8.4"

[[deps.KernelDensity]]
deps = ["Distributions", "DocStringExtensions", "FFTW", "Interpolations", "StatsBase"]
git-tree-sha1 = "9816b296736292a80b9a3200eb7fbb57aaa3917a"
uuid = "5ab0869b-81aa-558d-bb23-cbf5423bbe9b"
version = "0.6.5"

[[deps.LazyArtifacts]]
deps = ["Artifacts", "Pkg"]
uuid = "4af54fe1-eca0-43a8-85a7-787d91b784e3"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"

[[deps.LibGit2]]
deps = ["Base64", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.LinearAlgebra]]
deps = ["Libdl", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.Loess]]
deps = ["Distances", "LinearAlgebra", "Statistics"]
git-tree-sha1 = "46efcea75c890e5d820e670516dc156689851722"
uuid = "4345ca2d-374a-55d4-8d30-97f9976e7612"
version = "0.5.4"

[[deps.LogExpFunctions]]
deps = ["ChainRulesCore", "ChangesOfVariables", "DocStringExtensions", "InverseFunctions", "IrrationalConstants", "LinearAlgebra"]
git-tree-sha1 = "361c2b088575b07946508f135ac556751240091c"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "0.3.17"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.MKL_jll]]
deps = ["Artifacts", "IntelOpenMP_jll", "JLLWrappers", "LazyArtifacts", "Libdl", "Pkg"]
git-tree-sha1 = "e595b205efd49508358f7dc670a940c790204629"
uuid = "856f044c-d86e-5d09-b602-aeab76dc8ba7"
version = "2022.0.0+0"

[[deps.MacroTools]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "3d3e902b31198a27340d0bf00d6ac452866021cf"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.9"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"

[[deps.Measures]]
git-tree-sha1 = "e498ddeee6f9fdb4551ce855a46f54dbd900245f"
uuid = "442fdcdd-2543-5da2-b0f3-8c86c306513e"
version = "0.3.1"

[[deps.Media]]
deps = ["MacroTools", "Test"]
git-tree-sha1 = "75a54abd10709c01f1b86b84ec225d26e840ed58"
uuid = "e89f7d12-3494-54d1-8411-f7d8b9ae1f27"
version = "0.5.0"

[[deps.Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "bf210ce90b6c9eed32d25dbcae1ebc565df2687f"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.0.2"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"

[[deps.NaNMath]]
deps = ["OpenLibm_jll"]
git-tree-sha1 = "a7c3d1da1189a1c2fe843a3bfa04d18d20eb3211"
uuid = "77ba4419-2d1f-58cd-9bb1-8ffee604a2e3"
version = "1.0.1"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"

[[deps.OffsetArrays]]
deps = ["Adapt"]
git-tree-sha1 = "1ea784113a6aa054c5ebd95945fa5e52c2f378e7"
uuid = "6fe1bfb0-de20-5000-8ca7-80f57d26f881"
version = "1.12.7"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"

[[deps.OpenLibm_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "05823500-19ac-5b8b-9628-191a04bc5112"

[[deps.OpenSpecFun_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "13652491f6856acfd2db29360e1bbcd4565d04f1"
uuid = "efe28fd5-8261-553b-a9e1-b2916fc3738e"
version = "0.5.5+0"

[[deps.OrderedCollections]]
git-tree-sha1 = "85f8e6578bf1f9ee0d11e7bb1b1456435479d47c"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.4.1"

[[deps.PDMats]]
deps = ["LinearAlgebra", "SparseArrays", "SuiteSparse"]
git-tree-sha1 = "cf494dca75a69712a72b80bc48f59dcf3dea63ec"
uuid = "90014a1f-27ba-587c-ab20-58faa44d9150"
version = "0.11.16"

[[deps.Parsers]]
deps = ["Dates"]
git-tree-sha1 = "0044b23da09b5608b4ecacb4e5e6c6332f833a7e"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.3.2"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"

[[deps.PooledArrays]]
deps = ["DataAPI", "Future"]
git-tree-sha1 = "a6062fe4063cdafe78f4a0a81cfffb89721b30e7"
uuid = "2dfb63ee-cc39-5dd5-95bd-886bf059d720"
version = "1.4.2"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "47e5f437cc0e7ef2ce8406ce1e7e24d44915f88d"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.3.0"

[[deps.PrettyTables]]
deps = ["Crayons", "Formatting", "Markdown", "Reexport", "Tables"]
git-tree-sha1 = "dfb54c4e414caa595a1f2ed759b160f5a3ddcba5"
uuid = "08abe8d2-0d0c-5749-adfa-8a2ac140af0d"
version = "1.3.1"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.Profile]]
deps = ["Printf"]
uuid = "9abbd945-dff8-562f-b5e8-e1ebf5ef1b79"

[[deps.QuadGK]]
deps = ["DataStructures", "LinearAlgebra"]
git-tree-sha1 = "78aadffb3efd2155af139781b8a8df1ef279ea39"
uuid = "1fd47b50-473d-5c70-9696-f719f8f3bcdc"
version = "2.4.2"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA", "Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.Ratios]]
deps = ["Requires"]
git-tree-sha1 = "dc84268fe0e3335a62e315a3a7cf2afa7178a734"
uuid = "c84ed2f1-dad5-54f0-aa8e-dbefe2724439"
version = "0.4.3"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "838a3a4188e2ded87a4f9f184b4b0d78a1e91cb7"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.0"

[[deps.Rmath]]
deps = ["Random", "Rmath_jll"]
git-tree-sha1 = "bf3188feca147ce108c76ad82c2792c57abe7b1f"
uuid = "79098fc4-a85e-5d69-aa6a-4863f24498fa"
version = "0.7.0"

[[deps.Rmath_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "68db32dff12bb6127bac73c209881191bf0efbb7"
uuid = "f50d1b31-88e8-58de-be2c-1cc44531875f"
version = "0.3.0+0"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"

[[deps.SentinelArrays]]
deps = ["Dates", "Random"]
git-tree-sha1 = "db8481cf5d6278a121184809e9eb1628943c7704"
uuid = "91c51154-3ec4-41a3-a24f-3f23e20d615c"
version = "1.3.13"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.SharedArrays]]
deps = ["Distributed", "Mmap", "Random", "Serialization"]
uuid = "1a1011a3-84de-559e-8e89-a11a2f7dc383"

[[deps.Showoff]]
deps = ["Dates", "Grisu"]
git-tree-sha1 = "91eddf657aca81df9ae6ceb20b959ae5653ad1de"
uuid = "992d4aef-0814-514b-bc4d-f2e9a6c4116f"
version = "1.0.3"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SortingAlgorithms]]
deps = ["DataStructures"]
git-tree-sha1 = "b3363d7460f7d098ca0912c69b082f75625d7508"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.0.1"

[[deps.SparseArrays]]
deps = ["LinearAlgebra", "Random"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.SpecialFunctions]]
deps = ["ChainRulesCore", "IrrationalConstants", "LogExpFunctions", "OpenLibm_jll", "OpenSpecFun_jll"]
git-tree-sha1 = "d75bda01f8c31ebb72df80a46c88b25d1c79c56d"
uuid = "276daf66-3868-5448-9aa4-cd146d93841b"
version = "2.1.7"

[[deps.StaticArrays]]
deps = ["LinearAlgebra", "Random", "StaticArraysCore", "Statistics"]
git-tree-sha1 = "23368a3313d12a2326ad0035f0db0c0966f438ef"
uuid = "90137ffa-7385-5640-81b9-e52037218182"
version = "1.5.2"

[[deps.StaticArraysCore]]
git-tree-sha1 = "66fe9eb253f910fe8cf161953880cfdaef01cdf0"
uuid = "1e83bf80-4336-4d27-bf5d-d5a4f845583c"
version = "1.0.1"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[deps.StatsAPI]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "f9af7f195fb13589dd2e2d57fdb401717d2eb1f6"
uuid = "82ae8749-77ed-4fe6-ae5f-f523153014b0"
version = "1.5.0"

[[deps.StatsBase]]
deps = ["DataAPI", "DataStructures", "LinearAlgebra", "LogExpFunctions", "Missings", "Printf", "Random", "SortingAlgorithms", "SparseArrays", "Statistics", "StatsAPI"]
git-tree-sha1 = "0005d75f43ff23688914536c5e9d5ac94f8077f7"
uuid = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
version = "0.33.20"

[[deps.StatsFuns]]
deps = ["ChainRulesCore", "HypergeometricFunctions", "InverseFunctions", "IrrationalConstants", "LogExpFunctions", "Reexport", "Rmath", "SpecialFunctions"]
git-tree-sha1 = "5783b877201a82fc0014cbf381e7e6eb130473a4"
uuid = "4c63d2b9-4356-54db-8cca-17b64c39e42c"
version = "1.0.1"

[[deps.SuiteSparse]]
deps = ["Libdl", "LinearAlgebra", "Serialization", "SparseArrays"]
uuid = "4607b0f0-06f3-5cda-b6b1-a6196a1729e9"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"

[[deps.TableTraits]]
deps = ["IteratorInterfaceExtensions"]
git-tree-sha1 = "c06b2f539df1c6efa794486abfb6ed2022561a39"
uuid = "3783bdb8-4a98-5b6b-af9a-565f29a5fe9c"
version = "1.0.1"

[[deps.Tables]]
deps = ["DataAPI", "DataValueInterfaces", "IteratorInterfaceExtensions", "LinearAlgebra", "OrderedCollections", "TableTraits", "Test"]
git-tree-sha1 = "5ce79ce186cc678bbb5c5681ca3379d1ddae11a1"
uuid = "bd369af6-aec1-5ad0-b16a-f7cc5008161c"
version = "1.7.0"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.TranscodingStreams]]
deps = ["Random", "Test"]
git-tree-sha1 = "216b95ea110b5972db65aa90f88d8d89dcb8851c"
uuid = "3bb67fe8-82b1-5028-8e26-92a6c54297fa"
version = "0.9.6"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.WeakRefStrings]]
deps = ["DataAPI", "InlineStrings", "Parsers"]
git-tree-sha1 = "b1be2855ed9ed8eac54e5caff2afcdb442d52c23"
uuid = "ea10d353-3f73-51f8-a26c-33c1cb351aa5"
version = "1.4.2"

[[deps.WoodburyMatrices]]
deps = ["LinearAlgebra", "SparseArrays"]
git-tree-sha1 = "de67fa59e33ad156a590055375a30b23c40299d3"
uuid = "efce3f68-66dc-5838-9240-27a6d6f5f9b6"
version = "0.5.5"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl", "OpenBLAS_jll"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
"""

# ╔═╡ Cell order:
# ╟─f8b9fec9-f521-4069-86ad-a302dc4024ff
# ╟─ad83c1bf-8343-4ede-9c96-b7fd2218b8ff
# ╟─4c253e1c-005b-499c-88be-313d88323844
# ╟─bad52c6c-0239-4ae7-a947-310e5bbd176a
# ╟─72db4913-d3f8-4075-9b10-dac79e59a4c7
# ╠═15a747b5-d2e4-432d-8991-9f78e19643a5
# ╟─6b7dbe09-dd76-4421-ba9a-13233ac3230e
# ╠═3d0f4384-c15c-42dd-a43e-8f71aaad5410
# ╠═aa052c19-53eb-479f-8c8c-193192080c92
# ╟─021ee57d-033d-449b-8e41-ead465c2d4e8
# ╠═2c36c2d9-9639-48bb-9e23-60679f1d85b7
# ╠═7f347746-468a-4970-90d2-b128c8d6b5c9
# ╟─52fb5c53-8d06-4574-a302-7d8df13ca7b8
# ╠═ec9c54b7-c417-4233-a06f-807bd560c97d
# ╠═3eeb39cf-c3e9-4a79-a21b-1088a1d39174
# ╟─02b4711d-53fc-4ddb-9c0f-8eb50405a647
# ╠═a426a09a-7f7f-4b50-b135-e1a0b40f35eb
# ╠═8f1e7c0d-202c-419f-95da-bb8e5277ac42
# ╟─efab7b0c-9b7b-4646-913c-2316a0c35768
# ╠═db7717b1-69eb-45e0-b65d-1c6f0edf75e6
# ╟─cd1e0571-f90a-4ff9-b79f-662a0b283347
# ╟─0a5d936e-06da-499b-aed8-b76afae5b25b
# ╠═4a0f5288-0947-49bb-bdfb-caf1c6e1bf54
# ╠═dc042ab5-e98e-407a-9980-538af0be5371
# ╟─aa79699b-b573-4b86-8b71-e059510bb3b2
# ╠═0c215d3a-bd91-4106-98c3-7da7a3f6a503
# ╠═00c10302-797b-473f-a9c0-2fb851620836
# ╟─2bce8bc8-7ddb-493b-b5ae-bf9cca98fbf6
# ╠═0aa72455-4c59-4529-b916-1a6ac7f3e021
# ╠═0f8e51e6-d162-478c-ae81-922d701a5871
# ╟─d3fd6cae-a2dc-44aa-9546-3ef661d376cc
# ╠═ac720c44-7615-4491-aa70-c810ef9ceca9
# ╠═8e3a1a8b-4475-496a-a5b7-ed7456806eeb
# ╟─c6b35c28-7b52-46b4-ade9-9293160b5ac9
# ╠═962116e4-aa18-4454-8a0c-450c13485d1d
# ╠═09ac1d33-6cf7-4bed-a16b-76a5e612e74d
# ╟─7d9665c4-11a8-43a6-8345-3d28cf89f176
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
