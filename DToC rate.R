
library(easypackages)

libraries("png", "gridExtra", "xlsx", "plyr", "dplyr", "tidyverse", "reshape2", "scales", "xts", "dygraphs", "grid", "htmlwidgets")


chosen_area <- "West Sussex"

month_order <- c("May 2011", "June 2011", "July 2011", "August 2011", "September 2011", "October 2011", "November 2011", "December 2011", "January 2012", "February 2012", "March 2012", "April 2012", "May 2012", "June 2012", "July 2012", "August 2012", "September 2012", "October 2012", "November 2012", "December 2012", "January 2013", "February 2013", "March 2013", "April 2013", "May 2013", "June 2013", "July 2013", "August 2013", "September 2013", "October 2013", "November 2013", "December 2013", "January 2014", "February 2014", "March 2014", "April 2014", "May 2014", "June 2014", "July 2014", "August 2014", "September 2014", "October 2014", "November 2014", "December 2014", "January 2015", "February 2015", "March 2015", "April 2015", "May 2015", "June 2015", "July 2015", "August 2015", "September 2015", "October 2015", "November 2015", "December 2015", "January 2016", "February 2016", "March 2016", "April 2016", "May 2016", "June 2016", "July 2016", "August 2016", "September 2016", "October 2016", "November 2016", "December 2016", "January 2017", "February 2017", "March 2017", "April 2017", "May 2017", "June 2017", "July 2017", "August 2017", "September 2017", "October 2017", "November 2017", "December 2017", "January 2018", "February 2018", "March 2018", "April 2018", "May 2018", "June 2018", "July 2018", "August 2018", "September 2018", "October 2018", "November 2018", "December 2018", "January 2019", "February 2019", "March 2019", "April 2019")

quarter_months <- c(month_order[length(month_order)-69],month_order[length(month_order)-66],month_order[length(month_order)-63],month_order[length(month_order)-60],month_order[length(month_order)-57],month_order[length(month_order)-54],month_order[length(month_order)-51],month_order[length(month_order)-48],month_order[length(month_order)-45],month_order[length(month_order)-42],month_order[length(month_order)-39],month_order[length(month_order)-36],month_order[length(month_order)-33],month_order[length(month_order)-30],month_order[length(month_order)-27],month_order[length(month_order)-24],month_order[length(month_order)-21],month_order[length(month_order)-18],month_order[length(month_order)-15],month_order[length(month_order)-12],month_order[length(month_order)-9],month_order[length(month_order)-6],month_order[length(month_order)-3], month_order[length(month_order)])


Combined_Month_persons <- read_csv("./Delayed Transfers of Care/DToC_Persons_Reason_for_Delay_created_June_2019.csv")

/Users/richtyler/Dropbox/Work/Delayed Transfers of Care/DToC_Days_Reason_for_Delay_created_June_2019.csv

Combined_Month_persons <- subset(Combined_Month_persons, Period %in% month_order)

pop_total = rio::import("./Data/Population/MYE2_population_by_sex_and_age_for_local_authorities_UK_2015.xlsx", which = 2, skip = 2)

pop_total$pop_18 <- rowSums(pop_total[,22:94])
pop_total$pop_under18 <- rowSums(pop_total[,4:21])


total_pop <- pop_total[c("NAME","ALL AGES", "pop_18", "pop_under18")]

total_pop$NAME <- gsub("ENGLAND","England", total_pop$NAME)
total_pop$NAME <- gsub("WALES","Wales", total_pop$NAME)
total_pop$NAME <- gsub(" and "," & ", total_pop$NAME, ignore.case = TRUE)
total_pop$NAME <- gsub(", City of","", total_pop$NAME)
total_pop$NAME <- gsub(", County of","", total_pop$NAME)
total_pop$NAME <- gsub("County Durham","Durham", total_pop$NAME)
total_pop$NAME <- gsub("Southend-on-Sea","Southend", total_pop$NAME)

DToCs <- Combined_Month_persons[c("Name", "Period","Total Delayed Transfers of Care")]

