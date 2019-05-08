# DToC Reasons (Days) at a glance 
library(gridExtra)
library(XLConnectJars); library(XLConnect); library(plyr); library(dplyr); library(tidyr); library(reshape2); library(scales); library(ggplot2); library(xts); library(dygraphs); library(grid); library(png); library(readr)
# Read in JSNA logo

# Read in JSNA logo (only download it if it is not available in your working directory)
if(!file.exists("./Research Unit.png")){download.file("http://jsna.westsussex.gov.uk/wp-content/uploads/2017/12/Research-Unit.png", "./Research Unit.png", mode = 'wb')} # This downloads a png image from the West Sussex JSNA website and saves it to your working directory. The if(!file.exists()) only runs the command if the file does not exist (because we have included an ! at the beginning)
jsna = readPNG("./Research Unit.png")

Days_reason <- read_csv("./Delayed Transfers of Care/DToC_Days_Reason_for_Delay_created_February_2018.csv")

Days_reason$Month <- paste("01", Days_reason$Period, sep = " ")
Days_reason$Month <- as.Date(Days_reason$Month, format = "%d %b %Y")

Days_reason <- arrange(Days_reason, Month)

month_order <-  as.character(unique(Days_reason$Period))

quarter_months <- c(month_order[length(month_order)-78],month_order[length(month_order)-75],month_order[length(month_order)-72],month_order[length(month_order)-69],month_order[length(month_order)-66],month_order[length(month_order)-63],month_order[length(month_order)-60],month_order[length(month_order)-57],month_order[length(month_order)-54],month_order[length(month_order)-51],month_order[length(month_order)-48],month_order[length(month_order)-45],month_order[length(month_order)-42],month_order[length(month_order)-39],month_order[length(month_order)-36],month_order[length(month_order)-33],month_order[length(month_order)-30],month_order[length(month_order)-27],month_order[length(month_order)-24],month_order[length(month_order)-21],month_order[length(month_order)-18],month_order[length(month_order)-15],month_order[length(month_order)-12],month_order[length(month_order)-9],month_order[length(month_order)-6],month_order[length(month_order)-3], month_order[length(month_order)])

Days_reason <- subset(Days_reason, Period %in% month_order)

# Local Authorities ####

# for (i in 1:length(authorities)){
chosen_area = "West Sussex"
# Time series (interactive) ####
DToC_Monthly_LA <- subset(Days_reason, Name == chosen_area)

# We need to convert the data to a time series date object 
DToC_Monthly_LA <- xts(DToC_Monthly_LA,  DToC_Monthly_LA$Month)

# dygraph will plot all fields which it thinks are numbers, this includes the 'Code' and Total. We can specify certain fields to be used by adding the [,2:12]. This says i want data for all rows (the bit before the ,) and columns 2 to 12.

DToC_LA_ts <- dygraph(DToC_Monthly_LA[,2:13], main = paste("Delayed Transfers of Care (days) - Reason for delay - ", chosen_area, sep = "" ), ylab = "Number of days delayed", xlab = "Month") %>%
  dyHighlight(highlightSeriesOpts = list(strokeWidth = 2)) %>%
  dyLegend(show = "always", width = 500) %>%
  dyRangeSelector(dateWindow = c("2016-01-01", "2017-09-01"), height = 20, strokeColor = "") %>%
  dyAxis("x", drawGrid = FALSE) %>%
  dyOptions(includeZero = TRUE) %>%
  dyCSS("./Delayed Transfers of Care/dyg.css")

DToC_LA_ts

# htmlwidgets::saveWidget(DToC_LA_ts, file=paste("Delayed_Transfers_of_Care_Days_", chosen_area,"_Reasons.html",sep = ""), selfcontained = TRUE)

# DToC at a glance infographic for LA ####
DToC_LA <- subset(Days_reason, Name == chosen_area)

DToC_LA_long <- gather(data = DToC_LA, key = "Reason", value = "Days", `Awaiting completion of assessment`:`Housing - Patients not covered by NHS and Community Care Act`)

