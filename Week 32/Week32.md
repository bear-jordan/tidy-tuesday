---
title: "Week 32 - Ferris Wheels"
output: hugodown::md_document
author: "Bear Jordan"
date: "2022-08-09"
rmd_hash: 768eef6768a40d54

---

## Ferris Wheels

For this week, I want to ask did the development of ferris wheels in one country effect the development of ferris wheels in another country?

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>wheels</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://rdrr.io/r/utils/read.table.html'>read.csv</a></span><span class='o'>(</span><span class='s'>"wheels.csv"</span><span class='o'>)</span></span>
<span><span class='nf'><a href='https://rdrr.io/r/utils/head.html'>head</a></span><span class='o'>(</span><span class='nv'>wheels</span><span class='o'>)</span></span><span><span class='c'>#&gt;   X                name height diameter     opened     closed country</span></span>
<span><span class='c'>#&gt; 1 1 360 Pensacola Beach 200.00       NA 2012-07-03 2013-01-01     USA</span></span>
<span><span class='c'>#&gt; 2 2              Amuran 303.00    199.8 2004-01-01       &lt;NA&gt;   Japan</span></span>
<span><span class='c'>#&gt; 3 3       Asiatique Sky 200.00    200.0 2012-12-15       &lt;NA&gt; Tailand</span></span>
<span><span class='c'>#&gt; 4 4        Aurora Wheel 295.00    272.0       &lt;NA&gt;       &lt;NA&gt;   Japan</span></span>
<span><span class='c'>#&gt; 5 5         Baghdad Eye 180.00       NA 2011-01-01       &lt;NA&gt;    Iraq</span></span>
<span><span class='c'>#&gt; 6 6 Beijing Great Wheel 692.64    642.7       &lt;NA&gt;       &lt;NA&gt;   China</span></span>
<span><span class='c'>#&gt;                          location number_of_cabins passengers_per_cabin</span></span>
<span><span class='c'>#&gt; 1        Pensacola Beach; Florida               42                    6</span></span>
<span><span class='c'>#&gt; 2               Kagoshima; Kyushu               36                   NA</span></span>
<span><span class='c'>#&gt; 3        Asiatique the Riverfront               42                   NA</span></span>
<span><span class='c'>#&gt; 4 Nagashima Spa Land; Mie; Honshu               NA                   NA</span></span>
<span><span class='c'>#&gt; 5         Al-Zawraa Park; Baghdad               40                    6</span></span>
<span><span class='c'>#&gt; 6          Chaoyang Park; Beijing               48                   40</span></span>
<span><span class='c'>#&gt;   seating_capacity hourly_capacity ride_duration_minutes climate_controlled</span></span>
<span><span class='c'>#&gt; 1              252            1260                  12.0                Yes</span></span>
<span><span class='c'>#&gt; 2               NA              NA                  14.5                Yes</span></span>
<span><span class='c'>#&gt; 3               NA              NA                    NA                Yes</span></span>
<span><span class='c'>#&gt; 4               NA              NA                    NA               &lt;NA&gt;</span></span>
<span><span class='c'>#&gt; 5              240             960                  15.0               &lt;NA&gt;</span></span>
<span><span class='c'>#&gt; 6             1920            5760                  20.0                yes</span></span>
<span><span class='c'>#&gt;   construction_cost    status         design_manufacturer          type</span></span>
<span><span class='c'>#&gt; 1           Unknown     Moved        Realty Masters of FL Transportable</span></span>
<span><span class='c'>#&gt; 2           Unknown Operating                        &lt;NA&gt;          &lt;NA&gt;</span></span>
<span><span class='c'>#&gt; 3           Unknown Operating       Dutch Wheels (Vekoma)          &lt;NA&gt;</span></span>
<span><span class='c'>#&gt; 4           Unknown Operating                        &lt;NA&gt;         Fixed</span></span>
<span><span class='c'>#&gt; 5    $6 million USD Operating                        &lt;NA&gt;          &lt;NA&gt;</span></span>
<span><span class='c'>#&gt; 6  $290 million USD   Delayed The Great Wheel Corporation         Fixed</span></span>
<span><span class='c'>#&gt;   vip_area ticket_cost_to_ride                  official_website turns</span></span>
<span><span class='c'>#&gt; 1      Yes                &lt;NA&gt;                              &lt;NA&gt;     4</span></span>
<span><span class='c'>#&gt; 2     &lt;NA&gt;                &lt;NA&gt;                              &lt;NA&gt;     1</span></span>
<span><span class='c'>#&gt; 3     &lt;NA&gt;                &lt;NA&gt;      http://www.asiatiquesky.com/    NA</span></span>
<span><span class='c'>#&gt; 4     &lt;NA&gt;                &lt;NA&gt; http://www.nagashima-onsen.co.jp/    NA</span></span>
<span><span class='c'>#&gt; 5     &lt;NA&gt;                 3.5                              &lt;NA&gt;    NA</span></span>
<span><span class='c'>#&gt; 6     &lt;NA&gt;                &lt;NA&gt;                              &lt;NA&gt;     1</span></span></code></pre>

