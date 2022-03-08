# load libraries
library(dplyr)
library(ggplot2)
library(ggpubr)

# load data
dat <- read.csv("1310071001-eng.csv", skip = 12)

# process data
dat <- dat[2:21, c(1, 6)]
dat <- dat %>%
  mutate(X = sub("Age at time of death, ", "", X)) %>%
  transmute(
    age_group = factor(X, levels = X),
    death_rate_per_100k = as.numeric(X.4) * 100
  )

# plot data
p <- ggplot(data = dat, aes(x = age_group, y = death_rate_per_100k)) +
  geom_bar(stat = "identity") +
  geom_point() +
  geom_line(group = 1) +
  theme_pubclean() +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1)) +
  labs(
    x = "Age group",
    y = "Death rate 100,000 population",
    title = "Mortality rates in Canada by age group (2019)",
    caption = "Source: Statistics Canada (Table 13-10-0710-01: Mortality rates, by age group)")
p # show plot

# export data
ggsave("canada-mortality-rates-by-age.png", p)
