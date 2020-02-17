library(easypackages)

libraries(c("readxl", "readr", "plyr", "dplyr", "ggplot2", "png", "tidyverse", "reshape2", "scales", "rgdal", 'rgeos', "tmaptools", 'sp', 'sf', 'maptools', 'leaflet', 'leaflet.extras', 'spdplyr', 'geojsonio', 'rmapshaper', 'jsonlite'))

capwords = function(s, strict = FALSE) {
  cap = function(s) paste(toupper(substring(s, 1, 1)),
                          {s = substring(s, 2); if(strict) tolower(s) else s},sep = "", collapse = " " )
  sapply(strsplit(s, split = " "), cap, USE.NAMES = !is.null(names(s)))}

options(scipen = 999)

github_repo_dir <- "~/Documents/Repositories/DTOC"

# This is a command to create a sub-directory if it does not exist in the working directory
if (!file.exists(paste0(github_repo_dir, "/DTOC_data"))) {
  dir.create(paste0(github_repo_dir, "/DTOC_data"))}

# Any new months of data can be downloaded using R, just copy the 'Total Delayed Days Local Authority' file for the month and paste it into the download.file("", paste0(github_repo_dir, "/DTOC_data/x .xls"), mode = "wb"). The mode = "wb" saves it as a binary file.

if (!file.exists(paste0(github_repo_dir, "/DTOC_data/Dec_19.xls"))) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2020/02/LA-Type-B-December-2019-9tun8.xls",paste0(github_repo_dir, "/DTOC_data/Dec_19.xls"), mode = "wb")}

if (!file.exists(paste0(github_repo_dir, "/DTOC_data/Nov_19.xls"))) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2020/01/LA-Type-B-November-2019-fZk64.xls",paste0(github_repo_dir, "/DTOC_data/Nov_19.xls"), mode = "wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/Oct_19.xls"))) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2019/12/LA-Type-B-October-2019-AyuDr.xls",paste0(github_repo_dir, "/DTOC_data/Oct_19.xls"), mode = "wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/Sep_19.xls"))) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2019/11/LA-Type-B-September-2019-Kv9xQ.xls",paste0(github_repo_dir, "/DTOC_data/Sep_19.xls"), mode = "wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/Aug_19.xls"))) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2019/10/LA-Type-B-August-2019-KJK5B.xls",paste0(github_repo_dir, "/DTOC_data/Aug_19.xls"), mode = "wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/Jul_19.xls"))) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2019/09/LA-Type-B-July-2019-9e0AO.xls",paste0(github_repo_dir, "/DTOC_data/Jul_19.xls"), mode = "wb")}