</div>

## Data Selection and EDA

Here is the data I plan to use for the figure.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>figure_data</span> <span class='o'>&lt;-</span> <span class='nv'>wheels</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span> </span>
<span>  <span class='nf'><a href='https://dplyr.tidyverse.org/reference/select.html'>select</a></span><span class='o'>(</span><span class='nv'>country</span>, <span class='nv'>opened</span>, <span class='nv'>name</span>, <span class='nv'>seating_capacity</span>, <span class='nv'>status</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span> </span>
<span>  <span class='nf'><a href='https://tidyr.tidyverse.org/reference/drop_na.html'>drop_na</a></span><span class='o'>(</span><span class='o'>)</span></span>
<span><span class='nf'><a href='https://rdrr.io/r/utils/head.html'>head</a></span><span class='o'>(</span><span class='nv'>figure_data</span><span class='o'>)</span></span><span><span class='c'>#&gt;   country     opened                  name seating_capacity    status</span></span>
<span><span class='c'>#&gt; 1     USA 2012-07-03   360 Pensacola Beach              252     Moved</span></span>
<span><span class='c'>#&gt; 2    Iraq 2011-01-01           Baghdad Eye              240 Operating</span></span>
<span><span class='c'>#&gt; 3 Ireland 2007-01-01         Belfast Wheel              336   Defunct</span></span>
<span><span class='c'>#&gt; 4      UK 2011-10-24        Brighton Wheel              288 Operating</span></span>
<span><span class='c'>#&gt; 5   China 2004-10-01 Changsha Ferris Wheel              384 Operating</span></span>
<span><span class='c'>#&gt; 6     USA 1893-01-01         Chicago Wheel              720   Defunct</span></span></code></pre>

</div>

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>figure_data</span><span class='o'>$</span><span class='nv'>opened</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://rdrr.io/r/base/as.Date.html'>as.Date</a></span><span class='o'>(</span><span class='nv'>figure_data</span><span class='o'>$</span><span class='nv'>opened</span><span class='o'>)</span></span>
<span><span class='nv'>figure_data</span><span class='o'>$</span><span class='nv'>country</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://rdrr.io/r/base/factor.html'>as.factor</a></span><span class='o'>(</span><span class='nv'>figure_data</span><span class='o'>$</span><span class='nv'>country</span><span class='o'>)</span></span></code></pre>

</div>

As a sanity check, I expect the capactity to increase through time.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://rdrr.io/r/graphics/plot.default.html'>plot</a></span><span class='o'>(</span>x<span class='o'>=</span><span class='nv'>figure_data</span><span class='o'>$</span><span class='nv'>opened</span>,</span>
<span>     y<span class='o'>=</span><span class='nv'>figure_data</span><span class='o'>$</span><span class='nv'>seating_capacity</span>,</span>
<span>     main<span class='o'>=</span><span class='s'>"Does seating capacity increase?"</span>,</span>
<span>     xlab<span class='o'>=</span><span class='s'>""</span>,</span>
<span>     ylab<span class='o'>=</span><span class='s'>"Seating Capacity"</span>,</span>
<span>     las<span class='o'>=</span><span class='m'>1</span><span class='o'>)</span></span></code></pre>
<img src="figs/hyp_test-1.png" width="700px" style="display: block; margin: auto;" />

</div>

