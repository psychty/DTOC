# Delayed Transfers of Care - source - NHS Statistics

library(png)
library(gridExtra)
library(reshape2)
library(tidyverse)
library(plyr)
library(grid)
library(readr)
library(scales)
library(xlsx)

ch_area = "West Sussex"

# This is the template for charts
DToC_theme = function(){
  theme( legend.position = "bottom", 
         axis.text.x = element_text(angle = 90, hjust = 1, vjust = .5, size = 8), 
         plot.background = element_rect(fill = "white", colour = "#E2E2E3"), 
         panel.background = element_rect(fill = NA), 
         axis.line = element_line(colour = "#E7E7E7", size = .3),
         axis.text = element_text(colour = "#000000", size = 8), 
         plot.title = element_text(colour = "#000000", face = "bold", size = 10, vjust = -.5), 
         axis.title = element_text(colour = "#000000", face = "bold", size = 8),     
         panel.grid.major.x = element_blank(), 
         panel.grid.minor.x = element_blank(), 
         panel.grid.major.y = element_line(colour = "#E2E2E3", linetype = "dashed", size = 0.2), 
         panel.grid.minor.y = element_blank(), 
         strip.text = element_text(colour = "white"), 
         strip.background = element_rect(fill = "#327d9c"),
         axis.ticks = element_line(colour = "#9e9e9e"),
         legend.text = element_text(colour = "#000000", size = 10))
}


Days_organisation <- read_csv("./Delayed Transfers of Care/DToC_Days_Responsible_Organisation_created_July_2019.csv",col_types = cols(Name = col_character(),NHS = col_integer(),`Social Care` = col_integer(),Both = col_integer(),Total = col_integer(),Period_year = col_character())) %>% 
  mutate(Month = paste("01", Period_year, sep = " ")) %>% 
  mutate(Month = as.Date(Month, format = "%d %b %Y")) %>% 
  arrange(Month) %>% 
  filter(Period_year %in% c("November 2016",  "December 2016",  "January 2017",   "February 2017",  "March 2017", "April 2017",  "May 2017",  "June 2017","July 2017","August 2017","September 2017","October 2017","November 2017","December 2017","January 2018","February 2018","March 2018","April 2018","May 2018","June 2018","July 2018","August 2018","September 2018", "October 2018", "November 2018", "December 2018", "January 2019", "February 2019", "March 2019", "April 2019")) %>% 
  mutate(Total = NHS + `Social Care` + Both)

month_order <-  as.character(unique(Days_organisation$Period_year))

# Days Delayed ####
Days_organisation <- Days_organisation %>% 
  mutate(Period_year = factor(Period_year, levels = month_order)) %>% 
  arrange(Name, Period_year) %>% 
  mutate(Perc_NHS = NHS/Total,
         Perc_Social_care = `Social Care`/Total,
         Perc_Both = Both/Total)

Chosen_DToC_days <- Days_organisation %>% 
  filter(Name == ch_area)

# We need to put the data into long format format to plot a stacked bar chart
Chosen_DToC_days_long <- Chosen_DToC_days %>% 
  select(Name,Period_year,NHS,`Social Care`,Both) %>% 
  gather(key = "Organisation", value = "Days", NHS:Both) %>% 
  mutate(Organisation = factor(Organisation, levels = c("Both", "Social Care", "NHS"))) %>% 
  arrange(Organisation) 


chosen_DToC_chart <-   ggplot(data = Chosen_DToC_days_long, aes(x = Period_year, y = Days, fill = Organisation)) + 
  geom_bar(stat = "identity", width = 0.8) +
  scale_y_continuous(breaks = seq(0, round_any(max(Chosen_DToC_days$Total), 500, ceiling), ifelse(round_any(max(Chosen_DToC_days$Total), 500, ceiling) < 5000, 250, 500)), expand = c(0.01,0), limits = c(0, round_any(max(Chosen_DToC_days$Total), 500, ceiling)), labels = comma) +   scale_fill_manual(values = c("#4F81BD","#C0504D", "#000000"), limits = c("NHS","Social Care", "Both"), labels = c("NHS","Social Care", "Both NHS and Social Care"), name = "Delay attributed to") +  
  ylab("Delayed Days") +
  xlab("Month") +
  labs(caption = "Source: NHS England") +
  DToC_theme() +
  theme(legend.position = "top", legend.direction = "horizontal", legend.text = element_text(size = 8), legend.title = element_text(size = 8), legend.key.size = unit(.75, "lines"))  