DToC_theme = function(){
  theme( 
    axis.text.y = element_text(colour = "#000000", size = 8), 
    axis.text.x = element_text(colour = "#000000", angle = 90, hjust = 1, vjust = .5, size = 8), 
    plot.title = element_text(colour = "#000000", face = "bold", size = 10, margin = margin(t =10, b = -15)),
    axis.title = element_blank(),     
    axis.line = element_line(colour = "#E7E7E7", size = .3),
    panel.grid.major.x = element_blank(), 
    panel.grid.minor.x = element_blank(), 
  #  plot.background = element_rect(fill = "#ebf5f9", colour = "#E2E2E3"), 
    panel.background = element_rect(fill = "#FFFFFF"), 
    panel.grid.major.y = element_blank(), 
    panel.grid.minor.y = element_blank(), 
    strip.text = element_text(colour = "white"), 
    strip.background = element_blank(), 
    axis.ticks = element_line(colour = "#327d9c") 
  ) 
}

DToC_theme_1 = function(){
  theme( 
    axis.text.y = element_text(colour = "#000000", size = 8), 
    axis.text.x = element_text(colour = "#000000", angle = 90, hjust = 1, vjust = .5, size = 7), 
    plot.title = element_text(colour = "#000000", face = "bold", size = 8, margin = margin(t =10, b = -15)),
    axis.title = element_blank(),     
    axis.line = element_line(colour = "#E7E7E7", size = .3),
    panel.grid.major.x = element_blank(), 
    panel.grid.minor.x = element_blank(), 
    #  plot.background = element_rect(fill = "#ebf5f9", colour = "#E2E2E3"), 
    panel.background = element_rect(fill = "#FFFFFF"), 
    panel.grid.major.y = element_blank(), 
    panel.grid.minor.y = element_blank(), 
    strip.text = element_text(colour = "white"), 
    strip.background = element_blank(), 
    axis.ticks = element_line(colour = "#327d9c") 
  ) 
}

DToC_LA$Period <- factor(DToC_LA$Period, levels = month_order)

DToC_LA <-  arrange(DToC_LA, Period)

DToC_Total_chart <- ggplot(data= DToC_LA, aes(x=Period, y= `Total Delayed Transfers of Care`, group = 1)) +  
  geom_line(size = .7, colour = "#327d9c") + 
  geom_point(size = 1.5, colour = "#327d9c", pch =21, fill = "#ffffff")+
  scale_y_continuous(breaks = seq(0, round_any(max(DToC_LA$`Total Delayed Transfers of Care`),500, f = ceiling), ifelse(round_any(max(DToC_LA$`Total Delayed Transfers of Care`),500, f = ceiling) > 5000, 1000,500)), expand = c(0.01,0), limits = c(0,round_any(max(DToC_LA$`Total Delayed Transfers of Care`),ifelse(round_any(max(DToC_LA$`Total Delayed Transfers of Care`),500, f = ceiling) > 5000, 1000,500), f = ceiling)),labels = comma) + 
  ggtitle("  Total Delayed Transfers of Care (Days)\n") +
  scale_x_discrete(breaks = quarter_months) +
  DToC_theme()

DToC_Total_chart

# Smaller charts #### 

# We need to add a line break for some of the titles as they will be too long. We could ask R to put an new line ('\n') every 30 characters (only between whole words) but this will add a '\n' at the end of the string too.
DToC_LA_long$Reason <- sub('(.{1,30})(\\s|$)', '\\1\n', DToC_LA_long$Reason)

DToC_LA_long$Period <- factor(DToC_LA_long$Period, levels = month_order)

DToC_LA_long <- arrange(DToC_LA_long, Period)

