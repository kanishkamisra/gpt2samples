library(tidyverse)

read_openai_conditional <- function(path) {
  # name <- str_extract(link, "(?<=samples\\/).*(?=\\.txt)")
  name <- str_extract(path, "(?<=data-raw\\/).*(?=\\.txt)")
  conditional <- read_file(path) %>%
    str_split("\\={40} SAMPLE \\d{1,3} \\={40}") %>%
    flatten_chr() %>%
    str_split("\\={20} COMPLETION \\d{1,3} \\={20}") %>%
    .[-1]

  conditional_tbl <- tibble(
    text = conditional,
    file = name
  ) %>%
    mutate(
      id = row_number(),
      type = list(c("sample", "completion"))
    ) %>%
    unnest()

  return(conditional_tbl)
}

read_openai_unconditional <- function(path) {
  name <- str_extract(path, "(?<=data-raw\\/).*(?=\\.txt)")
  unconditional <- read_file(path) %>%
    str_split("\\={40} SAMPLE \\d{1,3} \\={40}") %>%
    flatten_chr() %>%
    .[-1]

  unconditional_tbl <- tibble(
    text = unconditional,
    file = name
  ) %>%
    mutate(
      id = row_number()
    ) %>%
    select(file, id, text)

  return(unconditional_tbl)
}

download_samples <- function(files, dest) {
  walk(samples, function(x) {
    glue::glue("https://raw.githubusercontent.com/openai/gpt-2/master/gpt-2-samples/{x}.txt") %>%
      download.file(destfile = as.character(glue::glue("{dest}{x}.txt")))
  })
}
samples = c("conditional-t07", "conditional-topk40", "conditional", "unconditional", "unconditional-t07", "unconditional-topk40")

download_samples(samples, "./data-raw/")

conditional_t07 <- read_openai_conditional("./data-raw/conditional-t07.txt")
conditional_topk40 <- read_openai_conditional("./data-raw/conditional-topk40.txt")
conditional <- read_openai_conditional("./data-raw/conditional.txt")
unconditional_t07 <- read_openai_unconditional("./data-raw/unconditional-t07.txt")
unconditional_topk40 <- read_openai_unconditional("./data-raw/unconditional-topk40.txt")
unconditional <- read_openai_unconditional("./data-raw/unconditional.txt")

usethis::use_data(conditional_t07, conditional_topk40, conditional, unconditional, unconditional_topk40, unconditional_t07, overwrite = T)

sinew::makeOxygen(conditional_t07, add_fields = "source")
sinew::makeOxygen(conditional_topk40, add_fields = "source")
sinew::makeOxygen(conditional, add_fields = "source")

sinew::makeOxygen(unconditional_t07, add_fields = "source")
sinew::makeOxygen(unconditional_topk40, add_fields = "source")
sinew::makeOxygen(unconditional, add_fields = "source")
