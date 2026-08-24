## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  warning = FALSE,
  message = FALSE,
  fig.width = 7,
  fig.height = 5,
  fig.align = "center",
  dpi = 120
)

# The gganimate package is in Suggests.  When it is not available the code
# chunks below are still displayed (so the recipe is readable) but not
# evaluated, so this vignette builds on systems without gganimate.
has_gganimate <- requireNamespace("gganimate", quietly = TRUE)
knitr::opts_chunk$set(eval = has_gganimate)

library(ggplot2)
library(ggtaichi)
if (has_gganimate) library(gganimate)
set.seed(2026)

## -----------------------------------------------------------------------------
# p <- ggplot(states_tg, aes(x = category, y = state)) +
#   geom_taichi(yin = Twitter, yang = Google) +
#   theme_taichi() +
#   labs(title = "Week {closest_state}") +
#   transition_states(week, transition_length = 1, state_length = 1)
# 
# # Render to a GIF (requires the gifski package)
# # animate(p, renderer = gifski_renderer())
# # anim_save("taichi.gif", p)

## -----------------------------------------------------------------------------
# p_fixed <- ggplot(states_tg, aes(x = category, y = state)) +
#   geom_taichi(yin = Twitter, yang = Google) +
#   coord_fixed() +
#   theme_taichi() +
#   transition_states(week, transition_length = 1, state_length = 1)
# 
# # animate(p_fixed, width = 800, height = 600, fps = 10)

## -----------------------------------------------------------------------------
# spin <- data.frame(
#   x = 1, y = 1, yin = 5, yang = 5,
#   frame = 1:36
# )
# 
# p_spin <- ggplot(spin, aes(x, y)) +
#   geom_taichi(yin = yin, yang = yang, angle = frame * 10,
#               eyes = TRUE) +
#   coord_fixed() +
#   theme_taichi() +
#   transition_states(frame, transition_length = 0, state_length = 1)
# 
# # animate(p_spin, width = 300, height = 300, fps = 12)