DToCs$Name <- gsub(" With "," with ", DToCs$Name)
DToCs$Name <- gsub(" and "," & ", DToCs$Name, ignore.case = TRUE)
DToCs$Name <- gsub(" Of "," of ", DToCs$Name)
DToCs$Name <- gsub(" Upon "," upon ", DToCs$Name)
DToCs$Name <- gsub("Resident In Wales","Wales", DToCs$Name)
DToCs$Name <- gsub("Stockton On Tees","Stockton-on-Tees", DToCs$Name)
DToCs$Name <- gsub("Stoke-On-Trent","Stoke-on-Trent", DToCs$Name)
DToCs$Name <- gsub("St Helens","St. Helens", DToCs$Name)

DToC_rate <- merge(DToCs, total_pop, by.x = "Name", "NAME")

DToC_rate$Crude_rate <- round(DToC_rate$`Total Delayed Transfers of Care` / DToC_rate$pop_18 * 100000,1)

DToC_rate$Date <- paste("01 ", DToC_rate$Period, sep = "")
DToC_rate$Acc_date <- as.Date(DToC_rate$Date, "%d %B %Y")
DToC_rate_comparison <- subset(DToC_rate, Name %in% c("West Sussex", "England"))
DToC_rate_comparison <- dcast(DToC_rate_comparison, Date + Acc_date ~ Name, value.var="Crude_rate")
DToC_rate_comparison <- DToC_rate_comparison[c("Date","Acc_date","West Sussex","England")]
DToC_rate_comparison <- xts(DToC_rate_comparison,  DToC_rate_comparison$Acc_date)

Total_DToC_rate <- dygraph(DToC_rate_comparison, main = "Crude rate of Delayed Transfers of Care (Patients); persons per 100,000 population (aged 18+ years)", ylab = "Crude rate of days delayed per 100,000 (18+)", xlab = "Month") %>% 
  dyHighlight(highlightSeriesOpts = list(strokeWidth = 2)) %>%
  dyLegend(show = "onmouseover", width = 500,  labelsSeparateLines = FALSE) %>%
  dyRangeSelector(dateWindow = c("2016-01-01", "2017-04-01"), height = 20, strokeColor = "") %>%
  dyAxis("x", drawGrid = FALSE) %>%
  dyAxis("y", valueRange = c(0, 25)) %>%
    dyOptions(includeZero = TRUE) %>%
  dyCSS("./Scripts/General output tools/dyg_dtoc.css")

Total_DToC_rate

saveWidget(Total_DToC_rate, "Delayed Transfers of Care Patients Crude rate.html", selfcontained = TRUE)

# Reasons ####

DToC_reasons <- Combined_Month_persons[c("Name", "Period","Completion of assessment", "Public funding", "Waiting further NHS non-acute care", "Awaiting residential home placement or availability", "Awaiting nursing home placement or availability", "Awaiting care package in own home", "Awaiting community equipment and adaptions", "Patient or family choice", "Disputes", "Housing - Patients not covered by NHS and Community Care Act", "Total Delayed Transfers of Care")]

DToC_reasons$Name <- gsub(" With "," with ", DToC_reasons$Name)
DToC_reasons$Name <- gsub(" and "," & ", DToC_reasons$Name, ignore.case = TRUE)
DToC_reasons$Name <- gsub(" Of "," of ", DToC_reasons$Name)
DToC_reasons$Name <- gsub(" Upon "," upon ", DToC_reasons$Name)
DToC_reasons$Name <- gsub("Resident In Wales","Wales", DToC_reasons$Name)
DToC_reasons$Name <- gsub("Stockton On Tees","Stockton-on-Tees", DToC_reasons$Name)
DToC_reasons$Name <- gsub("Stoke-On-Trent","Stoke-on-Trent", DToC_reasons$Name)
DToC_reasons$Name <- gsub("St Helens","St. Helens", DToC_reasons$Name)

DToC_reasons_rate <- merge(DToC_reasons, total_pop, by.x = "Name", "NAME")

