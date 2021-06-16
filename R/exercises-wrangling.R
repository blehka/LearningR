# Load the packages
source(here::here("R/package-loading.R"))


# Check column names
colnames(NHANES)

# Look at contents
str(NHANES)
glimpse(NHANES)

# See summary
summary(NHANES)

# Look over the dataset documentation
?
    #Excercise 9.9
nhanes_small %>%
    select(tot_chol, bp_sys_ave, poverty)
#rename
nhanes_small %>%
    rename(diabetes_diagnosis_age = diabetes_age)

# using pipe operatior %>%
nhanes_small %>%
    select(bmi, contains("age"))

# using %>%  again to separate functions

#instread of: physical_activity <- select(nhanes_small, phys_active_days, phys_active)
rename(physical_activity, days_phys_active = phys_active_days)
nhanes_small %>%
    select(phys_active_days, phys_active) %>%
    rename(days_phys_active = phys_active_days)

## Filtering
#Filtering for all females

nhanes_small %>%
    filter(sex=="female")
# select all tha is not != female
nhanes_small %>%
    filter(sex!= "female")

# Participants with BMI of ==25
nhanes_small %>%
    filter(bmi==25)

# Participants who have BMI equal to or more than >= 25
nhanes_small %>%
    filter(bmi >= 25)

# BMI is greater than 25 and- & the sex is female
nhanes_small %>%
    filter(bmi >= 25 & sex=="female")

#BMI is greater than 25 or| the sex is female
nhanes_small %>%
filter(bmi >= 25 | sex=="female")

##Arrange data set differently - as you want
#Arranging by age
nhanes_small %>%
    arrange(age)

#Arrange by sex in ascending order
nhanes_small %>%
    arrange(sex)

#Aranging by age in descending order- oldest first
nhanes_small %>%
    arrange(desc(age))

#Arrange by 2 variables -sex and age in ascending order
nhanes_small %>%
    arrange(sex, age)

#Arrange by 2 variables -sex and age but sex in descending odder- male first

nhanes_small %>%
    arrange(desc(sex), age)

##Transform or add columns

#change 165cm to 1.65meters
nhanes_small %>%
    mutate(height = height / 100)

#Add a new column with logged height values
nhanes_small %>%
    mutate(logged_height = log(height))

#convert from cm to meters and add  log column at the same time ...of the converted values
nhanes_small %>%
    mutate(height = height / 100, logged_height = log(height))

#Select or add highly active column- Yes if active more or 5 days
nhanes_small %>%
    mutate(highly_active = if_else(phys_active_days >= 5, "Yes", "No"))

#SAFE and SEE IT in Environment
nhanes_update <- nhanes_small %>%
   mutate(height = height/ 100,
     logged_height = log(height),
     highly_active = if_else(phys_active_days >= 5, "Yes", "No"))

# to see the structure
str(nhanes_update)

## SUMMARY STAT- exclude not existing data-NA - ---na.rm = TRUE
# 1.
nhanes_small %>%
    summarise(mean_weight = mean(weight, na.rm = TRUE),
              mean_age = mean(age, na.rm = TRUE))

# 2.
nhanes_small %>%
    summarise(max_height = max(height, na.rm = TRUE),
              min_height = min(height, na.rm = TRUE))

# 3.
nhanes_small %>%
    summarise(median_age = median(age, na.rm = TRUE),
              median_phys_active_days = median(phys_active_days, na.rm = TRUE))


## Calculating summary statistic by group
nhanes_small %>%
    group_by(diabetes) %>%
    summarise(mean_age = mean(age, na.rm = TRUE),
              mean_bmi = mean(bmi, na.rm = TRUE))
# to remove NA from statistic as there is NA in result ---filter(!is.na(diabets))
nhanes_small %>%
    filter(!is.na(diabetes)) %>%
    group_by(diabetes) %>%
    summarise(mean_age = mean(age, na.rm = TRUE),
              mean_bmi = mean(bmi, na.rm = TRUE))
#ungroup
nhanes_small %>%
    filter(!is.na(diabetes)) %>%
    group_by(diabetes) %>%
    summarise(mean_age = mean(age, na.rm = TRUE),
              mean_bmi = mean(bmi, na.rm = TRUE)) %>%
    ungroup()
## SAVING dataset as files
#Saving data as an.rda file in the data folder- safe data from r- like excell exe
usethis::use_data(nhanes_small, overwrite = TRUE)

## How to open it 9.20

