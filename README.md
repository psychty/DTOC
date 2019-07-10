# Delayed Transfers of Care Time series infographic

A delayed transfer of care is when a patient (aged 18+) is ready to go home following NHS-funded acute or non-acute care but is still occupying a bed. It is important to understand reasons for these delays and how delays change over time.

NHS England publish a monthly ‘situation report’ detailing the delayed transfers of care by local authority.

Each month a new set of data is published as an excel and csv file.

## Output: various infographic reports

This projects shows the workflow of four concepts in R:

* Download and compile each month of data into a single file
* Create figures showing the number of days delayed in total and for each reason
* Use grid package to position each figure on an a4 canvas and export as a pdf
* Use of loops to create infographics for multiple areas

## There are five R scripts in this repository:

Script name | Comment
------------| -------------
Delayed Transfers of Care data collation | Run this script  first to download the data
DToC reason for delay Days | This is this pdf infographic
DToC rate | work in progress
DtoC responsible organisation | work in progress
DToC_excel_output | work in progress
