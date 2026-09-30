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
has_gifski <- requireNamespace("gifski", quietly = TRUE)
knitr::opts_chunk$set(eval = has_gganimate)

library(ggplot2)
library(ggtaichi)
if (has_gganimate) library(gganimate)
set.seed(2026)

# Every animate() call in this vignette is really executed.
#
# Until 0.3.0 they were all commented out (gifski is not installed on every
# check machine), and because building a `gganim` object succeeds whether or
# not the transition works, nothing here ever noticed that the geom was
# collapsing every animation to a single frame.  A demonstration that is never
# run is not a demonstration.
#
# file_renderer() writes PNG frames and needs no gifski, no ffmpeg and no
# system libraries, so the frames are always rendered and counted; a GIF is
# emitted on top of that only where gifski exists.
show_animation <- function(p, nframes = 24, fps = 10,
                           width = 480, height = 360) {
  frames <- gganimate::animate(
    p, nframes = nframes, width = width, height = height,
    units = "px", res = 100,
    renderer = gganimate::file_renderer(tempfile("taichi"), overwrite = TRUE)
  )
  message(length(frames), " frames rendered")
  if (has_gifski) {
    gganimate::animate(p, nframes = nframes, fps = fps,
                       width = width, height = height,
                       units = "px", res = 100,
                       renderer = gganimate::gifski_renderer())
  } else {
    knitr::include_graphics(frames[[ceiling(length(frames) / 2)]])
  }
}

## -----------------------------------------------------------------------------
states_small <- subset(states_tg, week <= 8)

p <- ggplot(states_small, aes(x = category, y = state)) +
  geom_taichi(yin = Twitter, yang = Google) +
  theme_taichi() +
  labs(title = "Week {closest_state}") +
  transition_states(week, transition_length = 1, state_length = 1)

show_animation(p, nframes = 24)
# and to save it:  anim_save("taichi.gif", p)

## -----------------------------------------------------------------------------
p_fixed <- ggplot(states_small, aes(x = category, y = state)) +
  geom_taichi(yin = Twitter, yang = Google) +
  coord_fixed() +
  theme_taichi() +
  transition_states(week, transition_length = 1, state_length = 1)

show_animation(p_fixed, nframes = 24, width = 560, height = 420)

## -----------------------------------------------------------------------------
spin <- data.frame(
  x = 1, y = 1, yin = 5, yang = 5,
  frame = 1:36
)

p_spin <- ggplot(spin, aes(x, y)) +
  geom_taichi(yin = yin, yang = yang, angle = frame * 10,
              eyes = TRUE) +
  coord_fixed() +
  theme_taichi() +
  transition_states(frame, transition_length = 0, state_length = 1)

show_animation(p_spin, nframes = 36, fps = 12, width = 300, height = 300)