ggsave(paste0("./Delayed Transfers of Care/",ch_area ,"_DToC_Chart_", month_order[1], " - ",month_order[length(month_order)] ,".png"), plot = chosen_DToC_chart, width = 8, height = 4, dpi = 300)

Total_DToC <- read_csv("./Delayed Transfers of Care/DToC_Days_Reason_for_Delay_created_July_2019.csv")

Total_DToC$Date <- paste("01 ", Total_DToC$Period, sep = "")
Total_DToC$Date <- as.Date(Total_DToC$Date, "%d %B %Y")
Total_DToC <- Total_DToC[c("Total Delayed Transfers of Care", "Period","Date", "Name")]
Total_DToC <- arrange(Total_DToC, Date)

Org_name <- ch_area

Org_DToC <- subset(Total_DToC, Name == Org_name)
months <- as.character(Org_DToC$Period)
Org_DToC$Period <- factor(Org_DToC$Period, levels = months)
Org_DToC$long_term_ave <- round(mean(Org_DToC$`Total Delayed Transfers of Care`, na.rm = TRUE),0)
Org_DToC$LCL_3SD <- round(Org_DToC$long_term_ave- (3*sd(Org_DToC$`Total Delayed Transfers of Care`, na.rm = FALSE)),0)
Org_DToC$LCL_2SD <- round(Org_DToC$long_term_ave- (2*sd(Org_DToC$`Total Delayed Transfers of Care`, na.rm = FALSE)),0)
Org_DToC$UCL_2SD <- round(Org_DToC$long_term_ave + (2*sd(Org_DToC$`Total Delayed Transfers of Care`, na.rm = FALSE)),0)
Org_DToC$UCL_3SD <- round(Org_DToC$long_term_ave + (3*sd(Org_DToC$`Total Delayed Transfers of Care`, na.rm = FALSE)),0)
Org_DToC$order <- 1:nrow(Org_DToC)

chosen_DToC_control_chart <- ggplot(data = Org_DToC, aes(x = Period, y = `Total Delayed Transfers of Care`, group = 1)) +   geom_line(colour = "#61B5CD") +
  xlab("Month") +
  ylab("Total Delayed Days") +
  # ggtitle(paste("Total number of bed days lost due to delayed transfers of care during each reporting period, Acute and Non-Acute;\n", Org_name, " Local Authority; Monthly reporting (", months[1], " to ", months[length(months)], ")", sep = "")) +
  geom_hline(aes(yintercept=UCL_2SD),colour = "#F79646", linetype="dashed", lwd = .6) + 
  geom_hline(aes(yintercept=LCL_2SD),colour = "#F79646", linetype="dashed", lwd = .6) +
  geom_hline(aes(yintercept=UCL_3SD),colour = "#A8423F", linetype="dashed", lwd = .7) + 
  geom_hline(aes(yintercept=LCL_3SD),colour = "#A8423F", linetype="dashed", lwd = .7) +
  geom_hline(aes(yintercept = long_term_ave), colour = "#264852", lwd = .8) +
  geom_smooth(aes(),method='lm',  se = FALSE, colour = "black", lwd = .6) +
  scale_y_continuous(breaks = seq(1000, 4500, 250), limits = c(1000, 4500), labels = comma) + 
  geom_text(data= subset(Org_DToC, Period %in%c("January 2017", "August 2017")), aes(label=paste(format(`Total Delayed Transfers of Care`, big.mark = ","),sep="")), hjust = 1, vjust = -1, size = 3) +
  geom_text(data= subset(Org_DToC, Period %in%c("September 2017")), aes(label=paste(format(`Total Delayed Transfers of Care`, big.mark = ","),sep="")), hjust = 0, vjust = -1, size = 3) +
  geom_text(data = subset(Org_DToC, Period %in%c("April 2014")), aes(label=paste(format(`Total Delayed Transfers of Care`, big.mark = ","),sep="")), hjust = 1, vjust = 1.75, size = 3) +
  geom_point(aes(x = Period, y = `Total Delayed Transfers of Care`, fill =  "#B2DCE6"), colour="#61B5CD", size = 4, shape = 21, show.legend = FALSE) +
  scale_fill_manual(values = "#B2DCE6", label = "Delayed days", name = "") +
  DToC_theme() +
  labs(caption = "Note: Y axis does not start at zero.\nThe dashed inner and outer lines represent 95% (2 SD) and 99% (3 SD) control limits respectively\nThe solid line represents the long term average\nSource: NHS England: Monthly Situation Report")


