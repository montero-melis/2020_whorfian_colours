## Script to think about experimental stimuli for orientation discrimination

library("tidyverse")

theme_set(theme_bw())
plot_wi <- 9
plot_he <- 3

# functions
generate_stimuli <- function (ref_angle, stepsize) {
  unique_stim <- tibble(
    stim = paste0("S", 1:5),
    angle_rad = map_dbl(-2:2, function(steps) ref_angle + steps * stepsize)
  )
  stim <- bind_rows(unique_stim[1:4, ], unique_stim[2:5, ]) %>%
    mutate(
      angle_deg = angle_rad * 360 / (2 * pi),
      group = rep(c(1, 2), each = 4),
      stepsize = stepsize
      )
  stim
}
# plot stimuli
plot_stimuli <- function (stimuli) {
  p <- ggplot(stimuli, aes(x = angle_deg, y = factor(group))) +
    geom_tile(aes(fill = factor(round(angle_deg, 1))), colour = "black") +
    geom_spoke(
      aes(angle = angle_rad),
      radius = unique(mystim$stepsize * 360 / (3 * 2 * pi))
      ) +
    xlab("angle in degrees") +
    ylab("group") +
    labs(fill = "angle")
  p
}

# parameters
my_stepsize <- 2 * pi / 360
my_ref_angle1 <- pi / 8
my_ref_angle2 <- pi / 2 + pi / 8

(mystim1 <- generate_stimuli(my_ref_angle1, my_stepsize))
plot_stimuli(mystim1)
ggsave("exp_design/orientation_stim1.pdf", width = plot_wi, height = plot_he)

(mystim2 <- generate_stimuli(my_ref_angle2, my_stepsize))
plot_stimuli(mystim2)
ggsave("exp_design/orientation_stim2.pdf", width = plot_wi, height = plot_he)
