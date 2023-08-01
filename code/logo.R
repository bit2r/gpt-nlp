################################################################################
##
##                        챗GPT NLP 책 로고
##                      이광춘, 2023-08-01
##
################################################################################

# 1. AI 배경 이미지 ------------------------------------------------------------

library(tidyverse)
library(openai)
library(cropcircles)
library(magick)
library(showtext)
library(ggpath)
library(ggtext)
library(glue)

extrafont::loadfonts()

Sys.setenv(OPENAI_API_KEY = Sys.getenv("OPENAI_API_KEY"))

# x <- create_image("a amazing newspaper as the sun is rising behind many news full of fake and misinformation")
x <- create_image("multicolor sparkly glitter bursting from the tip of a book as it touches the book head band, bright, realism")

## 원본이미지 다운로드
download.file(url = x$data$url, destfile = "code/generative_logo.jpg",
              mode = "wb")


# 2. 뉴스토마토 로고 ------------------------------------------------------------
## 2.1. 소스 이미지
logo_bg <- magick::image_read(glue::glue("{here::here()}/code/generative_logo.jpg"))

# 3. 텍스트 ------------------------------------------------------------

font_add_google('inconsolata', 'Inconsolata')
font_add_google('Dokdo', 'dokdo')
# 글꼴 다운로드 : https://fontawesome.com/download
font_add('fa-brands', 'code/fonts/Font Awesome 6 Brands-Regular-400.otf')
showtext_auto()
ft <- "dokdo"
ft_github <- "inconsolata"
txt <- "black"

pkg_name <- "챗GPT NLP"

img_cropped <- hex_crop(
  images = logo_bg,
  border_colour = "#403b39",
  border_size = 30
)

chatgpt_nlp_gg <- ggplot() +
  geom_from_path(aes(0.5, 0.5, path = img_cropped)) +
  annotate("text", x = 0.40, y = 0.08, label = pkg_name,
           family = ft, size = 35, colour = txt,
           angle = 30, hjust = 0, fontface = "bold") +
  # add github
  annotate("richtext", x=0.55, y = 0.05, family = ft_github,
           size = 12, angle = 30,
           colour = txt, hjust = 0,
           label = glue("<span style='font-family:fa-brands; color:{txt}'>&#xf09b;&nbsp;</span> bit2r/gpt-nlp"),
           label.color = NA, fill = NA)   +
  xlim(0, 1) +
  ylim(0, 1) +
  theme_void() +
  coord_fixed()

chatgpt_nlp_gg

ragg::agg_png("code/logo.png",
              width = 4.39, height = 5.08, units = "cm", res = 600, background = "transparent")
chatgpt_nlp_gg
dev.off()