ggsave(paste0("./Delayed Transfers of Care/",ch_area ,"_DToC_control_chart_", month_order[1], " - ",month_order[length(month_order)] ,".png"), plot = chosen_DToC_control_chart, width = 8, height = 4, dpi = 300)

# Output ####

Chosen_DToC_days_tb <- as.data.frame(Chosen_DToC_days[c("Name","Period_year","NHS","Social Care","Both","Total","Perc_NHS", "Perc_Social_care", "Perc_Both")])

# create a new workbook for outputs
# possible values for type are : "xls" and "xlsx"
wb <- createWorkbook(type = "xlsx")

# Title and sub title styles
cs_wb_title <- CellStyle(wb) + 
  Font(wb,  heightInPoints = 12, isBold = TRUE, underline = 1, name = "Calibri")

# Styles for the data table row/column names

cs_title <- CellStyle(wb) +
  Font(wb, heightInPoints = 12, isBold = TRUE, isItalic = FALSE, name="Calibri") +   Alignment(horizontal = "ALIGN_LEFT", wrapText = FALSE)

cs_left <- CellStyle(wb) +
  Font(wb, heightInPoints = 11, isBold = TRUE, isItalic = FALSE, name="Calibri") +   Alignment(horizontal = "ALIGN_LEFT", vertical = "VERTICAL_TOP", wrapText = TRUE) +
  Border(color = "black", position = c("TOP", "BOTTOM"), pen = c("BORDER_THIN", "BORDER_THIN")) 

cs_right <- CellStyle(wb) +
  Font(wb, heightInPoints = 11, isBold = TRUE, isItalic = FALSE, name="Calibri") +   Alignment(horizontal = "ALIGN_RIGHT", vertical = "VERTICAL_TOP", wrapText = TRUE) +
  Border(color = "black", position = c("TOP", "BOTTOM"), pen = c("BORDER_THIN", "BORDER_THIN")) 

cs_thousand_sep <- CellStyle(wb) +
  DataFormat("#,###")

cs_perc <- CellStyle(wb) +
  DataFormat("0.0%")

cs_top_border <- CellStyle(wb) +
  Border(color = "black", position = "TOP", pen = "BORDER_THIN")

# Sheet one ####
sheet <- createSheet(wb, sheetName = "Introduction")
rows  <- createRow(sheet, rowIndex=1:25)
cells <- createCell(rows, colIndex=1:5) 

setCellValue(cells[[2,2]], "Bed days lost due to delayed transfers of care during each reporting period, Acute and Non Acute; by responsible organisation;")
setCellStyle(cells[[2,2]], cs_wb_title)

setCellValue(cells[[3,2]], paste(ch_area, " Local Authority; Monthly reporting (", month_order[1]," to ", month_order[length(month_order)],")", sep = ""))
setCellStyle(cells[[3,2]], cs_wb_title)