if (!file.exists(paste0(github_repo_dir, "/DTOC_data/Jun_19.xls"))) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2019/09/LA-Type-B-June-2019-njg1B.xls",paste0(github_repo_dir, "/DTOC_data/Jun_19.xls"), mode = "wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/May_19.xls"))) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2019/09/LA-Type-B-May-2019-50Vdt-1.xls",paste0(github_repo_dir, "/DTOC_data/May_19.xls"), mode = "wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/Apr_19.xls"))) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2019/09/LA-Type-B-April-2019-jUENZ.xls",paste0(github_repo_dir, "/DTOC_data/Apr_19.xls"), mode = "wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/Mar_19.xls"))) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2019/09/LA-Type-B-March-2019-gmwv8.xls",paste0(github_repo_dir, "/DTOC_data/Mar_19.xls"), mode = "wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/Feb_19.xls"))) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2019/09/LA-Type-B-February-2019-Sxz4V.xls",paste0(github_repo_dir, "/DTOC_data/Feb_19.xls"), mode = "wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/Jan_19.xls"))) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2019/09/LA-Type-B-January-2019-gm978.xls",paste0(github_repo_dir, "/DTOC_data/Jan_19.xls"), mode = "wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/Dec_18.xls"))) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2019/09/LA-Type-B-December-2018-82pwz.xls",paste0(github_repo_dir, "/DTOC_data/Dec_18.xls"), mode = "wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/Nov_18.xls"))) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2019/09/LA-Type-B-November-2018-253WD.xls",paste0(github_repo_dir, "/DTOC_data/Nov_18.xls"), mode = "wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/Oct_18.xls"))) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2019/05/LA-Type-B-October-2018-7VM1o.xls",paste0(github_repo_dir, "/DTOC_data/Oct_18.xls"), mode = "wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/Sep_118.xls"))) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2019/05/LA-Type-B-September-2018-Je0H7.xls", paste0(github_repo_dir, "/DTOC_data/Sep_18.xls"), mode = "wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/Aug_18.xls"))) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2019/05/LA-Type-B-August-2018-uwfNj.xls", paste0(github_repo_dir, "/DTOC_data/Aug_18.xls"), mode = "wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/July_18.xls"))) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2019/05/LA-Type-B-July-2018-VYly2.xls", paste0(github_repo_dir, "/DTOC_data/July_18.xls"), mode = "wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/June_18.xls"))) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2019/05/LA-Type-B-June-2018-L7vym.xls", paste0(github_repo_dir, "/DTOC_data/June_18.xls"), mode = "wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/May_18.xls"))) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2019/05/LA-Type-B-May-2018-cuifB.xls", paste0(github_repo_dir, "/DTOC_data/May_18.xls"), mode = "wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/April_18.xls"))) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2019/05/LA-Type-B-April-2018-e2c97.xls", paste0(github_repo_dir, "/DTOC_data/April_18.xls"), mode = "wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/March_18.xls"))) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2018/12/LA-Type-B-March-2018-a8wRN.xls", paste0(github_repo_dir, "/DTOC_data/March_18.xls"), mode = "wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/Feb_18.xls"))) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2018/12/LA-Type-B-February-2018-AeE94.xls", paste0(github_repo_dir, "/DTOC_data/Feb_18.xls"), mode="wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/Jan_18.xls"))) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2018/12/LA-Type-B-January-2018-D7csN.xls", paste0(github_repo_dir, "/DTOC_data/Jan_18.xls"), mode="wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/Dec_17.xls"))) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2018/05/LA-Type-B-December-2018-3SmuW.xls", paste0(github_repo_dir, "/DTOC_data/Dec_17.xls"), mode="wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/Nov_17.xls"))) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2018/05/LA-Type-B-November-2017-0smeW.xls",paste0(github_repo_dir, "/DTOC_data/Nov_17.xls"), mode = "wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/Oct_17.xls"))) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2018/05/LA-Type-B-October-2017-B2B1c.xls",paste0(github_repo_dir, "/DTOC_data/Oct_17.xls"), mode = "wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/Sep_17.xls"))) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2018/06/LA-Type-B-September-2017-eNlrU.xls", paste0(github_repo_dir, "/DTOC_data/Sep_17.xls"), mode = "wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/Aug_17.xls"))) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2018/06/LA-Type-B-August-2017-dU97O.xls", paste0(github_repo_dir, "/DTOC_data/Aug_17.xls"), mode = "wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/July_17.xls"))) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2018/06/LA-Type-B-July-2017-JPBbd.xls", paste0(github_repo_dir, "/DTOC_data/July_17.xls"), mode = "wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/June_17.xls"))) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2018/06/LA-Type-B-June-2017-Szt03.xls", paste0(github_repo_dir, "/DTOC_data/June_17.xls"), mode = "wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/May_17.xls"))) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2018/06/LA-Type-B-May-2017-vP4lj.xls", paste0(github_repo_dir, "/DTOC_data/May_17.xls"), mode = "wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/April_17.xls"))) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2018/06/LA-Type-B-April-2017-92rd3.xls", paste0(github_repo_dir, "/DTOC_data/April_17.xls"), mode = "wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/March_17.xls"))) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2016/06/LA-Type-B-March-2017-MC3hG-1.xls", paste0(github_repo_dir, "/DTOC_data/March_17.xls"), mode = "wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/Feb_17.xls"))) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2016/06/LA-Type-B-February-2017-b6qUr.xls", paste0(github_repo_dir, "/DTOC_data/Feb_17.xls"), mode="wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/Jan_17.xls"))) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2016/06/LA-Type-B-January-2017-h1bY5.xls", paste0(github_repo_dir, "/DTOC_data/Jan_17.xls"), mode="wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/Dec_16.xls"))) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2016/06/LA-Type-B-December-2016-VTPYV.xls", paste0(github_repo_dir, "/DTOC_data/Dec_16.xls"), mode="wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/Nov_16.xls"))) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2016/06/LA-Type-B-November-2016-KS2Zd.xls", paste0(github_repo_dir, "/DTOC_data/Nov_16.xls"), mode="wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/Oct_16.xls"))) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2016/06/LA-Type-B-October-2016-8Fcx8.xls", paste0(github_repo_dir, "/DTOC_data/Oct_16.xls"), mode="wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/Sept_16.xls"))) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2016/06/LA-Type-B-September-2016-wgMdH.xls", paste0(github_repo_dir, "/DTOC_data/Sept_16.xls"), mode="wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/Aug_16.xls"))) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2016/06/LA-Type-B-August-2016-Vel8T.xls", paste0(github_repo_dir, "/DTOC_data/Aug_16.xls"), mode="wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/July_16.xls"))) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2016/06/LA-Type-B-July-2016-ub6Sw.xls", paste0(github_repo_dir, "/DTOC_data/July_16.xls"), mode="wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/June_16.xls"))) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2016/06/LA-Type-B-June-2016-3QrLM.xls", paste0(github_repo_dir, "/DTOC_data/June_16.xls"), mode="wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/May_16.xls"))) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2016/06/LA-Type-B-May-2016-iwFg2.xls", paste0(github_repo_dir, "/DTOC_data/May_16.xls"), mode="wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/April_16.xls"))) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2016/06/LA-Type-B-April-2016-twP0s.xls", paste0(github_repo_dir, "/DTOC_data/April_16.xls"), mode="wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/March_16.xls"))) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2015/05/LA-Type-B-March-2016-5a7Vy.xls", paste0(github_repo_dir, "/DTOC_data/March_16.xls"), mode="wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/Feb_16.xls"))) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2015/05/LA-Type-B-February-2016-1FdtU.xls", paste0(github_repo_dir, "/DTOC_data/Feb_16.xls"), mode="wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/Jan_16.xls"))) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2015/05/LA-Type-B-January-2016-S78Xn.xls", paste0(github_repo_dir, "/DTOC_data/Jan_16.xls"), mode="wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/Dec_15.xls"))) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2016/05/LA-Type-B-December-2015-6Gxr4.xls", paste0(github_repo_dir, "/DTOC_data/Dec_15.xls"), mode="wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/Nov_15.xls"))) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2016/05/LA-Type-B-November-2015-Ifn3m.xls", paste0(github_repo_dir, "/DTOC_data/Nov_15.xls"), mode="wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/Oct_15.xls"))) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2016/05/LA-Type-B-October-2015-ZPEX3.xls", paste0(github_repo_dir, "/DTOC_data/Oct_15.xls"), mode="wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/Sept_15.xls"))) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2016/05/LA-Type-B-September-2015-fKlcd-1.xls", paste0(github_repo_dir, "/DTOC_data/Sept_15.xls"), mode="wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/Aug_15.xls"))) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2016/05/LA-Type-B-August-2015-k00La.xls", paste0(github_repo_dir, "/DTOC_data/Aug_15.xls"), mode="wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/July_15.xls"))) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2016/05/LA-Type-B-July-2015-1IRZy.xls", paste0(github_repo_dir, "/DTOC_data/July_15.xls"), mode="wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/June_15.xls"))) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2015/05/LA-Type-B-June-2015-8O4AJ.xls", paste0(github_repo_dir, "/DTOC_data/June_15.xls"), mode="wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/May_15.xls"))) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2015/05/LA-Type-B-May-2015-ET440.xls", paste0(github_repo_dir, "/DTOC_data/May_15.xls"), mode="wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/April_15.xls"))) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2015/05/LA-Type-B-April-2015-aV5qN.xls", paste0(github_repo_dir, "/DTOC_data/April_15.xls"), mode="wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/March_15.xls"))) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2014/05/LA-Type-B-March-2015-0z9td.xls", paste0(github_repo_dir, "/DTOC_data/March_15.xls"), mode="wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/Feb_15.xls"))) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2014/05/LA-Type-B-February-2015-t0kNt.xls", paste0(github_repo_dir, "/DTOC_data/Feb_15.xls"), mode="wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/Jan_15.xls"))) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2014/05/LA-Type-B-January-2015-sr9FD.xls", paste0(github_repo_dir, "/DTOC_data/Jan_15.xls"), mode="wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/Dec_14.xls"))) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2014/05/LA-Type-B-December-2014-Ybz9E.xls", paste0(github_repo_dir, "/DTOC_data/Dec_14.xls"), mode="wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/Nov_14.xls"))) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2014/05/LA-Type-B-November-2014-CH10v.xls", paste0(github_repo_dir, "/DTOC_data/Nov_14.xls"), mode="wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/Oct_14.xls"))) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2014/05/LA-Type-B-October-2014-qQsu9.xls", paste0(github_repo_dir, "/DTOC_data/Oct_14.xls"), mode="wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/Sept_14.xls"))) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2014/05/LA-Type-B-September-2014-9Og8k.xls", paste0(github_repo_dir, "/DTOC_data/Sept_14.xls"), mode="wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/Aug_14.xls"))) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2014/05/LA-Type-B-August-2014-5Ersz.xls", paste0(github_repo_dir, "/DTOC_data/Aug_14.xls"), mode="wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/July_14.xls"))) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2014/05/LA-Type-B-July-2014-Jynk8.xls", paste0(github_repo_dir, "/DTOC_data/July_14.xls"), mode="wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/June_14.xls"))) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2014/05/LA-Type-B-June-2014-9DJx3.xls", paste0(github_repo_dir, "/DTOC_data/June_14.xls"), mode="wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/May_14.xls"))) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2014/05/LA-Type-B-May-2014-4iXvt.xls", paste0(github_repo_dir, "/DTOC_data/May_14.xls"), mode="wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/April_14.xls"))) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2014/05/LA-Type-B-April-2014-DCqI0.xls", paste0(github_repo_dir, "/DTOC_data/April_14.xls"), mode="wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/March_14.xls"))) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2013/05/LA-Type-B-March-2014-R04lg.xls", paste0(github_repo_dir, "/DTOC_data/March_14.xls"), mode="wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/Feb_14.xls"))) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2013/05/LA-Type-B-February-2014-q4561.xls", paste0(github_repo_dir, "/DTOC_data/Feb_14.xls"), mode="wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/Jan_14.xls"))) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2013/05/LA-Type-B-January-2014-cN7NU.xls", paste0(github_repo_dir, "/DTOC_data/Jan_14.xls"), mode="wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/Dec_13.xls"))) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2013/05/LA-Type-B-December-2013-qG5el.xls", paste0(github_repo_dir, "/DTOC_data/Dec_13.xls"), mode="wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/Nov_13.xls"))) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2013/05/LA-Type-B-November-2013-S055x.xls", paste0(github_repo_dir, "/DTOC_data/Nov_13.xls"), mode="wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/Oct_13.xls"))) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2013/05/LA-Type-B-October-2013-N8pto.xls", paste0(github_repo_dir, "/DTOC_data/Oct_13.xls"), mode="wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/Sept_13.xls"))) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2013/05/LA-Type-B-September-2013-1YV20.xls", paste0(github_repo_dir, "/DTOC_data/Sept_13.xls"), mode="wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/Aug_13.xls"))) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2013/05/LA-Type-B-August-2013-ZdYz5.xls", paste0(github_repo_dir, "/DTOC_data/Aug_13.xls"), mode="wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/July_13.xls"))) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2013/05/LA-Type-B-July-2013-B5Nmd.xls", paste0(github_repo_dir, "/DTOC_data/July_13.xls"), mode="wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/June_13.xls"))) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2013/05/LA-Type-B-June-2013-522rq.xls", paste0(github_repo_dir, "/DTOC_data/June_13.xls"), mode="wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/May_13.xls"))) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2013/05/LA-Type-B-May-2013-92547.xls", paste0(github_repo_dir, "/DTOC_data/May_13.xls"), mode="wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/April_13.xls"))) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2013/05/LA-Type-B-April-2013-NJ6oD.xls", paste0(github_repo_dir, "/DTOC_data/April_13.xls"), mode="wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/March_13.xls"))) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2013/04/LA-Type-B-March-2013-C2ubZ.xls", paste0(github_repo_dir, "/DTOC_data/March_13.xls"), mode="wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/Feb_13.xls"))) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2013/04/LA-Type-B-February-2013-vr84R.xls", paste0(github_repo_dir, "/DTOC_data/Feb_13.xls"), mode="wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/Jan_13.xls"))) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2013/04/LA-Type-B-January-2013-g1G5t.xls", paste0(github_repo_dir, "/DTOC_data/Jan_13.xls"), mode="wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/Dec_12.xls"))) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2013/04/LA-Type-B-December-2012-rev-April-2013.xls", paste0(github_repo_dir, "/DTOC_data/Dec_12.xls"), mode="wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/Nov_12.xls"))) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2013/04/LA-Type-B-November-2012-rev-April-2013.xls", paste0(github_repo_dir, "/DTOC_data/Nov_12.xls"), mode="wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/Oct_12.xls"))) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2013/04/LA-Type-B-October-2012-rev-April-2013.xls", paste0(github_repo_dir, "/DTOC_data/Oct_12.xls"), mode="wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/Sept_12.xls"))) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2013/04/LA-Type-B-September-2012-rev-April-2013.xls", paste0(github_repo_dir, "/DTOC_data/Sept_12.xls"), mode="wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/Aug_12.xls"))) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2013/04/LA-Type-B-August-2012-rev-April-2013.xls", paste0(github_repo_dir, "/DTOC_data/Aug_12.xls"), mode="wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/July_12.xls"))) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2013/04/LA-Type-B-July-2012-rev-April-2013.xls", paste0(github_repo_dir, "/DTOC_data/July_12.xls"), mode="wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/June_12.xls"))) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2013/04/LA-Type-B-June-2012-rev-April-2013.xls", paste0(github_repo_dir, "/DTOC_data/June_12.xls"), mode="wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/May_12.xls"))) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2013/04/LA-Type-B-May-2012-rev-April-2013.xls", paste0(github_repo_dir, "/DTOC_data/May_12.xls"), mode="wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/April_12.xls"))) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2013/04/LA-Type-B-April-2012-rev-April-2013.xls", paste0(github_repo_dir, "/DTOC_data/April_12.xls"), mode="wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/March_12.xls"))) {download.file("http://transparency.dh.gov.uk/files/2012/07/LA-Type-B-March-2011-12-revised-October-2012.xls", paste0(github_repo_dir, "/DTOC_data/March_12.xls"), mode="wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/Feb_12.xls"))) {download.file("http://transparency.dh.gov.uk/files/2012/07/LA-Type-B-February-2011-12-revised-October-2012.xls", paste0(github_repo_dir, "/DTOC_data/Feb_12.xls"), mode="wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/Jan_12.xls"))) {download.file("http://transparency.dh.gov.uk/files/2012/07/LA-Type-B-January-2011-12-revised-October-2012.xls", paste0(github_repo_dir, "/DTOC_data/Jan_12.xls"), mode="wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/Dec_11.xls"))) {download.file("http://webarchive.nationalarchives.gov.uk/20130227100129/http://www.dh.gov.uk/prod_consum_dh/groups/dh_digitalassets/@dh/@en/@ps/@sta/@perf/documents/digitalasset/dh_133782.xls", paste0(github_repo_dir, "/DTOC_data/Dec_11.xls"), mode="wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/Nov_11.xls"))) {download.file("http://webarchive.nationalarchives.gov.uk/20130227100129/http://www.dh.gov.uk/prod_consum_dh/groups/dh_digitalassets/@dh/@en/@ps/@sta/@perf/documents/digitalasset/dh_133778.xls", paste0(github_repo_dir, "/DTOC_data/Nov_11.xls"), mode="wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/Oct_11.xls"))) {download.file("http://webarchive.nationalarchives.gov.uk/20130227100129/http://www.dh.gov.uk/prod_consum_dh/groups/dh_digitalassets/@dh/@en/@ps/@sta/@perf/documents/digitalasset/dh_133774.xls", paste0(github_repo_dir, "/DTOC_data/Oct_11.xls"), mode="wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/Sept_11.xls"))) {download.file("http://webarchive.nationalarchives.gov.uk/20130227100129/http://www.dh.gov.uk/prod_consum_dh/groups/dh_digitalassets/@dh/@en/@ps/@sta/@perf/documents/digitalasset/dh_133770.xls", paste0(github_repo_dir, "/DTOC_data/Sept_11.xls"), mode="wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/Aug_11.xls"))) {download.file("http://webarchive.nationalarchives.gov.uk/20130227100129/http://www.dh.gov.uk/prod_consum_dh/groups/dh_digitalassets/@dh/@en/@ps/@sta/@perf/documents/digitalasset/dh_133766.xls", paste0(github_repo_dir, "/DTOC_data/Aug_11.xls"), mode="wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/July_11.xls"))) {download.file("http://webarchive.nationalarchives.gov.uk/20130227100129/http://www.dh.gov.uk/prod_consum_dh/groups/dh_digitalassets/@dh/@en/@ps/@sta/@perf/documents/digitalasset/dh_133762.xls", paste0(github_repo_dir, "/DTOC_data/July_11.xls"), mode="wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/June_11.xls"))) {download.file("http://webarchive.nationalarchives.gov.uk/20130227100129/http://www.dh.gov.uk/prod_consum_dh/groups/dh_digitalassets/@dh/@en/@ps/@sta/@perf/documents/digitalasset/dh_133758.xls", paste0(github_repo_dir, "/DTOC_data/June_11.xls"), mode="wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/May_11.xls"))) {download.file("http://webarchive.nationalarchives.gov.uk/20130227100129/http://www.dh.gov.uk/prod_consum_dh/groups/dh_digitalassets/@dh/@en/@ps/@sta/@perf/documents/digitalasset/dh_133754.xls", paste0(github_repo_dir, "/DTOC_data/May_11.xls"), mode="wb")}
if (!file.exists(paste0(github_repo_dir, "/DTOC_data/April_11.xls"))) {download.file("http://webarchive.nationalarchives.gov.uk/20130227100129/http://www.dh.gov.uk/prod_consum_dh/groups/dh_digitalassets/@dh/@en/@ps/@sta/@perf/documents/digitalasset/dh_133750.xls", paste0(github_repo_dir, "/DTOC_data/April_11.xls"), mode="wb")}


