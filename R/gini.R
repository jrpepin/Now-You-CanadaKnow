#-------------------------------------------------------------------------------
# NOW YOU CANADAKNOW PROJECT
# gini.R
# Joanna R. Pepin
#-------------------------------------------------------------------------------

# Setup & Packages: ------------------------------------------------------------
# The packages & color palette are available in a separate script that should be
# run first: https://github.com/jrpepin/Now-You-CanadaKnow/blob/main/R/00_runfirst.R

# Data: ------------------------------------------------------------------------
# Source: The World Bank
# https://data.worldbank.org/indicator/SI.POV.GINI?end=2021&locations=CA-US&start=1963&view=chart
# Canada and the U.S.

data <- read_excel("data/gini.xlsx", sheet = "gini")

# Variable Processing ----------------------------------------------------------

data <- data %>% 
  pivot_longer(
    cols = `Canada`:`United States`, 
    names_to = "country",
    values_to = "gini") %>%
  group_by(country)

data$country <- factor(data$country, 
                     levels = c("Canada", "United States"), ordered = F)


# Figure -----------------------------------------------------------------------

labels <- data %>%
  filter(year == "2011")

p <- ggplot(data, aes(x = year, y = gini, color = country)) +
  geom_point() +
  geom_line(linewidth = 1.5) +
  geom_label(data = labels, aes(x= year, y = gini, label= country), fontface = "bold", nudge_y = -1.5, nudge_x = 4) +
  theme_minimal(base_size = 20) +
  theme(legend.position = "none",
        panel.grid.minor   = element_blank(),
        panel.grid.major.x = element_blank(),
        axis.title.y       = element_text(angle=0, vjust = 1, hjust = .5),
        plot.subtitle      = element_text(face = "italic", colour = "grey", size = 14),
        plot.title.position = "plot",
        plot.caption       = element_text(hjust=0, colour = "grey", size = 12)) +
  scale_y_continuous(label=comma, breaks = seq(from = 30, to = 45, by = 5), limits = c(30,45)) +
  scale_x_continuous(breaks = seq(from = 1965, to = 2020, by = 10), limits = c(1960,2021)) +
  labs(x        = NULL, 
       y        = NULL,
       fill     = NULL,
       legend   = NULL,
       title    = "Gini Index",
       caption  = "Joanna R. Pepin chart using World Bank data, 1963 to 2021") 

p

ggsave("gini.png", path = figDir, p, width = 9, height = 6, dpi = 300, bg = 'white')