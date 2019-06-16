
# Packages
library(readr)
library(readxl)
library(plyr)
library(dplyr)
library(tidyr)

# NHS England are introducing a new measure of Delayed Transfers of Care, which supercedes the number of patients snapshot on the last thursday of the month.

# This is from April 2017 onwards and is not backdated

# DToC Days ####

# You can check the directory with getwd()
getwd()

# This is a command to create a sub-directory if it does not exist in the working directory
if (!file.exists("~/Delayed Transfers of Care")) {
  dir.create("~/Delayed Transfers of Care")}

# This is a command to create a sub-directory if it does not exist in the working directory
if (!file.exists("~/Delayed Transfers of Care/Data")) {
  dir.create("~/Delayed Transfers of Care/Data")}

# Any new months of data can be downloaded using R, just copy the 'Total Delayed Days Local Authority' file for the month and paste it into the download.file("", "./Delayed Transfers of Care/Data/x .xls", mode = "wb"). The mode = "wb" saves it as a binary file.

if (!file.exists("./Delayed Transfers of Care/Data/Apr_19.xls")) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2019/06/LA-Type-B-April-2019-K35jY.xls","./Delayed Transfers of Care/Data/Apr_19.xls", mode = "wb")}
if (!file.exists("./Delayed Transfers of Care/Data/Mar_19.xls")) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2019/05/LA-Type-B-March-2019-9c5JC.xls","./Delayed Transfers of Care/Data/Mar_19.xls", mode = "wb")}
if (!file.exists("./Delayed Transfers of Care/Data/Feb_19.xls")) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2019/05/LA-Type-B-February-2019-Fk0FS.xls","./Delayed Transfers of Care/Data/Feb_19.xls", mode = "wb")}
if (!file.exists("./Delayed Transfers of Care/Data/Jan_19.xls")) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2019/05/LA-Type-B-January-2019-mxX03.xls","./Delayed Transfers of Care/Data/Jan_19.xls", mode = "wb")}
if (!file.exists("./Delayed Transfers of Care/Data/Dec_18.xls")) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2019/05/LA-Type-B-December-2018-JPuaa.xls","./Delayed Transfers of Care/Data/Dec_18.xls", mode = "wb")}
if (!file.exists("./Delayed Transfers of Care/Data/Nov_18.xls")) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2019/05/LA-Type-B-November-2018-rDU26.xls","./Delayed Transfers of Care/Data/Nov_18.xls", mode = "wb")}
if (!file.exists("./Delayed Transfers of Care/Data/Oct_18.xls")) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2019/05/LA-Type-B-October-2018-7VM1o.xls","./Delayed Transfers of Care/Data/Oct_18.xls", mode = "wb")}
if (!file.exists("./Delayed Transfers of Care/Data/Sep_118.xls")) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2019/05/LA-Type-B-September-2018-Je0H7.xls", "./Delayed Transfers of Care/Data/Sep_18.xls", mode = "wb")}
if (!file.exists("./Delayed Transfers of Care/Data/Aug_18.xls")) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2019/05/LA-Type-B-August-2018-uwfNj.xls", "./Delayed Transfers of Care/Data/Aug_18.xls", mode = "wb")}
if (!file.exists("./Delayed Transfers of Care/Data/July_18.xls")) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2019/05/LA-Type-B-July-2018-VYly2.xls", "./Delayed Transfers of Care/Data/July_18.xls", mode = "wb")}
if (!file.exists("./Delayed Transfers of Care/Data/June_18.xls")) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2019/05/LA-Type-B-June-2018-L7vym.xls", "./Delayed Transfers of Care/Data/June_18.xls", mode = "wb")}
if (!file.exists("./Delayed Transfers of Care/Data/May_18.xls")) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2019/05/LA-Type-B-May-2018-cuifB.xls", "./Delayed Transfers of Care/Data/May_18.xls", mode = "wb")}
if (!file.exists("./Delayed Transfers of Care/Data/April_18.xls")) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2019/05/LA-Type-B-April-2018-e2c97.xls", "./Delayed Transfers of Care/Data/April_18.xls", mode = "wb")}
if (!file.exists("./Delayed Transfers of Care/Data/March_18.xls")) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2018/12/LA-Type-B-March-2018-a8wRN.xls", "./Delayed Transfers of Care/Data/March_18.xls", mode = "wb")}
if (!file.exists("./Delayed Transfers of Care/Data/Feb_18.xls")) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2018/12/LA-Type-B-February-2018-AeE94.xls", "./Delayed Transfers of Care/Data/Feb_18.xls", mode="wb")}
if (!file.exists("./Delayed Transfers of Care/Data/Jan_18.xls")) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2018/12/LA-Type-B-January-2018-D7csN.xls", "./Delayed Transfers of Care/Data/Jan_18.xls", mode="wb")}
if (!file.exists("./Delayed Transfers of Care/Data/Dec_17.xls")) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2018/05/LA-Type-B-December-2018-3SmuW.xls", "./Delayed Transfers of Care/Data/Dec_17.xls", mode="wb")}
if (!file.exists("./Delayed Transfers of Care/Data/Nov_17.xls")) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2018/05/LA-Type-B-November-2017-0smeW.xls","./Delayed Transfers of Care/Data/Nov_17.xls", mode = "wb")}
if (!file.exists("./Delayed Transfers of Care/Data/Oct_17.xls")) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2018/05/LA-Type-B-October-2017-B2B1c.xls","./Delayed Transfers of Care/Data/Oct_17.xls", mode = "wb")}
if (!file.exists("./Delayed Transfers of Care/Data/Sep_17.xls")) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2018/06/LA-Type-B-September-2017-eNlrU.xls", "./Delayed Transfers of Care/Data/Sep_17.xls", mode = "wb")}
if (!file.exists("./Delayed Transfers of Care/Data/Aug_17.xls")) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2018/06/LA-Type-B-August-2017-dU97O.xls", "./Delayed Transfers of Care/Data/Aug_17.xls", mode = "wb")}
if (!file.exists("./Delayed Transfers of Care/Data/July_17.xls")) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2018/06/LA-Type-B-July-2017-JPBbd.xls", "./Delayed Transfers of Care/Data/July_17.xls", mode = "wb")}
if (!file.exists("./Delayed Transfers of Care/Data/June_17.xls")) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2018/06/LA-Type-B-June-2017-Szt03.xls", "./Delayed Transfers of Care/Data/June_17.xls", mode = "wb")}
if (!file.exists("./Delayed Transfers of Care/Data/May_17.xls")) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2018/06/LA-Type-B-May-2017-vP4lj.xls", "./Delayed Transfers of Care/Data/May_17.xls", mode = "wb")}
if (!file.exists("./Delayed Transfers of Care/Data/April_17.xls")) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2018/06/LA-Type-B-April-2017-92rd3.xls", "./Delayed Transfers of Care/Data/April_17.xls", mode = "wb")}
if (!file.exists("./Delayed Transfers of Care/Data/March_17.xls")) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2016/06/LA-Type-B-March-2017-MC3hG-1.xls", "./Delayed Transfers of Care/Data/March_17.xls", mode = "wb")}
if (!file.exists("./Delayed Transfers of Care/Data/Feb_17.xls")) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2016/06/LA-Type-B-February-2017-b6qUr.xls", "./Delayed Transfers of Care/Data/Feb_17.xls", mode="wb")}
if (!file.exists("./Delayed Transfers of Care/Data/Jan_17.xls")) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2016/06/LA-Type-B-January-2017-h1bY5.xls", "./Delayed Transfers of Care/Data/Jan_17.xls", mode="wb")}
if (!file.exists("./Delayed Transfers of Care/Data/Dec_16.xls")) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2016/06/LA-Type-B-December-2016-VTPYV.xls", "./Delayed Transfers of Care/Data/Dec_16.xls", mode="wb")}
if (!file.exists("./Delayed Transfers of Care/Data/Nov_16.xls")) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2016/06/LA-Type-B-November-2016-KS2Zd.xls", "./Delayed Transfers of Care/Data/Nov_16.xls", mode="wb")}
if (!file.exists("./Delayed Transfers of Care/Data/Oct_16.xls")) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2016/06/LA-Type-B-October-2016-8Fcx8.xls", "./Delayed Transfers of Care/Data/Oct_16.xls", mode="wb")}
if (!file.exists("./Delayed Transfers of Care/Data/Sept_16.xls")) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2016/06/LA-Type-B-September-2016-wgMdH.xls", "./Delayed Transfers of Care/Data/Sept_16.xls", mode="wb")}
if (!file.exists("./Delayed Transfers of Care/Data/Aug_16.xls")) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2016/06/LA-Type-B-August-2016-Vel8T.xls", "./Delayed Transfers of Care/Data/Aug_16.xls", mode="wb")}
if (!file.exists("./Delayed Transfers of Care/Data/July_16.xls")) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2016/06/LA-Type-B-July-2016-ub6Sw.xls", "./Delayed Transfers of Care/Data/July_16.xls", mode="wb")}
if (!file.exists("./Delayed Transfers of Care/Data/June_16.xls")) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2016/06/LA-Type-B-June-2016-3QrLM.xls", "./Delayed Transfers of Care/Data/June_16.xls", mode="wb")}
if (!file.exists("./Delayed Transfers of Care/Data/May_16.xls")) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2016/06/LA-Type-B-May-2016-iwFg2.xls", "./Delayed Transfers of Care/Data/May_16.xls", mode="wb")}
if (!file.exists("./Delayed Transfers of Care/Data/April_16.xls")) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2016/06/LA-Type-B-April-2016-twP0s.xls", "./Delayed Transfers of Care/Data/April_16.xls", mode="wb")}
if (!file.exists("./Delayed Transfers of Care/Data/March_16.xls")) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2015/05/LA-Type-B-March-2016-5a7Vy.xls", "./Delayed Transfers of Care/Data/March_16.xls", mode="wb")}
if (!file.exists("./Delayed Transfers of Care/Data/Feb_16.xls")) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2015/05/LA-Type-B-February-2016-1FdtU.xls", "./Delayed Transfers of Care/Data/Feb_16.xls", mode="wb")}
if (!file.exists("./Delayed Transfers of Care/Data/Jan_16.xls")) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2015/05/LA-Type-B-January-2016-S78Xn.xls", "./Delayed Transfers of Care/Data/Jan_16.xls", mode="wb")}
if (!file.exists("./Delayed Transfers of Care/Data/Dec_15.xls")) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2016/05/LA-Type-B-December-2015-6Gxr4.xls", "./Delayed Transfers of Care/Data/Dec_15.xls", mode="wb")}
if (!file.exists("./Delayed Transfers of Care/Data/Nov_15.xls")) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2016/05/LA-Type-B-November-2015-Ifn3m.xls", "./Delayed Transfers of Care/Data/Nov_15.xls", mode="wb")}
if (!file.exists("./Delayed Transfers of Care/Data/Oct_15.xls")) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2016/05/LA-Type-B-October-2015-ZPEX3.xls", "./Delayed Transfers of Care/Data/Oct_15.xls", mode="wb")}
if (!file.exists("./Delayed Transfers of Care/Data/Sept_15.xls")) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2016/05/LA-Type-B-September-2015-fKlcd-1.xls", "./Delayed Transfers of Care/Data/Sept_15.xls", mode="wb")}
if (!file.exists("./Delayed Transfers of Care/Data/Aug_15.xls")) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2016/05/LA-Type-B-August-2015-k00La.xls", "./Delayed Transfers of Care/Data/Aug_15.xls", mode="wb")}
if (!file.exists("./Delayed Transfers of Care/Data/July_15.xls")) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2016/05/LA-Type-B-July-2015-1IRZy.xls", "./Delayed Transfers of Care/Data/July_15.xls", mode="wb")}
if (!file.exists("./Delayed Transfers of Care/Data/June_15.xls")) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2015/05/LA-Type-B-June-2015-8O4AJ.xls", "./Delayed Transfers of Care/Data/June_15.xls", mode="wb")}
if (!file.exists("./Delayed Transfers of Care/Data/May_15.xls")) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2015/05/LA-Type-B-May-2015-ET440.xls", "./Delayed Transfers of Care/Data/May_15.xls", mode="wb")}
if (!file.exists("./Delayed Transfers of Care/Data/April_15.xls")) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2015/05/LA-Type-B-April-2015-aV5qN.xls", "./Delayed Transfers of Care/Data/April_15.xls", mode="wb")}
if (!file.exists("./Delayed Transfers of Care/Data/March_15.xls")) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2014/05/LA-Type-B-March-2015-0z9td.xls", "./Delayed Transfers of Care/Data/March_15.xls", mode="wb")}
if (!file.exists("./Delayed Transfers of Care/Data/Feb_15.xls")) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2014/05/LA-Type-B-February-2015-t0kNt.xls", "./Delayed Transfers of Care/Data/Feb_15.xls", mode="wb")}
if (!file.exists("./Delayed Transfers of Care/Data/Jan_15.xls")) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2014/05/LA-Type-B-January-2015-sr9FD.xls", "./Delayed Transfers of Care/Data/Jan_15.xls", mode="wb")}
if (!file.exists("./Delayed Transfers of Care/Data/Dec_14.xls")) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2014/05/LA-Type-B-December-2014-Ybz9E.xls", "./Delayed Transfers of Care/Data/Dec_14.xls", mode="wb")}
if (!file.exists("./Delayed Transfers of Care/Data/Nov_14.xls")) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2014/05/LA-Type-B-November-2014-CH10v.xls", "./Delayed Transfers of Care/Data/Nov_14.xls", mode="wb")}
if (!file.exists("./Delayed Transfers of Care/Data/Oct_14.xls")) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2014/05/LA-Type-B-October-2014-qQsu9.xls", "./Delayed Transfers of Care/Data/Oct_14.xls", mode="wb")}
if (!file.exists("./Delayed Transfers of Care/Data/Sept_14.xls")) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2014/05/LA-Type-B-September-2014-9Og8k.xls", "./Delayed Transfers of Care/Data/Sept_14.xls", mode="wb")}
if (!file.exists("./Delayed Transfers of Care/Data/Aug_14.xls")) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2014/05/LA-Type-B-August-2014-5Ersz.xls", "./Delayed Transfers of Care/Data/Aug_14.xls", mode="wb")}
if (!file.exists("./Delayed Transfers of Care/Data/July_14.xls")) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2014/05/LA-Type-B-July-2014-Jynk8.xls", "./Delayed Transfers of Care/Data/July_14.xls", mode="wb")}
if (!file.exists("./Delayed Transfers of Care/Data/June_14.xls")) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2014/05/LA-Type-B-June-2014-9DJx3.xls", "./Delayed Transfers of Care/Data/June_14.xls", mode="wb")}
if (!file.exists("./Delayed Transfers of Care/Data/May_14.xls")) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2014/05/LA-Type-B-May-2014-4iXvt.xls", "./Delayed Transfers of Care/Data/May_14.xls", mode="wb")}
if (!file.exists("./Delayed Transfers of Care/Data/April_14.xls")) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2014/05/LA-Type-B-April-2014-DCqI0.xls", "./Delayed Transfers of Care/Data/April_14.xls", mode="wb")}
if (!file.exists("./Delayed Transfers of Care/Data/March_14.xls")) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2013/05/LA-Type-B-March-2014-R04lg.xls", "./Delayed Transfers of Care/Data/March_14.xls", mode="wb")}
if (!file.exists("./Delayed Transfers of Care/Data/Feb_14.xls")) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2013/05/LA-Type-B-February-2014-q4561.xls", "./Delayed Transfers of Care/Data/Feb_14.xls", mode="wb")}
if (!file.exists("./Delayed Transfers of Care/Data/Jan_14.xls")) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2013/05/LA-Type-B-January-2014-cN7NU.xls", "./Delayed Transfers of Care/Data/Jan_14.xls", mode="wb")}
if (!file.exists("./Delayed Transfers of Care/Data/Dec_13.xls")) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2013/05/LA-Type-B-December-2013-qG5el.xls", "./Delayed Transfers of Care/Data/Dec_13.xls", mode="wb")}
if (!file.exists("./Delayed Transfers of Care/Data/Nov_13.xls")) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2013/05/LA-Type-B-November-2013-S055x.xls", "./Delayed Transfers of Care/Data/Nov_13.xls", mode="wb")}
if (!file.exists("./Delayed Transfers of Care/Data/Oct_13.xls")) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2013/05/LA-Type-B-October-2013-N8pto.xls", "./Delayed Transfers of Care/Data/Oct_13.xls", mode="wb")}
if (!file.exists("./Delayed Transfers of Care/Data/Sept_13.xls")) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2013/05/LA-Type-B-September-2013-1YV20.xls", "./Delayed Transfers of Care/Data/Sept_13.xls", mode="wb")}
if (!file.exists("./Delayed Transfers of Care/Data/Aug_13.xls")) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2013/05/LA-Type-B-August-2013-ZdYz5.xls", "./Delayed Transfers of Care/Data/Aug_13.xls", mode="wb")}
if (!file.exists("./Delayed Transfers of Care/Data/July_13.xls")) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2013/05/LA-Type-B-July-2013-B5Nmd.xls", "./Delayed Transfers of Care/Data/July_13.xls", mode="wb")}
if (!file.exists("./Delayed Transfers of Care/Data/June_13.xls")) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2013/05/LA-Type-B-June-2013-522rq.xls", "./Delayed Transfers of Care/Data/June_13.xls", mode="wb")}
if (!file.exists("./Delayed Transfers of Care/Data/May_13.xls")) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2013/05/LA-Type-B-May-2013-92547.xls", "./Delayed Transfers of Care/Data/May_13.xls", mode="wb")}
if (!file.exists("./Delayed Transfers of Care/Data/April_13.xls")) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2013/05/LA-Type-B-April-2013-NJ6oD.xls", "./Delayed Transfers of Care/Data/April_13.xls", mode="wb")}
if (!file.exists("./Delayed Transfers of Care/Data/March_13.xls")) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2013/04/LA-Type-B-March-2013-C2ubZ.xls", "./Delayed Transfers of Care/Data/March_13.xls", mode="wb")}
if (!file.exists("./Delayed Transfers of Care/Data/Feb_13.xls")) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2013/04/LA-Type-B-February-2013-vr84R.xls", "./Delayed Transfers of Care/Data/Feb_13.xls", mode="wb")}
if (!file.exists("./Delayed Transfers of Care/Data/Jan_13.xls")) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2013/04/LA-Type-B-January-2013-g1G5t.xls", "./Delayed Transfers of Care/Data/Jan_13.xls", mode="wb")}
if (!file.exists("./Delayed Transfers of Care/Data/Dec_12.xls")) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2013/04/LA-Type-B-December-2012-rev-April-2013.xls", "./Delayed Transfers of Care/Data/Dec_12.xls", mode="wb")}
if (!file.exists("./Delayed Transfers of Care/Data/Nov_12.xls")) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2013/04/LA-Type-B-November-2012-rev-April-2013.xls", "./Delayed Transfers of Care/Data/Nov_12.xls", mode="wb")}
if (!file.exists("./Delayed Transfers of Care/Data/Oct_12.xls")) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2013/04/LA-Type-B-October-2012-rev-April-2013.xls", "./Delayed Transfers of Care/Data/Oct_12.xls", mode="wb")}
if (!file.exists("./Delayed Transfers of Care/Data/Sept_12.xls")) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2013/04/LA-Type-B-September-2012-rev-April-2013.xls", "./Delayed Transfers of Care/Data/Sept_12.xls", mode="wb")}
if (!file.exists("./Delayed Transfers of Care/Data/Aug_12.xls")) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2013/04/LA-Type-B-August-2012-rev-April-2013.xls", "./Delayed Transfers of Care/Data/Aug_12.xls", mode="wb")}
if (!file.exists("./Delayed Transfers of Care/Data/July_12.xls")) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2013/04/LA-Type-B-July-2012-rev-April-2013.xls", "./Delayed Transfers of Care/Data/July_12.xls", mode="wb")}
if (!file.exists("./Delayed Transfers of Care/Data/June_12.xls")) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2013/04/LA-Type-B-June-2012-rev-April-2013.xls", "./Delayed Transfers of Care/Data/June_12.xls", mode="wb")}
if (!file.exists("./Delayed Transfers of Care/Data/May_12.xls")) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2013/04/LA-Type-B-May-2012-rev-April-2013.xls", "./Delayed Transfers of Care/Data/May_12.xls", mode="wb")}
if (!file.exists("./Delayed Transfers of Care/Data/April_12.xls")) {download.file("https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2013/04/LA-Type-B-April-2012-rev-April-2013.xls", "./Delayed Transfers of Care/Data/April_12.xls", mode="wb")}
if (!file.exists("./Delayed Transfers of Care/Data/March_12.xls")) {download.file("http://transparency.dh.gov.uk/files/2012/07/LA-Type-B-March-2011-12-revised-October-2012.xls", "./Delayed Transfers of Care/Data/March_12.xls", mode="wb")}
if (!file.exists("./Delayed Transfers of Care/Data/Feb_12.xls")) {download.file("http://transparency.dh.gov.uk/files/2012/07/LA-Type-B-February-2011-12-revised-October-2012.xls", "./Delayed Transfers of Care/Data/Feb_12.xls", mode="wb")}
if (!file.exists("./Delayed Transfers of Care/Data/Jan_12.xls")) {download.file("http://transparency.dh.gov.uk/files/2012/07/LA-Type-B-January-2011-12-revised-October-2012.xls", "./Delayed Transfers of Care/Data/Jan_12.xls", mode="wb")}
if (!file.exists("./Delayed Transfers of Care/Data/Dec_11.xls")) {download.file("http://webarchive.nationalarchives.gov.uk/20130227100129/http://www.dh.gov.uk/prod_consum_dh/groups/dh_digitalassets/@dh/@en/@ps/@sta/@perf/documents/digitalasset/dh_133782.xls", "./Delayed Transfers of Care/Data/Dec_11.xls", mode="wb")}
if (!file.exists("./Delayed Transfers of Care/Data/Nov_11.xls")) {download.file("http://webarchive.nationalarchives.gov.uk/20130227100129/http://www.dh.gov.uk/prod_consum_dh/groups/dh_digitalassets/@dh/@en/@ps/@sta/@perf/documents/digitalasset/dh_133778.xls", "./Delayed Transfers of Care/Data/Nov_11.xls", mode="wb")}
if (!file.exists("./Delayed Transfers of Care/Data/Oct_11.xls")) {download.file("http://webarchive.nationalarchives.gov.uk/20130227100129/http://www.dh.gov.uk/prod_consum_dh/groups/dh_digitalassets/@dh/@en/@ps/@sta/@perf/documents/digitalasset/dh_133774.xls", "./Delayed Transfers of Care/Data/Oct_11.xls", mode="wb")}
if (!file.exists("./Delayed Transfers of Care/Data/Sept_11.xls")) {download.file("http://webarchive.nationalarchives.gov.uk/20130227100129/http://www.dh.gov.uk/prod_consum_dh/groups/dh_digitalassets/@dh/@en/@ps/@sta/@perf/documents/digitalasset/dh_133770.xls", "./Delayed Transfers of Care/Data/Sept_11.xls", mode="wb")}
if (!file.exists("./Delayed Transfers of Care/Data/Aug_11.xls")) {download.file("http://webarchive.nationalarchives.gov.uk/20130227100129/http://www.dh.gov.uk/prod_consum_dh/groups/dh_digitalassets/@dh/@en/@ps/@sta/@perf/documents/digitalasset/dh_133766.xls", "./Delayed Transfers of Care/Data/Aug_11.xls", mode="wb")}
if (!file.exists("./Delayed Transfers of Care/Data/July_11.xls")) {download.file("http://webarchive.nationalarchives.gov.uk/20130227100129/http://www.dh.gov.uk/prod_consum_dh/groups/dh_digitalassets/@dh/@en/@ps/@sta/@perf/documents/digitalasset/dh_133762.xls", "./Delayed Transfers of Care/Data/July_11.xls", mode="wb")}
if (!file.exists("./Delayed Transfers of Care/Data/June_11.xls")) {download.file("http://webarchive.nationalarchives.gov.uk/20130227100129/http://www.dh.gov.uk/prod_consum_dh/groups/dh_digitalassets/@dh/@en/@ps/@sta/@perf/documents/digitalasset/dh_133758.xls", "./Delayed Transfers of Care/Data/June_11.xls", mode="wb")}
if (!file.exists("./Delayed Transfers of Care/Data/May_11.xls")) {download.file("http://webarchive.nationalarchives.gov.uk/20130227100129/http://www.dh.gov.uk/prod_consum_dh/groups/dh_digitalassets/@dh/@en/@ps/@sta/@perf/documents/digitalasset/dh_133754.xls", "./Delayed Transfers of Care/Data/May_11.xls", mode="wb")}
if (!file.exists("./Delayed Transfers of Care/Data/April_11.xls")) {download.file("http://webarchive.nationalarchives.gov.uk/20130227100129/http://www.dh.gov.uk/prod_consum_dh/groups/dh_digitalassets/@dh/@en/@ps/@sta/@perf/documents/digitalasset/dh_133750.xls", "./Delayed Transfers of Care/Data/April_11.xls", mode="wb")}