setCellValue(cells[[5,2]], "Author:")
setCellValue(cells[[5,3]], "Rich Tyler")

setCellValue(cells[[6,2]], "Email:")
setCellValue(cells[[6,3]], "richard.tyler@westsussex.gov.uk")
addHyperlink(cells[[6,3]], "mailto:richard.tyler@westsussex.gov.uk", linkType = "EMAIL")

setCellValue(cells[[7,2]], "Date produced:")
setCellValue(cells[[7,3]], format(Sys.Date(), "%d-%B-%Y"))

setCellValue(cells[[9,2]], "Sheets in this workbook:")
setCellValue(cells[[10,2]], paste("Table 1.1 Number and percentage of bed days lost due to delayed transfers of care during each reporting period; ", month_order[1]," to ", month_order[length(month_order)], sep = ""))

setCellValue(cells[[11,2]], paste("Figure 1.1 Number of bed days lost due to delayed transfers of care during each reporting period; ", month_order[1]," to ", month_order[length(month_order)], sep = ""))

#setCellValue(cells[[12,2]], paste("Figure 1.2 Total number of bed days lost due to delayed transfers of care during each reporting period; ", month_order[1]," to ", month_order[length(month_order)], sep = ""))

setColumnWidth(sheet, colIndex = 1, colWidth = 5)
setColumnWidth(sheet, colIndex = 2, colWidth = 25)

setCellValue(cells[[14,2]], "The following information is taken from the NHS England website for Delayed Transfers of Care:")
setCellValue(cells[[15,2]], "https://www.england.nhs.uk/statistics/statistical-work-areas/delayed-transfers-of-care/delayed-transfers-of-care-data-2017-18/")
addHyperlink(cells[[15,2]], "https://www.england.nhs.uk/statistics/statistical-work-areas/delayed-transfers-of-care/delayed-transfers-of-care-data-2017-18/", linkType = "URL")

setCellValue(cells[[17,2]], "The Monthly Situation Report collects data on the total delayed days during the month for all patients delayed throughout the month.")

setCellValue(cells[[18,2]], "Data are shown at provider organisation level, from NHS Trusts, NHS Foundation Trusts and Primary Care Trusts.")

setCellValue(cells[[19,2]], "Data are also shown by Local Authority that is responsible for each patient delayed.")

setCellValue(cells[[20,2]], "Data is split by the agency responsible for delay (NHS, Social Services or both), type of Care that the patient receives (acute or non-acute) and reason for delay.")

setCellValue(cells[[21,2]], "Data for this collection is available back to August 2010.")

# Data table ####
sheet <- createSheet(wb, sheetName = "Table 1.1")
rows  <- createRow(sheet, rowIndex=1:150)
cells <- createCell(rows, colIndex=1:20) 

setCellValue(cells[[2,2]], paste("Table 1.1 Number and percentage of bed days lost due to delayed transfers of care during each reporting period; ", month_order[1]," to ", month_order[length(month_order)], sep = ""))

addMergedRegion(sheet, 2, 2, 2, 10)
setCellStyle(cells[[2,2]], cs_title)

addDataFrame(Chosen_DToC_days_tb, sheet, startRow = 4, startColumn = 2, col.names = FALSE, row.names = FALSE)

setColumnWidth(sheet, colIndex = 1, colWidth = 5)
setColumnWidth(sheet, colIndex = 2, colWidth = round_any(nchar(unique(Chosen_DToC_days_tb$Name)), 5, ceiling))
setColumnWidth(sheet, colIndex = 3, colWidth = 20)
setColumnWidth(sheet, colIndex = 4, colWidth = 10)
setColumnWidth(sheet, colIndex = 5, colWidth = 12)
setColumnWidth(sheet, colIndex = 6, colWidth = 10)
setColumnWidth(sheet, colIndex = 7, colWidth = 8)
setColumnWidth(sheet, colIndex = c(8:10), colWidth = 11)

