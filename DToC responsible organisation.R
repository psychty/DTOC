# Delayed Transfers of Care - source - NHS Statistics

library(png); library(gridExtra); library(plyr); library(dplyr);library(tidyr); library(reshape2); library(scales); library(ggplot2); library(xts); library(dygraphs); library(grid); library(readr); library(xlsx)

ch_area = "West Sussex"

Days_organisation <- read_csv("./Delayed Transfers of Care/DToC_Days_Responsible_Organisation_created_January_2018.csv")

# This is the template for charts
DToC_theme = function(){
  theme( legend.position = "bottom", 
         axis.text.x = element_text(angle = 90, hjust = 1, vjust = .5, size = 8), 
         plot.background = element_rect(fill = "white", colour = "#E2E2E3"), 
         panel.background = element_rect(fill = NA), 
         axis.line = element_line(colour = "#E7E7E7", size = .3),
         axis.text = element_text(colour = "#000000", size = 10), 
         plot.title = element_text(colour = "#327d9c", face = "bold", size = 12, vjust = -.5), 
         axis.title = element_text(colour = "#327d9c", face = "bold", size = 10),     
         panel.grid.major.x = element_blank(), 
         panel.grid.minor.x = element_blank(), 
         panel.grid.major.y = element_line(colour = "#E2E2E3", linetype = "dashed", size = 0.2), 
         panel.grid.minor.y = element_blank(), 
         strip.text = element_text(colour = "white"), 
         strip.background = element_rect(fill = "#327d9c"),
         axis.ticks = element_line(colour = "#9e9e9e"),
         legend.text = element_text(colour = "#000000", size = 10))
}


Days_organisation$Month <- paste("01", Days_organisation$Period_year, sep = " ")
Days_organisation$Month <- as.Date(Days_organisation$Month, format = "%d %b %Y")

Days_organisation <- arrange(Days_organisation, Month)
month_order <-  as.character(unique(Days_organisation$Period_year))

# Days Delayed ####
Days_organisation$Period_year <- factor(Days_organisation$Period_year, levels = month_order)

# Arrange the data
Days_organisation <- arrange(Days_organisation, Name, Period_year)
Days_organisation$Perc_NHS <- Days_organisation$NHS/Days_organisation$Total
Days_organisation$Perc_Social_care <- Days_organisation$`Social Care`/Days_organisation$Total
Days_organisation$Perc_Both <- Days_organisation$Both/Days_organisation$Total



Chosen_DToC_days <- subset(Days_organisation, Name == ch_area)

# We need to put the data into long format format to plot a stacked bar chart
Chosen_DToC_days_long <- gather(Chosen_DToC_days[c("Name","Period_year","NHS","Social Care","Both")], key = "Organisation", value = "Days", NHS:Both)
Chosen_DToC_days_long$Organisation <- factor(Chosen_DToC_days_long$Organisation, levels = c("Both", "Social Care", "NHS"))
Chosen_DToC_days_long <- arrange(Chosen_DToC_days_long, Organisation)

# total_days <- Chosen_DToC_days_long %>% group_by(Period_year) %>% summarise(sum(Days))

chosen_DToC_chart <- ggplot(data = Chosen_DToC_days_long, aes(x = Period_year, y = Days, fill = Organisation)) + 
  geom_bar(stat = "identity", width = 0.8) +
  scale_y_continuous(breaks = seq(0, round_any(max(Chosen_DToC_days$Total), 500, ceiling), ifelse(round_any(max(Chosen_DToC_days$Total), 500, ceiling) < 5000, 250, 500)), expand = c(0.01,0), limits = c(0, round_any(max(Chosen_DToC_days$Total), 500, ceiling)), labels = comma) +   scale_fill_manual(values = c("#4F81BD","#C0504D", "#000000"), limits = c("NHS","Social Care", "Both"), labels = c("NHS","Social Care", "Both NHS and Social Care"), name = "Delay attributed to") +  
  ylab("Delayed Days") +
  xlab("Month") +
  #ggtitle(paste("Number of bed days lost due to delayed transfers of care during each reporting period, Acute and Non Acute;\nby responsible organisation; ", ch_area, " Local Authority; Monthly reporting (", month_order[1]," to ", month_order[length(month_order)],")", sep = "")) +
  labs(caption = "Source: NHS England") +
  DToC_theme() +
  theme(legend.position = "top", legend.direction = "horizontal", legend.text = element_text(size = 8), legend.title = element_text(size = 8), legend.key.size = unit(.75, "lines"))  