DToC_reasons_rate$`Completion of assessment Crude rate` <- round(DToC_reasons_rate$`Completion of assessment` / DToC_reasons_rate$pop_18 * 100000,1)
DToC_reasons_rate$`Public funding Crude rate` <- round(DToC_reasons_rate$`Public funding` / DToC_reasons_rate$pop_18 * 100000,1)
DToC_reasons_rate$`Waiting further NHS non-acute care Crude rate` <- round(DToC_reasons_rate$`Waiting further NHS non-acute care` / DToC_reasons_rate$pop_18 * 100000,1)
DToC_reasons_rate$`Awaiting residential home placement or availability Crude rate` <- round(DToC_reasons_rate$`Awaiting residential home placement or availability` / DToC_reasons_rate$pop_18 * 100000,1)
DToC_reasons_rate$`Awaiting nursing home placement or availability Crude rate` <- round(DToC_reasons_rate$`Awaiting nursing home placement or availability` / DToC_reasons_rate$pop_18 * 100000,1)
DToC_reasons_rate$`Awaiting care package in own home Crude rate` <- round(DToC_reasons_rate$`Awaiting care package in own home` / DToC_reasons_rate$pop_18 * 100000,1)
DToC_reasons_rate$`Awaiting community equipment and adaptions Crude rate` <- round(DToC_reasons_rate$`Awaiting community equipment and adaptions` / DToC_reasons_rate$pop_18 * 100000,1)
DToC_reasons_rate$`Patient or family choice Crude rate` <- round(DToC_reasons_rate$`Patient or family choice` / DToC_reasons_rate$pop_18 * 100000,1)
DToC_reasons_rate$`Disputes Crude rate` <- round(DToC_reasons_rate$Disputes / DToC_reasons_rate$pop_18 * 100000,1)
DToC_reasons_rate$`Housing - Patients not covered by NHS and Community Care Act Crude rate` <- round(DToC_reasons_rate$`Housing - Patients not covered by NHS and Community Care Act` / DToC_reasons_rate$pop_18 * 100000,1)
DToC_reasons_rate$`Total Delayed Transfers of Care Crude rate` <- round(DToC_reasons_rate$`Total Delayed Transfers of Care` / DToC_reasons_rate$pop_18 * 100000,1)

Table_DToC_reasons_rate <- DToC_reasons_rate

DToC_reasons_rate <- DToC_reasons_rate[c("Name", "Period",  "Completion of assessment Crude rate", "Public funding Crude rate", "Waiting further NHS non-acute care Crude rate", "Awaiting residential home placement or availability Crude rate", "Awaiting nursing home placement or availability Crude rate", "Awaiting care package in own home Crude rate", "Awaiting community equipment and adaptions Crude rate", "Patient or family choice Crude rate", "Disputes Crude rate", "Housing - Patients not covered by NHS and Community Care Act Crude rate" )]

DToC_reasons_rate$Date <- paste("01 ", DToC_reasons_rate$Period, sep = "")
DToC_reasons_rate$Acc_date <- as.Date(DToC_reasons_rate$Date, "%d %B %Y")
DToC_reasons_rate_comparison <- subset(DToC_reasons_rate, Name %in% c("West Sussex"))

DToC_reasons_rate_comparison <- xts(DToC_reasons_rate_comparison,  DToC_reasons_rate_comparison$Acc_date)

WSx_DToC_crude_rate_chart <- dygraph(DToC_reasons_rate_comparison[,2:13], main = paste("Delayed Transfers of Care (Patients) per 100,000 population (aged 18+)<br>by reason for delay  - ", chosen_area, sep = "" ), ylab = "Number of patients delayed<br>per 100,000 population (18+)", xlab = "Month") %>% 
  dyHighlight(highlightSeriesOpts = list(strokeWidth = 2)) %>%
  dyLegend(show = "always", width = 500) %>%
  dyRangeSelector(dateWindow = c("2016-01-01", "2017-04-01"), height = 20, strokeColor = "") %>%
  dyAxis("x", drawGrid = FALSE) %>%
  dyAxis("y", valueRange = c(0, 5)) %>%
  dyOptions(includeZero = TRUE) %>%
  dyCSS("./Scripts/General output tools/dyg.css")

WSx_DToC_crude_rate_chart

saveWidget(WSx_DToC_crude_rate_chart, "Crude rate of Delayed Transfer of Care by reason West Sussex.html", selfcontained = TRUE)

DToC_reasons_rate_England <- subset(DToC_reasons_rate, Name %in% c("England"))
DToC_reasons_rate_England <- xts(DToC_reasons_rate_England,  DToC_reasons_rate_England$Acc_date)