# Days delayed by reason ####

# Create an empty df ready to put in all the data
Days_reason <- data.frame(SHA = factor(), CODE = factor(), NAME = factor(), `A) AWAITING COMPLETION OF ASSESSMENT` = numeric(), `B) AWAITING PUBLIC FUNDING` = numeric(), `C) AWAITING FURTHER NON-ACUTE NHS CARE` = numeric(), `DI) AWAITING RESIDENTIAL HOME PLACEMENT OR AVAILABILITY` = numeric(), `DII) AWAITING NURSING HOME PLACEMENT OR AVAILABILITY` = numeric(), `E) AWAITING CARE PACKAGE IN OWN HOME` = numeric(), `F) AWAITING COMMUNITY EQUIPMENT AND ADAPTATIONS` = numeric(), `G) PATIENT OR FAMILY CHOICE` = numeric(), `H) DISPUTES` = numeric(), `I) HOUSING - PATIENTS NOT COVERED BY NHS AND COMMUNITY CARE ACT` = numeric(), TOTAL = numeric(), PERIOD_YEAR = factor(), check.names = FALSE)

for(i in 1:length(list.files(paste0(github_repo_dir, "/DTOC_data")))) {

Month <- read_excel(paste0(github_repo_dir, "/DTOC_data/", list.files(paste0(github_repo_dir, "/DTOC_data"))[i]), sheet = 4, skip = 13) %>% 
  mutate(Period_year = as.character(read_excel(paste0(github_repo_dir, "/DTOC_data/", list.files(paste0(github_repo_dir, "/DTOC_data"))[i]), sheet = 4, range = "R5C3:R5C3", col_names = FALSE)))
  
colnames(Month) <- toupper(colnames(Month))
colnames(Month) <- gsub("^A.*", "A) AWAITING COMPLETION OF ASSESSMENT", colnames(Month))
colnames(Month) <- gsub("^B.*", "B) AWAITING PUBLIC FUNDING", colnames(Month))
colnames(Month) <- gsub("^C).*", "C) AWAITING FURTHER NON-ACUTE NHS CARE", colnames(Month))
colnames(Month) <- gsub("^F.*", "F) AWAITING COMMUNITY EQUIPMENT AND ADAPTATIONS", colnames(Month))
colnames(Month) <- gsub("^I.*", "I) HOUSING - PATIENTS NOT COVERED BY NHS AND COMMUNITY CARE ACT", colnames(Month))

colnames(Month)[colnames(Month) == "ONS GEOGRAPHY"] <- "CODE"

Days_reason <- rbind.fill(Days_reason, Month) # This adds the data to a bigger dataframe called Days_reason (which we set up earlier)
  rm(Month)
  }

