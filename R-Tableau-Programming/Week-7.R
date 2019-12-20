library(ggplot2)
library(dplyr)

df.car_torque = read.csv('car_torque.csv')
df.car_top_speed = read.csv('car_top_speed.csv')
df.car_power_to_weight = read.csv('car_power_to_weight.csv')
df.car_horsepower = read.csv('car_horsepower.csv')
df.car_engine_size = read.csv('car_engine_size.csv')
df.car_0_60_time = read.csv('car_0_60_time.csv')

df.car_torque %>% group_by(car_full_nm) %>% summarise(count=n()) %>% filter(count!=1)
df.car_top_speed %>% group_by(car_full_nm) %>% summarise(count=n()) %>% filter(count!=1)
df.car_power_to_weight %>% group_by(car_full_nm) %>% summarise(count=n()) %>% filter(count!=1)
df.car_horsepower %>% group_by(car_full_nm) %>% summarise(count=n()) %>% filter(count!=1)
df.car_engine_size %>% group_by(car_full_nm) %>% summarise(count=n()) %>% filter(count!=1)
df.car_0_60_time %>% group_by(car_full_nm) %>% summarise(count=n()) %>% filter(count!=1)


df.car_torque = distinct(df.car_torque, car_full_nm, .keep_all = T)
df.car_top_speed = distinct(df.car_top_speed, car_full_nm, .keep_all = T)
df.car_power_to_weight = distinct(df.car_power_to_weight, car_full_nm, .keep_all = T)
df.car_horsepower = distinct(df.car_horsepower, car_full_nm, .keep_all = T)
df.car_engine_size = distinct(df.car_engine_size, car_full_nm, .keep_all = T)
df.car_0_60_time = distinct(df.car_0_60_time, car_full_nm, .keep_all = T)

df.car_spec_data = left_join(df.car_horsepower, df.car_torque, by="car_full_nm")
df.car_spec_data = left_join(df.car_spec_data, df.car_top_speed, by="car_full_nm")
df.car_spec_data = left_join(df.car_spec_data, df.car_power_to_weight, by="car_full_nm")
df.car_spec_data = left_join(df.car_spec_data, df.car_engine_size, by="car_full_nm")
df.car_spec_data = left_join(df.car_spec_data, df.car_0_60_time, by="car_full_nm")

df.car_spec_data %>% group_by(car_full_nm) %>% summarise(count=n()) %>% filter(count!=1)
summary(df.car_spec_data)

df.car_spec_data = mutate(df.car_spec_data, year=sub(".*\\[([(0-9)]{4})\\]","\\1", car_full_nm))

df.car_spec_data = mutate(df.car_spec_data,
                          decade = paste(substring(df.car_spec_data$year,1,3),"0s", sep=""))

df.car_spec_data = mutate(df.car_spec_data, make_nm = gsub(" .*$","",df.car_spec_data$car_full_nm))

df.car_spec_data = mutate(df.car_spec_data, car_weight_tons = horsepower_bhp / horsepower_per_ton_bhp)

df.car_spec_data = mutate(df.car_spec_data, torque_per_ton = torque_lb_ft / car_weight_tons)

df.car_spec_data %>% group_by(decade) %>% summarise(count = n())

df.car_spec_data %>%
  group_by(make_nm) %>%
  summarise(make_count = length(make_nm)) %>%
  arrange(desc(make_count))

ggplot(data = df.car_spec_data,
       aes(x=horsepower_bhp, y=top_speed_mph)) +
  geom_point(alpha=.4, size=4, color='blue') +
  ggtitle("Horsepower vs Top Speed") +
  labs(x="Horsepower, bhp", y="Top speed, \n mph")

ggplot(data = df.car_spec_data,
       aes(x=top_speed_mph)) +
  geom_histogram(fill='blue') +
  ggtitle("Histogram of top speed") +
  labs(x="Top Speed, mph", y="Count \n of Records")

df.car_spec_data %>% filter(top_speed_mph > 149 & top_speed_mph<159) %>%
  ggplot(aes(x=as.factor(top_speed_mph))) +
  geom_bar(fill='red')+
  labs(x = "Top Speed mph")

ggplot(data = df.car_spec_data,
       aes(x=top_speed_mph)) +
  geom_histogram(fill='blue') +
  ggtitle("Histogram of top speed") +
  labs(x="Top Speed, mph", y="Count \n of Records") + 
  facet_wrap(~decade)

df.car_spec_data %>% 
  filter(top_speed_mph == 155 & year>=1990) %>%
  group_by(make_nm) %>%
  summarize(count_speed_controlled =n()) %>%
  arrange(desc(count_speed_controlled))

ggplot(data = df.car_spec_data,
       aes(x=horsepower_bhp, y=top_speed_mph)) +
  geom_point(alpha=.4, size=4, color='blue') +
  ggtitle("Horsepower vs Top Speed") +
  labs(x="Horsepower, bhp", y="Top speed, \n mph") +
  facet_wrap(~decade)

df.car_spec_data %>% 
  group_by(year) %>%
  summarise(max_speed = max(top_speed_mph, na.rm=T)) %>%
  ggplot(aes(x=year, y=max_speed, group=1)) + 
  geom_point(size=5, alpha=.8, color='red') +
  stat_smooth(method = "auto", size=1.5) +
  scale_x_discrete(breaks = c("1950","1960","1970","1980","1990","2000","2010")) +
  ggtitle("Speed of year's \n Fastest Car by year") + 
  labs(x="Year",y="Top Speed \n (Fastest Car)")

df.car_spec_data %>%
  select(car_full_nm, top_speed_mph) %>%
  filter(min_rank(desc(top_speed_mph))<=10) %>%
  arrange(desc(top_speed_mph))%>%
  ggplot(aes(x=reorder(car_full_nm, top_speed_mph), y=top_speed_mph)) +
  geom_bar(stat="identity", fill="red")+
  coord_flip()+
  ggtitle("Top 10 Fastest Car (through 2012)") + 
  labs(x="",y="")+
  theme(axis.text.y = element_text(size=rel(1.5)))+
  theme(plot.title = element_text(hjust=1))

ggplot(data=df.car_spec_data, aes(x=horsepower_bhp, y=car_0_60_time_seconds)) +
  geom_point()

ggplot(data=df.car_spec_data, aes(x=horsepower_bhp, y=car_0_60_time_seconds)) +
  geom_point(position = "jitter")

ggplot(data=df.car_spec_data, aes(x=horsepower_bhp, y=car_0_60_time_seconds)) +
  geom_point(position = "jitter", size=4, alpha=.7,color='red')+
  stat_smooth(method="auto", size=1.5)
  ggtitle("0 to 60 times by Horsepower") + 
  labs(x="Horsepower, bhp",y="0-60 time\nseconds")