# Days delayed by reason ####

# Create an empty df ready to put in all the data
Days_reason <- data.frame(SHA = factor(), CODE = factor(), NAME = factor(), `A) AWAITING COMPLETION OF ASSESSMENT` = numeric(), `B) AWAITING PUBLIC FUNDING` = numeric(), `C) AWAITING FURTHER NON-ACUTE NHS CARE` = numeric(), `DI) AWAITING RESIDENTIAL HOME PLACEMENT OR AVAILABILITY` = numeric(), `DII) AWAITING NURSING HOME PLACEMENT OR AVAILABILITY` = numeric(), `E) AWAITING CARE PACKAGE IN OWN HOME` = numeric(), `F) AWAITING COMMUNITY EQUIPMENT AND ADAPTATIONS` = numeric(), `G) PATIENT OR FAMILY CHOICE` = numeric(), `H) DISPUTES` = numeric(), `I) HOUSING - PATIENTS NOT COVERED BY NHS AND COMMUNITY CARE ACT` = numeric(), TOTAL = numeric(), PERIOD_YEAR = factor(), check.names = FALSE)


for (i in 1:length(list.files("./Delayed Transfers of Care/Data")))   {
  Month <- read_excel(paste("./Delayed Transfers of Care/Data", list.files("./Delayed Transfers of Care/Data")[i], sep = "/"), sheet = "LA - by reason", skip = 13)
  Month$PERIOD_YEAR <- as.character(read_excel(paste("./Delayed Transfers of Care/Data", list.files("./Delayed Transfers of Care/Data")[i], sep = "/"), sheet = "LA - by reason", range = "R5C3:R5C3", col_names = FALSE))
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
Days_reason <- subset(Days_reason, !is.na(NAME)) # remove rows with no data for name

# These commands tidy up some formatting (they are essentially find and replace commands)
Days_reason$NAME <- gsub(" UA", "", Days_reason$NAME)
Days_reason$NAME <- gsub("Isle Of Wight", "Isle of Wight", Days_reason$NAME)
Days_reason$NAME <- gsub("Medway Towns", "Medway", Days_reason$NAME)

Days_reason <- Days_reason[c("CODE","NAME","A) AWAITING COMPLETION OF ASSESSMENT", "B) AWAITING PUBLIC FUNDING", "C) AWAITING FURTHER NON-ACUTE NHS CARE", "DI) AWAITING RESIDENTIAL HOME PLACEMENT OR AVAILABILITY", "DII) AWAITING NURSING HOME PLACEMENT OR AVAILABILITY", "E) AWAITING CARE PACKAGE IN OWN HOME", "F) AWAITING COMMUNITY EQUIPMENT AND ADAPTATIONS", "G) PATIENT OR FAMILY CHOICE", "H) DISPUTES", "I) HOUSING - PATIENTS NOT COVERED BY NHS AND COMMUNITY CARE ACT","O) OTHER", "TOTAL", "PERIOD_YEAR" )]

colnames(Days_reason) <- c("Code", "Name", "Awaiting completion of assessment", "Awaiting public funding", "Awaiting further NHS non-acute care", "Awaiting residential home placement or availability", "Awaiting nursing home placement or availability", "Awaiting care package in own home", "Awaiting community equipment and adaptations", "Patient or family choice", "Disputes", "Housing - Patients not covered by NHS and Community Care Act","Other", "Total Delayed Transfers of Care","Period")

#### gsub thousand separator from each number.
Days_reason$`Awaiting completion of assessment` <- gsub(",","",Days_reason$`Awaiting completion of assessment`)
Days_reason$`Awaiting public funding` <- gsub(",","",Days_reason$`Awaiting public funding`)
Days_reason$`Awaiting further NHS non-acute care` <- gsub(",","",Days_reason$`Awaiting further NHS non-acute care`)
Days_reason$`Awaiting residential home placement or availability` <- gsub(",","",Days_reason$`Awaiting residential home placement or availability`)
Days_reason$`Awaiting nursing home placement or availability` <- gsub(",","",Days_reason$`Awaiting nursing home placement or availability`)
Days_reason$`Awaiting care package in own home` <- gsub(",","", Days_reason$`Awaiting care package in own home`)
Days_reason$`Awaiting community equipment and adaptations` <- gsub(",","",Days_reason$`Awaiting community equipment and adaptations`)
Days_reason$`Patient or family choice` <- gsub(",","",Days_reason$`Patient or family choice`)
Days_reason$Disputes <- gsub(",","",Days_reason$Disputes)
Days_reason$`Housing - Patients not covered by NHS and Community Care Act` <- gsub(",","",Days_reason$`Housing - Patients not covered by NHS and Community Care Act`)
Days_reason$`Total Delayed Transfers of Care` <- gsub(",","",Days_reason$`Total Delayed Transfers of Care`)

# There are no data given for City of London (code 714), residents of Scotland (code 9901), or outside of GB (9902) and their presence in the dataframe confuses R into thinking that the field is not numerical. So bin them...
Days_reason <- subset(Days_reason, !(Name %in% c("Resident in Scotland","Resident In Wales","Resident outside GB", "City Of London")))

write.csv(Days_reason, paste("./Delayed Transfers of Care/DToC_Days_Reason_for_Delay_created_",format(Sys.Date(), "%B_%Y"),".csv", sep = ""), row.names = FALSE, na = "NA")

# Clear workspace
rm(list = ls())

# DToC by responsible organisation ####

# Create an empty df ready to put in all the data
Days_organisation <- data.frame(SHA = factor(), Code = factor(), Name = factor(), NHS = integer(),`Social Care` = integer(), Both = integer(),Total = integer(), check.names = FALSE)

for (i in 1:length(list.files("./Delayed Transfers of Care/Data")))   {
  Month <- read_excel(paste("./Delayed Transfers of Care/Data", list.files("./Delayed Transfers of Care/Data")[i], sep="/"), sheet = "LA - by responsible org", skip = 13)
  
  Month <- Month %>% 
    select(1:7)
  
  colnames(Month) <- c("Region", "ONS Geography", "Code", "Name", "NHS", "Social Care", "Both")
  
  Month$Period_year <- as.character(read_excel(paste("./Delayed Transfers of Care/Data", list.files("./Delayed Transfers of Care/Data")[i], sep="/"), sheet = "LA - by responsible org", range = "R5C3:R5C3", col_names = FALSE))
  colnames(Month)[colnames(Month) == "ONS Geography"] <- "Code"
  Days_organisation <- rbind.fill(Days_organisation, Month) # This adds the data to a bigger dataframe called Days_reason (which we set up earlier)
  rm(Month) 
  }

# Clean up Days_organisation ####
Days_organisation$SHA = NULL # remove SHA
Days_organisation$Region <- NULL
Days_organisation$X__1 <- NULL
Days_organisation$NHS__1 <- NULL
Days_organisation$`Social Care__1` <- NULL
Days_organisation$Both__1 <- NULL
Days_organisation$Total__1 <- NULL
  
Days_organisation$Name <- gsub(" UA","",Days_organisation$Name)
Days_organisation <- subset(Days_organisation, !is.na(Name)) # remove rows where there is no name
Days_organisation$Name <- gsub("Isle Of Wight", "Isle of Wight", Days_organisation$Name)
Days_organisation$Name <- gsub("Medway Towns", "Medway", Days_organisation$Name)

# There are no data given for City of London (code 714), residents of Scotland (code 9901), or outside of GB (9902) and their presence in the dataframe confuses R into thinking that the field is not numerical. So bin them...
Days_organisation <- subset(Days_organisation,  !(Name %in% c("Resident in Scotland","Resident In Wales","Resident outside GB", "City Of London")))
Days_organisation$Code <- NULL

# The number of DToCs has been copied over as strings, so if we try to coerce the fields into numbers, any that have been given a thousand separator (,) will appear as blank cells.
# As such, we need to remove all of the commas from the cells
Days_organisation$NHS <- gsub(",","",Days_organisation$NHS)
Days_organisation$`Social Care` <- gsub(",","",Days_organisation$`Social Care`)
Days_organisation$Both <- gsub(",","",Days_organisation$Both)
Days_organisation$Total <- gsub(",","",Days_organisation$Total)

write.csv(Days_organisation, paste("./Delayed Transfers of Care/DToC_Days_Responsible_Organisation_created_",format(Sys.Date(), "%B_%Y"),".csv", sep = ""), row.names = FALSE)

rm(list = ls())