# Clean up Days_reason ####
Days_reason <- Days_reason %>% 
  filter(!is.na(NAME)) %>% # remove rows with no data for name
  mutate(NAME = gsub(" UA", "", NAME)) %>% 
  mutate(NAME = gsub("Isle Of Wight", "Isle of Wight", NAME)) %>% 
  mutate(NAME = gsub("Medway Towns", "Medway", NAME)) %>% 
  rename(Code = CODE,
         Name = NAME, 
         `Awaiting completion of assessment` = `A) AWAITING COMPLETION OF ASSESSMENT`,
         `Awaiting public funding` = `B) AWAITING PUBLIC FUNDING`,
         `Awaiting further NHS non-acute care` = `C) AWAITING FURTHER NON-ACUTE NHS CARE`,
         `Awaiting residential home placement or availability` = `DI) AWAITING RESIDENTIAL HOME PLACEMENT OR AVAILABILITY`,
         `Awaiting nursing home placement or availability` = `DII) AWAITING NURSING HOME PLACEMENT OR AVAILABILITY`,
         `Awaiting care package in own home` = `E) AWAITING CARE PACKAGE IN OWN HOME`,
         `Awaiting community equipment and adaptations` = `F) AWAITING COMMUNITY EQUIPMENT AND ADAPTATIONS`,
         `Patient or family choice` = `G) PATIENT OR FAMILY CHOICE`,
         `Disputes` = `H) DISPUTES`,
         `Housing - Patients not covered by NHS and Community Care Act` = `I) HOUSING - PATIENTS NOT COVERED BY NHS AND COMMUNITY CARE ACT`,
         Other = `O) OTHER`,
         `Total Delayed Transfers of Care` = TOTAL,
         Period = PERIOD_YEAR) %>% 
  select("Code", "Name", "Awaiting completion of assessment", "Awaiting public funding", "Awaiting further NHS non-acute care", "Awaiting residential home placement or availability", "Awaiting nursing home placement or availability", "Awaiting care package in own home", "Awaiting community equipment and adaptations", "Patient or family choice", "Disputes", "Housing - Patients not covered by NHS and Community Care Act","Other", "Total Delayed Transfers of Care","Period") %>% 
  mutate(`Awaiting completion of assessment` = gsub(",","", `Awaiting completion of assessment`),
         `Awaiting public funding` = gsub(",","",`Awaiting public funding`),
         `Awaiting further NHS non-acute care` = gsub(",","",`Awaiting further NHS non-acute care`),
         `Awaiting residential home placement or availability` = gsub(",","",`Awaiting residential home placement or availability`),
         `Awaiting nursing home placement or availability` = gsub(",","",`Awaiting nursing home placement or availability`),
         `Awaiting care package in own home` = gsub(",","", `Awaiting care package in own home`),
         `Awaiting community equipment and adaptations` = gsub(",","",`Awaiting community equipment and adaptations`),
         `Patient or family choice` = gsub(",","",`Patient or family choice`),
         Disputes = gsub(",","",Disputes),
         `Housing - Patients not covered by NHS and Community Care Act` = gsub(",","",`Housing - Patients not covered by NHS and Community Care Act`),
         `Total Delayed Transfers of Care` = gsub(",","",`Total Delayed Transfers of Care`)) %>% 
  filter(!(Name %in% c("Resident in Scotland","Resident In Wales","Resident outside GB", "City Of London")))

