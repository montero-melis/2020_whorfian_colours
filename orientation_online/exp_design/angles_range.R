# Calculate the range of stimuli (angles) that will be found in the experiment

library("dplyr")
library("readr")

get_stimuli <- function (alpha_range, delta_range, jump = 2) {
  d <- expand.grid(
    alpha = seq(alpha_range[1], alpha_range[2], by = jump),
    delta = seq(delta_range[1], delta_range[2], by = jump)
    ) %>%
    arrange(alpha, delta) %>%
    mutate(
      S1 = alpha - 1.5 * delta,
      S2 = alpha - .5 * delta,
      S3 = alpha + .5 * delta,
      S4 = alpha + 1.5 * delta
    ) %>%
    mutate(
      cross90 = ifelse(S4 >= 88, "Y", "N"),
      categ_bound45 = ifelse(S2 <= 45 & S3 >= 45, "Y", "N")
    )
  d
}

get_stimuli(alpha = c(25, 65), delta = c(2, 12))
get_stimuli(alpha = c(30, 60), delta = c(8, 14))

get_stimuli(alpha = c(62, 73), delta = c(8, 10), jump = 1)
get_stimuli(alpha = c(65, 70), delta = c(8, 10), jump = 1)


for (myalpha in c(34, 56, 124, 146)) {
  get_stimuli(alpha = c(myalpha, myalpha), delta = c(16, 20), jump = 1) %>%
    print()
  }

get_stimuli(alpha = c(56, 56), delta = c(6, 20), jump = 2)


get_stimuli(alpha = c(34, 34), delta = c(16, 20), jump = 1)


get_stimuli(alpha = c(52, 60), delta = c(16, 20), jump = 1)

get_stimuli(alpha = c(52, 60), delta = c(16, 20), jump = 1) %>%
  write_csv("stimuli.csv")