setCellValue(cells[[3,2]], "Name")
setCellStyle(cells[[3,2]], cs_left)
setCellValue(cells[[3,3]], "Period")
setCellStyle(cells[[3,3]], cs_left)

setCellValue(cells[[3,4]], "No. due to NHS")
setCellStyle(cells[[3,4]], cs_right)
setCellValue(cells[[3,5]], "No. due to Social Care")
setCellStyle(cells[[3,5]], cs_right)
setCellValue(cells[[3,6]], "No. due to Both")
setCellStyle(cells[[3,6]], cs_right)
setCellValue(cells[[3,7]], "Total days")
setCellStyle(cells[[3,7]], cs_right)
setCellValue(cells[[3,8]], "Percentage due to NHS")
setCellStyle(cells[[3,8]], cs_right)
setCellValue(cells[[3,9]], "Percentage due to Social Care")
setCellStyle(cells[[3,9]], cs_right)
setCellValue(cells[[3,10]], "Percentage due to Both")
setCellStyle(cells[[3,10]], cs_right)

for(i in 4:(nrow(Chosen_DToC_days_tb)+4)){
  setCellStyle(cells[[i,4]], cs_thousand_sep)}
for(i in 4:(nrow(Chosen_DToC_days_tb)+4)){
  setCellStyle(cells[[i,5]], cs_thousand_sep)}
for(i in 4:(nrow(Chosen_DToC_days_tb)+4)){
  setCellStyle(cells[[i,6]], cs_thousand_sep)}
for(i in 4:(nrow(Chosen_DToC_days_tb)+4)){
  setCellStyle(cells[[i,7]], cs_thousand_sep)}

for(i in 4:(nrow(Chosen_DToC_days_tb)+4)){
  setCellStyle(cells[[i,8]], cs_perc)}
for(i in 4:(nrow(Chosen_DToC_days_tb)+4)){
  setCellStyle(cells[[i,9]], cs_perc)}
for(i in 4:(nrow(Chosen_DToC_days_tb)+4)){
  setCellStyle(cells[[i,10]], cs_perc)}

for(i in 2:10){
  setCellStyle(cells[[nrow(Chosen_DToC_days_tb)+4,i]], cs_top_border)}

# Figure ####
sheet <- createSheet(wb, sheetName = "Figure 1.1")
rows  <- createRow(sheet, rowIndex=1:150)
cells <- createCell(rows, colIndex=1:20) 

setCellValue(cells[[2,2]], paste("Figure 1.1 Number of bed days lost due to delayed transfers of care during each reporting period; ", month_order[1]," to ", month_order[length(month_order)],")", sep = ""))

setCellStyle(cells[[2,2]], cs_title)

# Add the plot created previously
addPicture(paste0("./Delayed Transfers of Care/",ch_area, "_DToC_Chart_", month_order[1], " - ",month_order[length(month_order)] ,".png"), sheet, scale = 1, startRow = 4, startColumn = 1)

# Figure 1.2 ####

# sheet <- createSheet(wb, sheetName = "Figure 1.2")
# rows  <- createRow(sheet, rowIndex=1:150)
# cells <- createCell(rows, colIndex=1:20) 
# 
# 
# setCellValue(cells[[2,2]], paste("Figure 1.2 Total number of bed days lost due to delayed transfers of care during each reporting period; ", month_order[1]," to ", month_order[length(month_order)],")", sep = ""))
# 
# setCellStyle(cells[[2,2]], cs_title)
# 
# # Add the plot created previously
# addPicture("./Delayed Transfers of Care/Chosen_area_DToC_Control_Chart.png", sheet, scale = 1, startRow = 4, startColumn = 1)

saveWorkbook(wb, file = paste("./Delayed Transfers of Care/Delayed Transfers of Care Days ", ch_area, " to ",month_order[length(month_order)],".xlsx", sep = ""))

# WHAT ABOUT CALENDAR ADJUSTMENT ####
# Average daily days rather than totals per month as months do not have equal lengths #



