library("tidyverse")

day1 <- read_csv(
  "orientation_online/frinex/results_discat_test_day1_200707/tagpairdata.csv"
  ) %>%
  mutate(rowID = 1:nrow(day1))
head(day1)

day1 <- day1 %>%
  mutate(
    date = lubridate::date(TagDate)
  )

head(day1)

day1 %>% select(UserId, date) %>% unique()

day1 %>% filter(date > "2020-07-05")

lapply(day1[, c(1:3)], unique)

unique(day1$EventTag)
unique(day1$EventTag)


get_staircase <- function(df, date_min = NULL) {
  if (!is.null(date_min)) {
    df <- df %>% filter(date >= date_min)
  }
  df <- df %>%
    filter(EventTag == "CurrentDifficultyAngle") %>%
    rename(angle = TagValue2) %>%
    mutate(angle = as.numeric(angle))
  df <- df %>%
    mutate(trial = 1:nrow(df))
  df
}

stairc <- get_staircase(day1, "2020-07-05")
head(stairc)
tail(stairc)

stairc %>%
  ggplot(aes(x = trial, y = angle)) +
  geom_point() +
  geom_line() +
  facet_wrap(~UserId)
