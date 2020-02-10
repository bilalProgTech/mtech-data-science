install.packages("readxl")
install.packages('tidyverse')
install.packages('plotly')

library(dplyr)
library(tidyverse)
library(readxl)
library(plotly)

data = read_excel("C:/Users/hungu/Documents/MTech DS Docs/PS/Assignment_on_visualisation_9Qjhct9NlE.xls", sheet=1)
sum(is.na.data.frame(data))

data$gender[data$gender %in% "f"] = "Female"
data$gender[data$gender %in% "m"] = "Male"

data$jobcat[data$jobcat %in% 1] = "Clerical"
data$jobcat[data$jobcat %in% 2] = "Custodial"
data$jobcat[data$jobcat %in% 3] = "Manager"

data$minority[data$minority %in% 0] = "No"
data$minority[data$minority %in% 1] = "Yes"

pipeline_data = data.frame(data %>% group_by(gender, jobcat) %>% summarise_at(vars(salary), funs(mean)))

job_cat = levels(factor(pipeline_data$jobcat))
female_salary = pipeline_data[pipeline_data$gender=='Female',3]
female_salary[3] = female_salary[2]
female_salary[2] = 0
male_salary = pipeline_data[pipeline_data$gender=='Male',3]

data_for_analysis = data.frame(job_cat, female_salary, male_salary)

plot_ly(data_for_analysis, 
        x = ~job_cat, 
        y = ~female_salary, 
        type = 'bar', 
        name = 'Female Salary Mean') %>%
  add_trace(y = ~male_salary, 
            name = 'Male Salary Mean') %>%
  layout(yaxis = list(title = 'Salary'), 
         barmode = 'group')