Interesting, I wonder what happened in the earlier years.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>figure_data</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span> </span>
<span>  <span class='nf'><a href='https://dplyr.tidyverse.org/reference/filter.html'>filter</a></span><span class='o'>(</span><span class='nv'>opened</span><span class='o'>&lt;</span><span class='s'>"1910-01-01"</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span> </span>
<span>  <span class='nf'><a href='https://dplyr.tidyverse.org/reference/filter.html'>filter</a></span><span class='o'>(</span><span class='nv'>seating_capacity</span><span class='o'>&gt;</span><span class='m'>750</span><span class='o'>)</span></span><span><span class='c'>#&gt;   country     opened        name seating_capacity  status</span></span>
<span><span class='c'>#&gt; 1      UK 1895-07-17 Great Wheel             1600 Defunct</span></span></code></pre>

</div>

The Great Wheel sounds wild---it was built in London after the sucess of the Chicago Ferris Wheel. No big horror stories it looks like though.

## Figure Construction

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ggplot2.tidyverse.org/reference/ggplot.html'>ggplot</a></span><span class='o'>(</span><span class='nf'><a href='https://ggplot2.tidyverse.org/reference/aes.html'>aes</a></span><span class='o'>(</span>x<span class='o'>=</span><span class='nv'>opened</span>, y<span class='o'>=</span><span class='nv'>country</span>, size<span class='o'>=</span><span class='nv'>seating_capacity</span><span class='o'>)</span>, data<span class='o'>=</span><span class='nv'>figure_data</span><span class='o'>)</span> <span class='o'>+</span></span>
<span>  <span class='nf'><a href='https://ggplot2.tidyverse.org/reference/geom_point.html'>geom_point</a></span><span class='o'>(</span>alpha<span class='o'>=</span><span class='m'>.3</span>, stroke<span class='o'>=</span><span class='m'>.8</span><span class='o'>)</span> <span class='o'>+</span></span>
<span>  <span class='nf'><a href='https://ggplot2.tidyverse.org/reference/geom_path.html'>geom_line</a></span><span class='o'>(</span>size<span class='o'>=</span><span class='m'>.4</span><span class='o'>)</span></span></code></pre>
<img src="figs/plot_1-1.png" width="700px" style="display: block; margin: auto;" />

</div>

Well, this won't do. I want to sort these by the length of the line. And there is way to much empty space. I will try filtering the data again to only focus on things past 1950. I am just going to select countries with more than one ferris wheel too.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://rdrr.io/r/base/print.html'>print</a></span><span class='o'>(</span><span class='nf'><a href='https://rdrr.io/r/base/unique.html'>unique</a></span><span class='o'>(</span><span class='nv'>figure_data</span><span class='o'>$</span><span class='nv'>country</span><span class='o'>)</span><span class='o'>)</span></span><span><span class='c'>#&gt;  [1] USA          Iraq         Ireland      UK           China       </span></span>
<span><span class='c'>#&gt;  [6] Japan        Turkmenistan UAE          Malaysia     Finland     </span></span>
<span><span class='c'>#&gt; [11] Phillippines Taiwan       Russia       Canada       France      </span></span>
<span><span class='c'>#&gt; [16] Singapore    Mexico       Australia   </span></span>
<span><span class='c'>#&gt; 18 Levels: Australia Canada China Finland France Iraq Ireland ... USA</span></span><span><span class='nv'>country_filter</span> <span class='o'>&lt;-</span> <span class='nv'>figure_data</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span> </span>
<span>  <span class='nf'><a href='https://dplyr.tidyverse.org/reference/count.html'>count</a></span><span class='o'>(</span><span class='nv'>country</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span> </span>
<span>  <span class='nf'><a href='https://dplyr.tidyverse.org/reference/filter.html'>filter</a></span><span class='o'>(</span><span class='nv'>n</span><span class='o'>!=</span><span class='m'>1</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span> </span>
<span>  <span class='nf'><a href='https://dplyr.tidyverse.org/reference/select.html'>select</a></span><span class='o'>(</span><span class='nv'>country</span><span class='o'>)</span></span>
<span></span>
<span><span class='nv'>country_filter</span> <span class='o'>&lt;-</span> <span class='nv'>country_filter</span><span class='o'>$</span><span class='nv'>country</span></span>
<span></span>
<span><span class='nv'>figure_data</span> <span class='o'>&lt;-</span> <span class='nv'>figure_data</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span> </span>
<span>  <span class='nf'><a href='https://dplyr.tidyverse.org/reference/filter.html'>filter</a></span><span class='o'>(</span><span class='nv'>opened</span><span class='o'>&gt;</span><span class='s'>"1955-01-01"</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span> </span>
<span>  <span class='nf'><a href='https://dplyr.tidyverse.org/reference/filter.html'>filter</a></span><span class='o'>(</span><span class='nv'>country</span> <span class='o'><a href='https://rdrr.io/r/base/match.html'>%in%</a></span> <span class='nv'>country_filter</span><span class='o'>)</span></span></code></pre>

</div>

Okay, try this again.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ggplot2.tidyverse.org/reference/ggplot.html'>ggplot</a></span><span class='o'>(</span><span class='nf'><a href='https://ggplot2.tidyverse.org/reference/aes.html'>aes</a></span><span class='o'>(</span>x<span class='o'>=</span><span class='nv'>opened</span>, y<span class='o'>=</span><span class='nv'>country</span>, size<span class='o'>=</span><span class='nv'>seating_capacity</span><span class='o'>)</span>, data<span class='o'>=</span><span class='nv'>figure_data</span><span class='o'>)</span> <span class='o'>+</span></span>
<span>  <span class='nf'><a href='https://ggplot2.tidyverse.org/reference/geom_point.html'>geom_point</a></span><span class='o'>(</span>alpha<span class='o'>=</span><span class='m'>.3</span>, stroke<span class='o'>=</span><span class='m'>.8</span><span class='o'>)</span> <span class='o'>+</span></span>
<span>  <span class='nf'><a href='https://ggplot2.tidyverse.org/reference/geom_path.html'>geom_line</a></span><span class='o'>(</span>size<span class='o'>=</span><span class='m'>.4</span><span class='o'>)</span></span></code></pre>
<img src="figs/plot_2-1.png" width="700px" style="display: block; margin: auto;" />

</div>

Better maybe I will sort decending by the most recent ferris wheel.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>plot_order</span> <span class='o'>&lt;-</span> <span class='nv'>figure_data</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span> </span>
<span>  <span class='nf'><a href='https://dplyr.tidyverse.org/reference/group_by.html'>group_by</a></span><span class='o'>(</span><span class='nv'>country</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span> </span>
<span>  <span class='nf'><a href='https://dplyr.tidyverse.org/reference/top_n.html'>top_n</a></span><span class='o'>(</span><span class='m'>1</span>, <span class='nv'>opened</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span> </span>
<span>  <span class='nf'><a href='https://dplyr.tidyverse.org/reference/arrange.html'>arrange</a></span><span class='o'>(</span><span class='nv'>opened</span><span class='o'>)</span></span>
<span></span>
<span><span class='nv'>plot_order</span> <span class='o'>&lt;-</span> <span class='nv'>plot_order</span><span class='o'>$</span><span class='nv'>country</span></span>
<span></span>
<span><span class='nv'>figure_data</span><span class='o'>$</span><span class='nv'>country</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://rdrr.io/r/base/factor.html'>factor</a></span><span class='o'>(</span><span class='nv'>figure_data</span><span class='o'>$</span><span class='nv'>country</span>, levels <span class='o'>=</span> <span class='nv'>plot_order</span><span class='o'>)</span></span></code></pre>

</div>

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ggplot2.tidyverse.org/reference/ggplot.html'>ggplot</a></span><span class='o'>(</span><span class='nf'><a href='https://ggplot2.tidyverse.org/reference/aes.html'>aes</a></span><span class='o'>(</span>x<span class='o'>=</span><span class='nv'>opened</span>, y<span class='o'>=</span><span class='nv'>country</span>, size<span class='o'>=</span><span class='nv'>seating_capacity</span>, color<span class='o'>=</span><span class='nv'>status</span><span class='o'>)</span>, data<span class='o'>=</span><span class='nv'>figure_data</span><span class='o'>)</span> <span class='o'>+</span></span>
<span>  <span class='nf'><a href='https://ggplot2.tidyverse.org/reference/geom_point.html'>geom_point</a></span><span class='o'>(</span>alpha<span class='o'>=</span><span class='m'>.3</span>, stroke<span class='o'>=</span><span class='m'>.8</span><span class='o'>)</span> <span class='o'>+</span></span>
<span>  <span class='nf'><a href='https://ggplot2.tidyverse.org/reference/geom_path.html'>geom_line</a></span><span class='o'>(</span>size<span class='o'>=</span><span class='m'>.4</span><span class='o'>)</span></span></code></pre>
<img src="figs/plot_3-1.png" width="700px" style="display: block; margin: auto;" />

</div>

Okay, it seems crazy... does japan have one being built?

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>wheels</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span> </span>
<span>  <span class='nf'><a href='https://dplyr.tidyverse.org/reference/filter.html'>filter</a></span><span class='o'>(</span><span class='nv'>country</span><span class='o'>==</span><span class='s'>"Japan"</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span> </span>
<span>  <span class='nf'><a href='https://dplyr.tidyverse.org/reference/arrange.html'>arrange</a></span><span class='o'>(</span><span class='nv'>opened</span><span class='o'>)</span></span><span><span class='c'>#&gt;     X                            name height diameter     opened closed country</span></span>
<span><span class='c'>#&gt; 1  49            Shining Flower Wheel 164.04   147.64 1966-01-01   &lt;NA&gt;   Japan</span></span>
<span><span class='c'>#&gt; 2  63                      Technostar 279.00   274.00 1985-01-01   &lt;NA&gt;   Japan</span></span>
<span><span class='c'>#&gt; 3  56                       Space Eye 328.00       NA 1990-01-01   &lt;NA&gt;   Japan</span></span>
<span><span class='c'>#&gt; 4  64           Tempozan Ferris Wheel 369.00   330.00 1997-07-12   &lt;NA&gt;   Japan</span></span>
<span><span class='c'>#&gt; 5  27                  HEP Five Wheel 347.77   246.06 1998-01-01   &lt;NA&gt;   Japan</span></span>
<span><span class='c'>#&gt; 6  14                    Daikanransha 377.00   328.00 1999-01-01   &lt;NA&gt;   Japan</span></span>
<span><span class='c'>#&gt; 7  13                  Cosmo Clock 21 369.00   328.00 1999-03-18   &lt;NA&gt;   Japan</span></span>
<span><span class='c'>#&gt; 8  15 Diamond and Flower Ferris Wheel 384.00   364.17 2001-01-01   &lt;NA&gt;   Japan</span></span>
<span><span class='c'>#&gt; 9  51               Sky Dream Fukuoka 394.00   361.00 2001-01-01   &lt;NA&gt;   Japan</span></span>
<span><span class='c'>#&gt; 10  2                          Amuran 303.00   199.80 2004-01-01   &lt;NA&gt;   Japan</span></span>
<span><span class='c'>#&gt; 11  8                           Big O 197.00   200.00 2006-01-01   &lt;NA&gt;   Japan</span></span>
<span><span class='c'>#&gt; 12 41                     Nippon Moon     NA       NA 2015-01-01   &lt;NA&gt;   Japan</span></span>
<span><span class='c'>#&gt; 13  4                    Aurora Wheel 295.00   272.00       &lt;NA&gt;   &lt;NA&gt;   Japan</span></span>
<span><span class='c'>#&gt;                            location number_of_cabins passengers_per_cabin</span></span>
<span><span class='c'>#&gt; 1                      Inagi; Tokyo               32                    2</span></span>
<span><span class='c'>#&gt; 2                  Tsukuba; Ibaraki               48                    8</span></span>
<span><span class='c'>#&gt; 3           Space World; Kitakyushu               NA                   NA</span></span>
<span><span class='c'>#&gt; 4                     Osaka; Honshu               60                    8</span></span>
<span><span class='c'>#&gt; 5  HEP Five building; Osaka; Honshu               52                    4</span></span>
<span><span class='c'>#&gt; 6              Palette Town; Odaiba               64                    6</span></span>
<span><span class='c'>#&gt; 7         Minato Mirai 21; Yokohama               60                    8</span></span>
<span><span class='c'>#&gt; 8          Kasai Rinkai Park; Tokyo               68                    6</span></span>
<span><span class='c'>#&gt; 9        Evergreen Marinoa; Fukuoka               NA                   NA</span></span>
<span><span class='c'>#&gt; 10                Kagoshima; Kyushu               36                   NA</span></span>
<span><span class='c'>#&gt; 11                  Tokyo Dome City               NA                   NA</span></span>
<span><span class='c'>#&gt; 12                             &lt;NA&gt;               32                   NA</span></span>
<span><span class='c'>#&gt; 13  Nagashima Spa Land; Mie; Honshu               NA                   NA</span></span>
<span><span class='c'>#&gt;    seating_capacity hourly_capacity ride_duration_minutes climate_controlled</span></span>
<span><span class='c'>#&gt; 1                64             349                  11.0               &lt;NA&gt;</span></span>
<span><span class='c'>#&gt; 2               384            1536                  15.0                Yes</span></span>
<span><span class='c'>#&gt; 3                NA              NA                    NA               &lt;NA&gt;</span></span>
<span><span class='c'>#&gt; 4               480            1920                  15.0               &lt;NA&gt;</span></span>
<span><span class='c'>#&gt; 5               208             832                  15.0                Yes</span></span>
<span><span class='c'>#&gt; 6               384            1440                  16.0               &lt;NA&gt;</span></span>
<span><span class='c'>#&gt; 7               480            1920                  15.0               &lt;NA&gt;</span></span>
<span><span class='c'>#&gt; 8               408            1440                  17.0                Yes</span></span>
<span><span class='c'>#&gt; 9                NA              NA                  20.0                Yes</span></span>
<span><span class='c'>#&gt; 10               NA              NA                  14.5                Yes</span></span>
<span><span class='c'>#&gt; 11               NA              NA                  15.0                Yes</span></span>
<span><span class='c'>#&gt; 12               NA              NA                  40.0                Yes</span></span>
<span><span class='c'>#&gt; 13               NA              NA                    NA               &lt;NA&gt;</span></span>
<span><span class='c'>#&gt;    construction_cost           status design_manufacturer       type vip_area</span></span>
<span><span class='c'>#&gt; 1            Unknown        Operating                &lt;NA&gt;       &lt;NA&gt;     &lt;NA&gt;</span></span>
<span><span class='c'>#&gt; 2            Unknown          Defunct                &lt;NA&gt;       &lt;NA&gt;     &lt;NA&gt;</span></span>
<span><span class='c'>#&gt; 3            Unknown        Operating                &lt;NA&gt;      Fixed     &lt;NA&gt;</span></span>
<span><span class='c'>#&gt; 4            Unknown        Operating                &lt;NA&gt;      Fixed     &lt;NA&gt;</span></span>
<span><span class='c'>#&gt; 5            Unknown        Operating                &lt;NA&gt;       &lt;NA&gt;     &lt;NA&gt;</span></span>
<span><span class='c'>#&gt; 6            Unknown        Operating                &lt;NA&gt;      Fixed     &lt;NA&gt;</span></span>
<span><span class='c'>#&gt; 7            Unknown        Operating                &lt;NA&gt;      Fixed     &lt;NA&gt;</span></span>
<span><span class='c'>#&gt; 8            Unknown        Operating               Senyo      Fixed     &lt;NA&gt;</span></span>
<span><span class='c'>#&gt; 9            Unknown        Relocated                &lt;NA&gt;      Fixed     &lt;NA&gt;</span></span>
<span><span class='c'>#&gt; 10           Unknown        Operating                &lt;NA&gt;       &lt;NA&gt;     &lt;NA&gt;</span></span>
<span><span class='c'>#&gt; 11           Unknown        Operating                &lt;NA&gt; Centerless     &lt;NA&gt;</span></span>
<span><span class='c'>#&gt; 12           Unknown Design/Financing            UNStudio      Fixed      Yes</span></span>
<span><span class='c'>#&gt; 13           Unknown        Operating                &lt;NA&gt;      Fixed     &lt;NA&gt;</span></span>
<span><span class='c'>#&gt;    ticket_cost_to_ride</span></span>
<span><span class='c'>#&gt; 1                 4.97</span></span>
<span><span class='c'>#&gt; 2                 &lt;NA&gt;</span></span>
<span><span class='c'>#&gt; 3                 &lt;NA&gt;</span></span>
<span><span class='c'>#&gt; 4                 6.97</span></span>
<span><span class='c'>#&gt; 5                 4.94</span></span>
<span><span class='c'>#&gt; 6                 8.87</span></span>
<span><span class='c'>#&gt; 7                 6.93</span></span>
<span><span class='c'>#&gt; 8                 6.93</span></span>
<span><span class='c'>#&gt; 9                 4.97</span></span>
<span><span class='c'>#&gt; 10                &lt;NA&gt;</span></span>
<span><span class='c'>#&gt; 11                7.87</span></span>
<span><span class='c'>#&gt; 12                &lt;NA&gt;</span></span>
<span><span class='c'>#&gt; 13                &lt;NA&gt;</span></span>
<span><span class='c'>#&gt;                                                            official_website</span></span>
<span><span class='c'>#&gt; 1                               http://www.fujiq.jp/attraction/shining.html</span></span>
<span><span class='c'>#&gt; 2                                                                      &lt;NA&gt;</span></span>
<span><span class='c'>#&gt; 3                                              http://www.spaceworld.co.jp/</span></span>
<span><span class='c'>#&gt; 4                                http://www.senyo.co.jp/tempozan/index.html</span></span>
<span><span class='c'>#&gt; 5                                                    http://www.hepfive.jp/</span></span>
<span><span class='c'>#&gt; 6                                              http://www.daikanransha.com/</span></span>
<span><span class='c'>#&gt; 7                          http://www.senyo.co.jp/cosmo/attraction/001.html</span></span>
<span><span class='c'>#&gt; 8                                             http://www.senyo.co.jp/kasai/</span></span>
<span><span class='c'>#&gt; 9  http://web.archive.org/web/20100126161452/http:/evergreenmarinoa.com/sd/</span></span>
<span><span class='c'>#&gt; 10                                                                     &lt;NA&gt;</span></span>
<span><span class='c'>#&gt; 11                               http://www.tokyo-dome.co.jp/e/attractions/</span></span>
<span><span class='c'>#&gt; 12   http://www.wired.co.uk/news/archive/2013-09/03/nippon-moon-giant-wheel</span></span>
<span><span class='c'>#&gt; 13                                        http://www.nagashima-onsen.co.jp/</span></span>
<span><span class='c'>#&gt;    turns</span></span>
<span><span class='c'>#&gt; 1     NA</span></span>
<span><span class='c'>#&gt; 2     NA</span></span>
<span><span class='c'>#&gt; 3     NA</span></span>
<span><span class='c'>#&gt; 4     NA</span></span>
<span><span class='c'>#&gt; 5     NA</span></span>
<span><span class='c'>#&gt; 6     NA</span></span>
<span><span class='c'>#&gt; 7     NA</span></span>
<span><span class='c'>#&gt; 8     NA</span></span>
<span><span class='c'>#&gt; 9     NA</span></span>
<span><span class='c'>#&gt; 10     1</span></span>
<span><span class='c'>#&gt; 11    NA</span></span>
<span><span class='c'>#&gt; 12    NA</span></span>
<span><span class='c'>#&gt; 13    NA</span></span></code></pre>

</div>

I want to clean up the status codes

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>figure_data</span> <span class='o'>&lt;-</span> <span class='nv'>figure_data</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span> </span>
<span>  <span class='nf'><a href='https://dplyr.tidyverse.org/reference/filter.html'>filter</a></span><span class='o'>(</span><span class='nv'>status</span> <span class='o'><a href='https://rdrr.io/r/base/match.html'>%in%</a></span> <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span><span class='o'>(</span><span class='s'>"Defunct"</span>, <span class='s'>"Operating"</span>, <span class='s'>"Under Construction"</span><span class='o'>)</span><span class='o'>)</span></span></code></pre>

</div>

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ggplot2.tidyverse.org/reference/ggplot.html'>ggplot</a></span><span class='o'>(</span><span class='nf'><a href='https://ggplot2.tidyverse.org/reference/aes.html'>aes</a></span><span class='o'>(</span>x<span class='o'>=</span><span class='nv'>opened</span>, y<span class='o'>=</span><span class='nv'>country</span>, size<span class='o'>=</span><span class='nv'>seating_capacity</span>, color<span class='o'>=</span><span class='nv'>status</span><span class='o'>)</span>, data<span class='o'>=</span><span class='nv'>figure_data</span><span class='o'>)</span> <span class='o'>+</span></span>
<span>  <span class='nf'><a href='https://ggplot2.tidyverse.org/reference/geom_point.html'>geom_point</a></span><span class='o'>(</span>alpha<span class='o'>=</span><span class='m'>.3</span>, stroke<span class='o'>=</span><span class='m'>.8</span><span class='o'>)</span> <span class='o'>+</span></span>
<span>  <span class='nf'><a href='https://ggplot2.tidyverse.org/reference/geom_path.html'>geom_line</a></span><span class='o'>(</span>size<span class='o'>=</span><span class='m'>.4</span><span class='o'>)</span></span></code></pre>
<img src="figs/plot_4-1.png" width="700px" style="display: block; margin: auto;" />

</div>

Okay, why doesn't Malaysia have a line?

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>figure_data</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span> </span>
<span>  <span class='nf'><a href='https://dplyr.tidyverse.org/reference/filter.html'>filter</a></span><span class='o'>(</span><span class='nv'>country</span><span class='o'>==</span><span class='s'>"Malaysia"</span><span class='o'>)</span> <span class='o'><a href='https://magrittr.tidyverse.org/reference/pipe.html'>%&gt;%</a></span> </span>
<span>  <span class='nf'><a href='https://ggplot2.tidyverse.org/reference/ggplot.html'>ggplot</a></span><span class='o'>(</span><span class='nf'><a href='https://ggplot2.tidyverse.org/reference/aes.html'>aes</a></span><span class='o'>(</span>x<span class='o'>=</span><span class='nv'>opened</span>, y<span class='o'>=</span><span class='nv'>country</span>, color<span class='o'>=</span><span class='nv'>status</span><span class='o'>)</span><span class='o'>)</span> <span class='o'>+</span></span>
<span>      <span class='nf'><a href='https://ggplot2.tidyverse.org/reference/geom_point.html'>geom_point</a></span><span class='o'>(</span><span class='o'>)</span> <span class='o'>+</span></span>
<span>      <span class='nf'><a href='https://ggplot2.tidyverse.org/reference/geom_path.html'>geom_line</a></span><span class='o'>(</span><span class='o'>)</span></span><span><span class='c'>#&gt; geom_path: Each group consists of only one observation. Do you need to adjust</span></span>
<span><span class='c'>#&gt; the group aesthetic?</span></span></code></pre>
<img src="figs/malaysia-1.png" width="700px" style="display: block; margin: auto;" />

</div>

Okay, it looks like I need to place the color in the point.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nf'><a href='https://ggplot2.tidyverse.org/reference/ggplot.html'>ggplot</a></span><span class='o'>(</span><span class='nf'><a href='https://ggplot2.tidyverse.org/reference/aes.html'>aes</a></span><span class='o'>(</span>x<span class='o'>=</span><span class='nv'>opened</span>, y<span class='o'>=</span><span class='nv'>country</span><span class='o'>)</span>, data<span class='o'>=</span><span class='nv'>figure_data</span><span class='o'>)</span> <span class='o'>+</span></span>
<span>  <span class='nf'><a href='https://ggplot2.tidyverse.org/reference/geom_path.html'>geom_line</a></span><span class='o'>(</span>size<span class='o'>=</span><span class='m'>.4</span><span class='o'>)</span> <span class='o'>+</span></span>
<span>  <span class='nf'><a href='https://ggplot2.tidyverse.org/reference/geom_point.html'>geom_point</a></span><span class='o'>(</span>alpha<span class='o'>=</span><span class='m'>1</span>, stroke<span class='o'>=</span><span class='m'>.5</span>, shape<span class='o'>=</span><span class='m'>21</span>, color<span class='o'>=</span><span class='s'>"black"</span>, <span class='nf'><a href='https://ggplot2.tidyverse.org/reference/aes.html'>aes</a></span><span class='o'>(</span>x<span class='o'>=</span><span class='nv'>opened</span>, y<span class='o'>=</span><span class='nv'>country</span>, size<span class='o'>=</span><span class='nv'>seating_capacity</span><span class='o'>)</span>, data<span class='o'>=</span><span class='nv'>figure_data</span><span class='o'>)</span> <span class='o'>+</span></span>
<span>  <span class='nf'><a href='https://ggplot2.tidyverse.org/reference/geom_point.html'>geom_point</a></span><span class='o'>(</span>alpha<span class='o'>=</span><span class='m'>.3</span>, stroke<span class='o'>=</span><span class='m'>0</span>, <span class='nf'><a href='https://ggplot2.tidyverse.org/reference/aes.html'>aes</a></span><span class='o'>(</span>color<span class='o'>=</span><span class='nv'>status</span>, x<span class='o'>=</span><span class='nv'>opened</span>, y<span class='o'>=</span><span class='nv'>country</span>, color<span class='o'>=</span><span class='nv'>status</span>, size<span class='o'>=</span><span class='nv'>seating_capacity</span><span class='o'>)</span>, data<span class='o'>=</span><span class='nv'>figure_data</span><span class='o'>)</span> <span class='o'>+</span></span>
<span>  <span class='nf'><a href='https://ggplot2.tidyverse.org/reference/theme.html'>theme</a></span><span class='o'>(</span>aspect.ratio<span class='o'>=</span><span class='m'>1</span><span class='o'>)</span> <span class='o'>+</span></span>
<span>  <span class='nf'><a href='https://ggplot2.tidyverse.org/reference/labs.html'>ylab</a></span><span class='o'>(</span><span class='s'>""</span><span class='o'>)</span> <span class='o'>+</span></span>
<span>  <span class='nf'><a href='https://ggplot2.tidyverse.org/reference/labs.html'>xlab</a></span><span class='o'>(</span><span class='s'>""</span><span class='o'>)</span> <span class='o'>+</span></span>
<span>  <span class='nf'><a href='https://ggplot2.tidyverse.org/reference/scale_size.html'>scale_size_area</a></span><span class='o'>(</span>max_size<span class='o'>=</span><span class='m'>10</span><span class='o'>)</span></span><span><span class='c'>#&gt; Warning: Duplicated aesthetics after name standardisation: colour</span></span></code></pre>
<img src="figs/plot_5-1.png" width="700px" style="display: block; margin: auto;" />

</div>

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='nv'>final_plot</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ggplot2.tidyverse.org/reference/ggplot.html'>ggplot</a></span><span class='o'>(</span><span class='nf'><a href='https://ggplot2.tidyverse.org/reference/aes.html'>aes</a></span><span class='o'>(</span>x<span class='o'>=</span><span class='nv'>opened</span>, y<span class='o'>=</span><span class='nv'>country</span><span class='o'>)</span>, data<span class='o'>=</span><span class='nv'>figure_data</span><span class='o'>)</span> <span class='o'>+</span></span>
<span>  <span class='nf'><a href='https://ggplot2.tidyverse.org/reference/geom_path.html'>geom_line</a></span><span class='o'>(</span>size<span class='o'>=</span><span class='m'>.4</span><span class='o'>)</span> <span class='o'>+</span></span>
<span>  <span class='nf'><a href='https://ggplot2.tidyverse.org/reference/geom_jitter.html'>geom_jitter</a></span><span class='o'>(</span>alpha<span class='o'>=</span><span class='m'>1</span>, stroke<span class='o'>=</span><span class='m'>.4</span>, height<span class='o'>=</span><span class='m'>.12</span>, <span class='nf'><a href='https://ggplot2.tidyverse.org/reference/aes.html'>aes</a></span><span class='o'>(</span>color<span class='o'>=</span><span class='nv'>status</span>, x<span class='o'>=</span><span class='nv'>opened</span>, y<span class='o'>=</span><span class='nv'>country</span>, size<span class='o'>=</span><span class='nv'>seating_capacity</span><span class='o'>)</span>, data<span class='o'>=</span><span class='nv'>figure_data</span><span class='o'>)</span> <span class='o'>+</span></span>
<span>  <span class='nf'><a href='https://ggplot2.tidyverse.org/reference/theme.html'>theme</a></span><span class='o'>(</span>aspect.ratio<span class='o'>=</span><span class='m'>1</span><span class='o'>)</span> <span class='o'>+</span></span>
<span>  <span class='nf'><a href='https://ggplot2.tidyverse.org/reference/labs.html'>ylab</a></span><span class='o'>(</span><span class='s'>""</span><span class='o'>)</span> <span class='o'>+</span></span>
<span>  <span class='nf'><a href='https://ggplot2.tidyverse.org/reference/labs.html'>xlab</a></span><span class='o'>(</span><span class='s'>""</span><span class='o'>)</span> <span class='o'>+</span></span>
<span>  <span class='nf'><a href='https://ggplot2.tidyverse.org/reference/scale_size.html'>scale_size_area</a></span><span class='o'>(</span>max_size<span class='o'>=</span><span class='m'>10</span><span class='o'>)</span></span></code></pre>

</div>

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span><span class='c'># ggsave(file="final_plot.svg", plot=final_plot)</span></span></code></pre>

</div>

Awesome, there it is! I should include a label showing japan has 64 seats in the small \~1965 ferris wheel. And the \~2017 US one has a max of 1440.

What happened to Malaysia's recently defunct one?

