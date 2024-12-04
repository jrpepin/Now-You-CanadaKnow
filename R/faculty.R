#-------------------------------------------------------------------------------
# NOW YOU CANADAKNOW PROJECT
# Faculty.R
# Joanna R. Pepin
#-------------------------------------------------------------------------------

# Setup & Packages: ------------------------------------------------------------
# The packages & color palette are available in a separate script that should be
# run first: https://github.com/jrpepin/Now-You-CanadaKnow/blob/main/R/00_runfirst.R


# Data: ------------------------------------------------------------------------
# https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=3710014403
## download options --> CSV download selected data (for database loading)

data <- read.csv("data/3710014403_databaseLoadingData.csv")


# Variable Processing ----------------------------------------------------------

## Create a new df containing only the variables of interest.  
df <- data %>%
  # Create an ID variable
  dplyr::rename(
    year   = REF_DATE,
    geo    = GEO,
    rank   =  Rank,
    gender =  Gender,
    value  =  VALUE) %>%
  select(year, geo, rank, gender, value) %>%
## Make year continuous
  mutate(year = case_when(
    year == "2019/2020" ~ 2020,
    year == "2020/2021" ~ 2021,
    year == "2021/2022" ~ 2022,
    year == "2022/2023" ~ 2023,
    year == "2023/2024" ~ 2024))

# Rank order
df$rank <- factor(df$rank, 
                       levels = c("Total rank", 
                                  "Full professor",
                                  "Associate professor",
                                  "Assistant professor", 
                                  "Other ranks"), ordered = F)

# Figure -----------------------------------------------------------------------
p <- df %>%
  filter(geo == "Canada" & gender != "Total gender" & rank != "Total rank") %>%
ggplot(aes(x = year, y = value, fill = gender)) +
  geom_col(position = position_stack(),
           width = .5) +
  facet_grid(cols = vars(rank)) +
  geom_hline(yintercept=50, linetype="dashed", color = "#e74c3c") +
  theme_minimal(base_size = 20) +  
  scale_fill_manual(values = c("grey95", "#20c997")) +
  scale_y_continuous(breaks = c(50), limits = c(0,100), label = c("50%")) +
  theme(legend.position     = "none",
        panel.grid.minor    = element_blank(),
        panel.grid.major.x  = element_blank(),
        axis.text.x         = element_text(angle = 90, vjust = 0.5, hjust=1),
        plot.subtitle       = element_text(face = "italic", colour = "grey", size = 14),
        plot.title.position = "plot",
        plot.caption        = element_text(hjust=1, colour = "grey", size = 12)) +
  labs(x        = NULL, 
       y        = NULL,
       fill     = NULL,
       legend   = NULL,
       title    = "Proportion of women faculty at Canadian universities",
       subtitle = "by academic rank",
       caption  = "Joanna R. Pepin chart using Statistics Canada data \n https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=3710014403") 

p

ggsave("faculty.png", path = figDir, p, width = 9, height = 6, dpi = 300, bg = 'white')