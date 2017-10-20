# Exploratory Data Analysis of the American Time Use Survey

# Load packages and source files
library(tidyverse)
source('https://raw.githubusercontent.com/UrbanInstitute/urban_R_theme/master/urban_theme_mac.R')

# Load Data (source: https://www.bls.gov/tus/datafiles_2016.htm)
respondent <- read_csv("data/atusresp_2016.dat", na = "-1")
activity <- read_csv("data/atussum_2016.dat", na = "-1")
wgts <- read_csv("data/atuswgts_2016.dat", na = "-1")

# Convert variable names to lower case
names(respondent) <- tolower(names(respondent))
names(activity) <- tolower(names(activity))
names(wgts) <- tolower(names(wgts))

# Merge activity to respondent by tucaseid
atus <- left_join(respondent, activity, by = "tucaseid")

atus_mismatches <- anti_join(respondent, activity, by = "tucaseid")

# Merge weights to atus by tucaseid
atus <- left_join(atus, wgts, by = "tucaseid")

wgts_mismatches  <- anti_join(atus, wgts, by = "tucaseid")

# clean up our global envinroment
rm(respondent, activity, wgts, atus_mismatches, wgts_mismatches)

# select interesting variables
atus <- atus %>%
	select(tucaseid, 
				 age = teage,
				 sex = tesex,
				 race = ptdtrace,
				 nonreligious_tv = t120303, 
				 religious_tv = t120304,
				 weight = tufinlwgt.x,
				 month = tumonth)
			
summary(atus)

sapply(atus, function(x) sum(is.na(x)))
# summarize method of seeing if there are missing values


