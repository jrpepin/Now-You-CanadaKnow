#-------------------------------------------------------------------------------
# NOW YOU CANADAKNOW PROJECT
# transgender.R
# Joanna R. Pepin
#-------------------------------------------------------------------------------

# Setup & Packages: ------------------------------------------------------------
# The packages & color palette are available in a separate script that should be
# run first: https://github.com/jrpepin/Now-You-CanadaKnow/blob/main/R/00_runfirst.R


# Data: ------------------------------------------------------------------------
# https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=9810003601

data <- cansim::get_cansim("98-10-0036") %>%
  dplyr::rename(
  year   = "REF_DATE",
  geo    = "GEO",
  agecat = "Broad age groups (3)",
  group  = "Gender (8)",
  prop   = "VALUE")

# Variable Processing ----------------------------------------------------------

data <- data %>%
  filter(
    geo == "Canada" & 
    agecat != "Total - Age" &
    (group == "Transgender men" | 
      group ==  "Transgender women" |
      group ==  "Non-binary persons")) %>%
  ## Make short age labels
  mutate(
    agecat = case_when(
      agecat == "15 to 34 years"    ~ "15-34",
      agecat == "35 years and over" ~ "35+"))

data$group <- factor(data$group, 
                     levels = c("Non-binary persons","Transgender women", 
                                "Transgender men"), ordered = FALSE)

data$agecat <- factor(data$agecat, 
                      levels = c("15-34", "35+"), ordered = FALSE)

# Custom function to format numbers
format_label <- function(x) {
  if (x >= 1e6) {
    return(paste0(round(x / 1e6, 1), "M"))
  } else if (x >= 1e3) {
    return(paste0(round(x / 1e3, 1), "K"))
  } else {
    return(as.character(x))
  }
}

# Apply the custom function to format labels
data$label <- sapply(data$prop, format_label)

# Figure -----------------------------------------------------------------------
p <- data %>%
  filter(
    group == "Non-binary persons" | 
    group == "Transgender women"  | 
    group == "Transgender men") %>%
  ggplot(aes(x = factor(group), y = prop, fill = agecat)) +
  geom_col(width = 0.5, position = position_dodge(0.7)) +
  geom_text(aes(label = label),
            position = position_dodge(0.7), size = 6, vjust=-.5) +
  facet_wrap(~group, scales = "free_x") +
  theme_minimal(base_size = 22) +
  theme(legend.position    = "bottom",
        panel.grid.minor   = element_blank(),
        panel.grid.major.x = element_blank(),
        axis.text          = element_blank(),
        plot.subtitle      = element_text(face = "italic"),
        plot.caption       = element_text(hjust=1, colour = "grey", size = 12)) +
  scale_fill_manual(values = c("#20c997", "#F39C12")) +
  ylim(0, 35000) +
  labs(x        = NULL, 
       y        = NULL,
       fill     = "Age group",
       title    = "Canada’s Transgender and Non-Binary Population",
       caption  = "Joanna R. Pepin chart using Canada's 2021 Census of Population \n https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=9810003601")

p

ggsave("transgender.png", path = figDir, p, width = 9, height = 6, dpi = 300, bg = 'white')