Eng_DToC_crude_rate_chart <- dygraph(DToC_reasons_rate_England[,2:13], main = "Delayed Transfers of Care (Patients) per 100,000 population(aged 18+)<br>by reason for delay  - England", ylab = "Number of patients delayed<br>per 100,000 population (18+)", xlab = "Month") %>% 
  dyHighlight(highlightSeriesOpts = list(strokeWidth = 2)) %>%
  dyLegend(show = "always", width = 500) %>%
  dyRangeSelector(dateWindow = c("2016-01-01", "2017-04-01"), height = 20, strokeColor = "") %>%
  dyAxis("x", drawGrid = FALSE) %>%
  dyAxis("y", valueRange = c(0, 5)) %>%
  dyOptions(includeZero = TRUE) %>%
  
  dyCSS("./Scripts/General output tools/dyg.css")

saveWidget(Eng_DToC_crude_rate_chart, "Crude rate of Delayed Transfer of Care by reason England.html", selfcontained = TRUE)

Table_DToC_reasons_rate$Period <- factor(Table_DToC_reasons_rate$Period, levels = month_order)

Table_DToC_reasons_rate <- arrange(Table_DToC_reasons_rate, Name, desc(Period))

colnames(Table_DToC_reasons_rate) <- c("Area name", "Month","Delays due to completion of assessment","Delays due to public funding", "Delays due to waiting further NHS non-acute care","Delays due to awaiting residential home placement or availability", "Delays due to awaiting nursing home placement or availability", "Delays due to awaiting care package in own home", "Delays due to awaiting community equipment and adaptions","Delays due to patient or family", "Delays due to disputes","Delays due to housing - not covered by NHS and Community Care Act", "Total Delayed Transfers of Care",  "Total population (mid 2015 estimate)", "Completion of assessment crude rate per 100,000 population (aged 18+)",  "Public funding crude rate per 100,000 population (aged 18+)", "Waiting further NHS non-acute care crude rate per 100,000 population (aged 18+)", "Awaiting residential home placement or availability crude rate per 100,000 population (aged 18+)", "Awaiting nursing home placement or availability crude rate per 100,000 population (aged 18+)", "Awaiting care package in own home crude rate per 100,000 population (aged 18+)", "Awaiting community equipment and adaptions crude rate per 100,000 population (aged 18+)", "Patient or family choice crude rate per 100,000 population (aged 18+)", "Disputes crude rate per 100,000 population (aged 18+)", "Housing - Patients not covered by NHS and Community Care Act crude rate per 100,000 population (aged 18+)", "Total Delayed Transfers of Care crude rate per 100,000 population (aged 18+)"  )

`Number of DToCs` <- Table_DToC_reasons_rate[c("Area name", "Month","Delays due to completion of assessment","Delays due to public funding", "Delays due to waiting further NHS non-acute care","Delays due to awaiting residential home placement or availability", "Delays due to awaiting nursing home placement or availability", "Delays due to awaiting care package in own home", "Delays due to awaiting community equipment and adaptions","Delays due to patient or family", "Delays due to disputes","Delays due to housing - not covered by NHS and Community Care Act", "Total Delayed Transfers of Care")]

`Crude rates of DToCs` <- Table_DToC_reasons_rate[c("Area name", "Month", "Total population (mid 2015 estimate)", "Total Delayed Transfers of Care crude rate per 100,000 population (aged 18+)","Completion of assessment crude rate per 100,000 population (aged 18+)",  "Public funding crude rate per 100,000 population (aged 18+)", "Waiting further NHS non-acute care crude rate per 100,000 population (aged 18+)", "Awaiting residential home placement or availability crude rate per 100,000 population (aged 18+)", "Awaiting nursing home placement or availability crude rate per 100,000 population (aged 18+)", "Awaiting care package in own home crude rate per 100,000 population (aged 18+)", "Awaiting community equipment and adaptions crude rate per 100,000 population (aged 18+)", "Patient or family choice crude rate per 100,000 population (aged 18+)", "Disputes crude rate per 100,000 population (aged 18+)", "Housing - Patients not covered by NHS and Community Care Act crude rate per 100,000 population (aged 18+)")]

# Output

source("./Scripts/Functions/FUNCTION saving multiple dataframes to excel.R")

save.xlsx(paste("./Delayed Transfers of Care/DToC Reasons Tables ",format(Sys.Date(), "%B-%Y"),".xlsx", sep = ""), `Number of DToCs`, `Crude rates of DToCs`)

rm(list = ls())


# WHAT ABOUT CALENDAR ADJUSTMENT ####
# Average daily days rather than totals per month as months do not have equal lengths #