write.csv(Days_reason, paste0(github_repo_dir,"/DToC_Days_Reason_for_Delay.csv"), row.names = FALSE, na = "NA")
write.csv(Days_reason, "~/Documents/Repositories/spc/DToC_Days_Reason_for_Delay.csv", row.names = FALSE, na = "NA")

# DToC by responsible organisation ####

# Create an empty df ready to put in all the data
Days_organisation <- data.frame(SHA = factor(), Code = factor(), Name = factor(), NHS = integer(),`Social Care` = integer(), Both = integer(),Total = integer(), check.names = FALSE)

for (i in 1:length(list.files(paste0(github_repo_dir, "/DTOC_data"))))   {
  Month <- read_excel(paste0(github_repo_dir, "/DTOC_data/", list.files(paste0(github_repo_dir, "/DTOC_data"))[i]), sheet = 3, skip = 13) %>% 
    select(1:7)
  
colnames(Month) <- c("Region", "ONS Geography", "Code", "Name", "NHS", "Social Care", "Both")
  
  Month <- Month %>% 
    mutate(Period_year = as.character(read_excel(paste0(github_repo_dir, "/DTOC_data/", list.files(paste0(github_repo_dir, "/DTOC_data"))[i]), sheet = 3, range = "R5C3:R5C3", col_names = FALSE))) %>% 
    rename(Code = `ONS Geography`)
  
  Days_organisation <- rbind.fill(Days_organisation, Month) # This adds the data to a bigger dataframe called Days_reason (which we set up earlier)
  rm(Month) 
  }

# Clean up Days_organisation ####
Days_organisation <- Days_organisation %>% 
  select(Name, NHS, `Social Care`, Both, Total, Period_year) %>% 
  mutate(Name = gsub(" UA","", Name)) %>% 
  mutate(Name = gsub("Isle Of Wight", "Isle of Wight", Name)) %>% 
  mutate(Name = gsub("Medway Towns", "Medway", Name)) %>% 
  filter(!is.na(Name)) %>% 
  filter(!(Name %in% c("Resident in Scotland","Resident In Wales","Resident outside GB", "City Of London"))) %>% 
  mutate(NHS = gsub(",","", NHS),
         `Social Care` = gsub(",","",`Social Care`),
         Both = gsub(",","",Both),
         Total = gsub(",","",Total))

write.csv(Days_organisation, paste0(github_repo_dir,"/DToC_Days_Responsible_Organisation.csv"), row.names = FALSE)
write.csv(Days_organisation, "~/Documents/Repositories/spc/DToC_Days_Responsible_Organisation.csv", row.names = FALSE)

rm(list = ls())

