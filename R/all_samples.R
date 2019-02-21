
#' Tidy data frame of Open AI GPT-2 sample_texts
#'
#' Returns a tidy data frame of all conditional and unconditional generated texts.
#'
#' @name all_samples
#'
#' @examples
#'
#' library(dplyr)
#'
#' all_samples() %>%
#'  group_by(file) %>%
#'  summarise(total_lines = n())
#'
#' @importFrom dplyr bind_rows mutate
#' @importFrom magrittr %>%
#'
#' @export
all_samples <- function(){
  samples <- bind_rows(
    gpt2samples::conditional,
    gpt2samples::conditional_t07,
    gpt2samples::conditional_topk40,
    gpt2samples::unconditional %>% mutate(type = "sample"),
    gpt2samples::unconditional_t07 %>% mutate(type = "sample"),
    gpt2samples::unconditional_topk40 %>% mutate(type = "sample")
  )

  return(samples)
}
