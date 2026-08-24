## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  warning = FALSE,
  message = FALSE,
  fig.width = 7,
  fig.height = 7,
  fig.align = "center",
  dpi = 120
)

## -----------------------------------------------------------------------------
library(ggtaichi)
library(ggplot2)

## ----fig.width = 4.5, fig.height = 4.5, fig.alt="A single large taichi diagram, its red yang fish reading a high value and its grey yin fish a low value."----
one <- data.frame(x = 1, y = 1, google = 7, twitter = 3)

ggplot(one, aes(x, y)) +
  geom_taichi(yin = twitter, yang = google) +
  coord_fixed() +
  theme_taichi()

## -----------------------------------------------------------------------------
head(pitts_tg)

## ----fig.height = 6, fig.alt="A full 30-week by 9-category grid of taichi diagrams for Pittsburgh, red yang fish for Google and grey yin fish for Twitter."----
ggplot(pitts_tg, aes(x = week, y = category)) +
  geom_taichi(yin = Twitter, yang = Google) +
  theme_taichi() +
  ggtitle("Pittsburgh Google & Twitter Incidence Rate (%)")

## ----fig.height = 8, fig.alt="A six-week Pittsburgh grid of taichi diagrams drawn large enough to read each fish clearly."----
pitts_small <- subset(pitts_tg, week <= 6)

ggplot(pitts_small, aes(x = week, y = category)) +
  geom_taichi(yin = Twitter, yang = Google) +
  theme_taichi() +
  ggtitle("The first six weeks, drawn large")

## ----fig.height = 8, fig.alt="The six-week Pittsburgh grid of taichi diagrams with a blue gradient for Twitter and an orange gradient for Google."----
ggplot(pitts_small, aes(x = week, y = category)) +
  geom_taichi(
    yin = Twitter,  yin_name = "Twitter (%)",
    yin_colors = c("#deebf7", "#3182bd", "#08306b"),
    yang = Google, yang_name = "Google (%)",
    yang_colors = c("#fee6ce", "#e6550d", "#7f2704")
  ) +
  theme_taichi()

## ----fig.height = 8, fig.alt="The six-week Pittsburgh taichi grid with the surrounding panel padding removed so the symbols reach the plot edges."----
ggplot(pitts_small, aes(x = week, y = category)) +
  geom_taichi(yin = Twitter, yang = Google) +
  remove_padding() +
  theme_taichi()

## ----fig.height = 8, fig.alt="Two faceted taichi grids comparing New York and Texas over six weeks, red yang fish for Google and grey yin fish for Twitter."----
two_states <- subset(states_tg, state %in% c("New York", "Texas") & week <= 6)

ggplot(two_states, aes(x = week, y = category)) +
  geom_taichi(yin = Twitter, yang = Google) +
  facet_wrap(~ state, ncol = 1) +
  remove_padding(x = "c", y = "d") +
  theme_taichi() +
  ggtitle("New York vs Texas, weeks 1-6")

## ----fig.height = 6, fig.alt="The six-week Pittsburgh taichi grid using theme_taichi() with its off-white background overridden to plain white."----
ggplot(pitts_small, aes(x = week, y = category)) +
  geom_taichi(yin = Twitter, yang = Google) +
  theme_taichi() +
  theme(plot.background = element_rect(fill = "white")) +
  ggtitle("theme_taichi(), then tweaked")

## ----fig.height = 4, fig.alt="Four taichi diagrams with rotation angles 0, 45, 90, and 180 drawn from a data column."----
one_rot <- data.frame(
  x = c(1, 2, 1, 2),
  y = c(2, 2, 1, 1),
  yin = c(3, 5, 7, 9),
  yang = c(9, 7, 5, 3),
  rot = c(0, 45, 90, 180)
)

ggplot(one_rot, aes(x, y)) +
  geom_taichi(yin = yin, yang = yang, angle = rot,
              limits = c(0, 10)) +
  coord_fixed() +
  theme_taichi()

## ----fig.height = 4, fig.alt="Four taichi diagrams with the classic white and black eyes enabled."----
one_eye <- data.frame(
  x = c(1, 2, 1, 2),
  y = c(2, 2, 1, 1),
  yin = c(3, 5, 7, 9),
  yang = c(9, 7, 5, 3)
)

ggplot(one_eye, aes(x, y)) +
  geom_taichi(yin = yin, yang = yang, eyes = TRUE,
              limits = c(0, 10)) +  # shared limits keep the palest fish visible
  coord_fixed() +
  theme_taichi()

## ----fig.height = 4, fig.alt="Four taichi diagrams whose eye sizes vary from cell to cell, encoding two extra variables."----
one_eye$reach   <- c(10, 40, 25, 5)   # drives the yin eye
one_eye$quality <- c(2, 1, 4, 8)      # drives the yang eye

ggplot(one_eye, aes(x, y)) +
  geom_taichi(yin = yin, yang = yang,
              eyes = TRUE,
              yin_eye_size = reach,
              yang_eye_size = quality,
              limits = c(0, 10)) +
  coord_fixed() +
  theme_taichi()

## ----fig.height = 4, fig.alt="Taichi grid with discrete category fills: methods A to C on the yin fish and win or loss on the yang fish."----
disc <- data.frame(
  x = c(1, 2, 1, 2),
  y = c(2, 2, 1, 1),
  method = factor(c("A", "B", "C", "A")),
  outcome = factor(c("win", "loss", "win", "loss"))
)

ggplot(disc, aes(x, y)) +
  geom_taichi(yin = method, yang = outcome) +
  coord_fixed() +
  theme_taichi()

## ----fig.height = 4, fig.alt="The same discrete taichi grid drawn with viridis palettes supplied through yin_scale and yang_scale."----
ggplot(disc, aes(x, y)) +
  geom_taichi(yin = method, yang = outcome,
              yin_scale = scale_fill_viridis_d,
              yang_scale = scale_fill_viridis_d(name = "outcome", option = "rocket",
                                                begin = 0.4, end = 0.8)) +
  coord_fixed() +
  theme_taichi()

## ----fig.height = 4, fig.alt="Taichi diagrams with custom linewidth, alpha, and colour."----
one_lwd <- data.frame(
  x = c(1, 2, 1, 2),
  y = c(2, 2, 1, 1),
  yin = c(3, 5, 7, 9),
  yang = c(9, 7, 5, 3)
)

ggplot(one_lwd, aes(x, y)) +
  geom_taichi(yin = yin, yang = yang,
              alpha = 0.7, linewidth = 1.5, colour = "#333333") +
  coord_fixed() +
  theme_taichi()

## ----fig.height = 6, fig.alt="A 12-week by 8-neighbourhood taichi grid of espresso versus matcha orders sharing one grey fill scale and a single legend."----
ggplot(cafes_tg, aes(x = week, y = neighbourhood)) +
  geom_taichi(yin = matcha, yang = espresso,
              shared_legend = TRUE,
              yin_name = "orders / 100 customers") +
  remove_padding() +
  theme_taichi() +
  ggtitle("Espresso (yang) vs matcha (yin)")