png("./Delayed Transfers of Care/Chosen_area_DToC_Chart.png", height = 1000, width = 2000, res = 200, pointsize = 16)
chosen_DToC_chart
dev.off()

# Output ####

pdf(paste("./Delayed Transfers of Care/West Sussex Delayed Transfers of Care Days to ",month_order[length(month_order)],".pdf", sep = ""), width = 11.7, height = 8.3)
chosen_DToC_chart
dev.off()

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
setCellValue(cells[[10,2]], paste("Table 1.1 Number and percentage of bed days lost due to delayed transfers of care during each reporting period; ", month_order[1]," to ", month_order[length(month_order)],")", sep = ""))

setCellValue(cells[[11,2]], paste("Figure 1.1 Number of bed days lost due to delayed transfers of care during each reporting period; ", month_order[1]," to ", month_order[length(month_order)],")", sep = ""))

setColumnWidth(sheet, colIndex = 1, colWidth = 5)
setColumnWidth(sheet, colIndex = 2, colWidth = 25)

setCellValue(cells[[13,2]], "The following information is taken from the NHS England website for Delayed Transfers of Care:")
setCellValue(cells[[14,2]], "https://www.england.nhs.uk/statistics/statistical-work-areas/delayed-transfers-of-care/delayed-transfers-of-care-data-2017-18/")
addHyperlink(cells[[14,2]], "https://www.england.nhs.uk/statistics/statistical-work-areas/delayed-transfers-of-care/delayed-transfers-of-care-data-2017-18/", linkType = "URL")

setCellValue(cells[[16,2]], "The Monthly Situation Report collects data on the total delayed days during the month for all patients delayed throughout the month.")

setCellValue(cells[[18,2]], "Data are shown at provider organisation level, from NHS Trusts, NHS Foundation Trusts and Primary Care Trusts.")

setCellValue(cells[[19,2]], "Data are also shown by Local Authority that is responsible for each patient delayed.")

setCellValue(cells[[20,2]], "Data is split by the agency responsible for delay (NHS, Social Services or both), type of Care that the patient receives (acute or non-acute) and reason for delay.")

setCellValue(cells[[21,2]], "Data for this collection is available back to August 2010.")

# Data table ####
sheet <- createSheet(wb, sheetName = "Table 1.1")
rows  <- createRow(sheet, rowIndex=1:150)
cells <- createCell(rows, colIndex=1:20) 

setCellValue(cells[[2,2]], paste("Table 1.1 Number and percentage of bed days lost due to delayed transfers of care during each reporting period; ", month_order[1]," to ", month_order[length(month_order)],")", sep = ""))

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
# Add a title to the sheet

xlsx.addTitle(sheet, rowIndex = 1, title = paste("Figure 1.1 Number of bed days lost due to delayed transfers of care during each reporting period; ", month_order[1]," to ", month_order[length(month_order)],")", sep = ""),titleStyle = TITLE_STYLE)

# Add the plot created previously
addPicture("./Delayed Transfers of Care/Chosen_area_DToC_Chart.png", sheet, scale = 1, startRow = 4, startColumn = 1)

saveWorkbook(wb, file = paste("./Delayed Transfers of Care/Delayed Transfers of Care Days ", ch_area, " to ",month_order[length(month_order)],".xlsx", sep = ""))

# WHAT ABOUT CALENDAR ADJUSTMENT ####
# Average daily days rather than totals per month as months do not have equal lengths #
