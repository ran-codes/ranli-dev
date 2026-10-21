library(tidyverse)

mtcars |>
  count(cyl) |>
  print()