for (i in 1:10){
res <- unique(DToC_LA_long$Reason)[i]
assign(paste("Chart_",res, "_LA", sep = ""),ggplot(data=DToC_LA_long, aes(x=Period, y=Days, group=Reason)) +  
  geom_line(size = .5, colour = "#d9d9da") + 
  geom_line(data = subset(DToC_LA_long, Reason == res), size = 1, colour = "#327d9c") +
  scale_y_continuous(breaks = seq(0, round_any(max(DToC_LA_long$Days),100, f = ceiling), ifelse(round_any(max(DToC_LA_long$Days), 100, f = ceiling) > 1000, 200,100)), expand = c(0.01,0), limits = c(0, round_any(max(DToC_LA_long$Days),ifelse(round_any(max(DToC_LA_long$Days), 100, f = ceiling) > 1000, 200,100), f = ceiling)),labels = comma) + 
  scale_x_discrete(breaks = quarter_months) +
  ggtitle(paste("  ",res, sep = "")) + 
  DToC_theme_1())}

# Create a pdf of the infographic 

# Define the layout with pushViewport with a matrix of windows to hold plots/text # Think of this like an excel worksheet and merging cells to make things look right   on a page.

vplayout <- function(x,y)
  viewport(layout.pos.row = x, layout.pos.col = y)

# Title and logo
pdf(paste("./Delayed Transfers of Care/DToC Days- reasons at a glance to ",month_order[length(month_order)], " ", chosen_area,".pdf" , sep =""), width = 11.7, height = 8.3) # a4 landscape
grid.newpage() 
pushViewport(viewport(layout = grid.layout(24, 37)))
# Define the background colour for each window
grid.rect(gp = gpar(fill = "#ffffff", col = "#000000")) 
grid.text("Delayed Transfers of Care (Days) -", just = "left", y = unit(.96, "npc"), x = unit(0.025, "npc"), gp = gpar(col = "#545454", fontsize = "16"))
grid.text(" Reasons at a glance ", just = "left", y = unit(.96, "npc"), x = unit(0.32, "npc"), gp = gpar(col = "#1c8ccd", fontsize = "16", fontface = "bold"))
grid.text(paste("- ", chosen_area, sep = ""), just = "left", y = unit(.96, "npc"), x = unit(0.52, "npc"), gp = gpar(col = "#545454", fontsize = "16"))
grid.text(paste("A delayed transfer of care from acute or non-acute (including community and mental health) care occurs when a patient is ready to\ndepart from such care and is still occupying a bed. NHS England publishes monthly data showing the responsible organisation and reasons for delay.\nThese graphs relate to total DAYS in each month rather than number of patients. This analysis relates to monthly data between ",month_order[1], " and ", month_order[length(month_order)],".", sep = ""), just = "left", y = unit(.91, "npc"), x = unit(0.025, "npc"), gp = gpar(col = "#000000", fontsize = "9"))
grid.raster(jsna, y = unit(0.98, "npc"), x = unit(0.78, "npc"), vjust = 1, hjust = 0, width = .2)
print(DToC_Total_chart, vp = vplayout(4:10, 2:18))
print(`Chart_Awaiting completion of\nassessment_LA`, vp = vplayout(4:10, 19:27))
print(`Chart_Awaiting public funding\n_LA`, vp = vplayout(4:10, 28:36))
print(`Chart_Awaiting further NHS non-acute\ncare_LA`, vp = vplayout(11:17, 2:9))
print(`Chart_Awaiting residential home\nplacement or availability_LA`, vp = vplayout(11:17, 10:18))
print(`Chart_Awaiting nursing home\nplacement or availability_LA`, vp = vplayout(11:17, 19:27))
print(`Chart_Awaiting care package in own\nhome_LA`, vp = vplayout(11:17, 28:36))
print(`Chart_Awaiting community equipment\nand adaptations_LA`, vp = vplayout(18:23, 2:9))
print(`Chart_Patient or family choice\n_LA`, vp = vplayout(18:23, 10:18))
print(`Chart_Disputes\n_LA`, vp = vplayout(18:23, 19:27))
print(`Chart_Housing - Patients not covered\nby NHS and Community Care Act_LA`, vp = vplayout(18:23, 28:36))
grid.text("Source: NHS England", just = "left", y = unit(.025, "npc"), x = unit(0.87, "npc"), gp = gpar(col = "#545454", fontsize = "8"))
dev.off()


# WHAT ABOUT CALENDAR ADJUSTMENT ####
# Average daily days rather than totals per month as months do not have equal lengths #