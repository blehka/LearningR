#load up the packages
source(here::here("R/package-loading.R"))

#Briefly glimpse content
glimpse(NHANES)
#Seklect one column by the name
select(NHANES, Age)

#Select more columns
select(NHANES, Age, Weight, BMI)

#Exclude the column
select(NHANES, -HeadCirc)

#All columns starting with "BP"
select(NHANES, starts_with("BP"))

#All columns ending with  "Day"
select(NHANES, ends_with("Day"))

#All columns containing "Age"
select(NHANES, contains("Age"))

?select_helpers

#save the selected columns as a new data frame
nhanes_small <- select(NHANES, Age, Gender, Height,
                       Weight, BMI, Diabetes, DiabetesAge,
                       PhysActiveDays, PhysActive, TotChol,
                       BPSysAve, BPDiaAve, SmokeNow, Poverty)
#View the data frame
nhanes_small

##Renaming
# Rebname all columns to snake case- small letters and _spaces
nhanes_small <- rename_with(nhanes_small, snakecase::to_snake_case)

#to view if it worked ..
nhanes_small

#Remaning specyfic columns in console
rename(nhanes_small, sex = gender)

nhanes_small

#rename and safe it
nhanes_small <- rename(nhanes_small, sex = gender)
nhanes_small

##The pipe operator
#without pipe operator
colnames(nhanes_small)

#with the pipe operator--- %>%- Ctrl+shift+M
nhanes_small %>% colnames()

#using the pipe operator with more functions
nhanes_small %>%
    select(phys_active) %>%
    rename(physically_physically = phys_active)
