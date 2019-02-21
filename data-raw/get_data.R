library(tidyverse)
# first: https://raw.githubusercontent.com/openai/gpt-2/master/gpt-2-samples/conditional-t07.txt
# second: https://raw.githubusercontent.com/openai/gpt-2/master/gpt-2-samples/conditional-topk40.txt
# third: https://raw.githubusercontent.com/openai/gpt-2/master/gpt-2-samples/conditional.txt

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

download.file("https://raw.githubusercontent.com/openai/gpt-2/master/gpt-2-samples/conditional-t07.txt", "./data-raw/conditional-t07.txt")
download.file("https://raw.githubusercontent.com/openai/gpt-2/master/gpt-2-samples/conditional-topk40.txt", "./data-raw/conditional-topk40.txt")
download.file("https://raw.githubusercontent.com/openai/gpt-2/master/gpt-2-samples/conditional.txt", "./data-raw/conditional.txt")

conditional_t07 <- read_openai_conditional("./data-raw/conditional-t07.txt")
conditional_topk40 <- read_openai_conditional("./data-raw/conditional-topk40.txt")
conditional <- read_openai_conditional("./data-raw/conditional.txt")

usethis::use_data(conditional_t07, conditional_topk40, conditional, overwrite = T)
sinew::makeOxygen(conditional_t07, add_fields = "source")
sinew::makeOxygen(conditional_topk40, add_fields = "source")
sinew::makeOxygen(conditional, add_fields = "source")
