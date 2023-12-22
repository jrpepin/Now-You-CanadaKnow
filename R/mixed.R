#-------------------------------------------------------------------------------
# NOW YOU CANADAKNOW PROJECT
# mixed.R
# Joanna R. Pepin
#-------------------------------------------------------------------------------

# Setup & Packages: ------------------------------------------------------------
# The packages & color palette are available in a separate script that should be
# run first: https://github.com/jrpepin/Now-You-CanadaKnow/blob/main/R/00_runfirst.R

# Data: ------------------------------------------------------------------------
# Source: Canadian long-form census (2016)
# https://vanierinstitute.ca/metrics-to-meaning-capturing-the-diversity-of-couples-in-canada/
# Table 1

# Variable Processing ----------------------------------------------------------
group <- c("Visible Minority Group",  "Visible Minority Group",  "Visible Minority Group",  "Visible Minority Group", 
           "Country of Origin", "Country of Origin", "Country of Origin", "Country of Origin")
type <- c("Both white", "Same\nVisible Minority Group", "White &\nVisible Minority Group", "Different\nVisible Minority Groups",
           "Both born in Canada", "Born same country\n(not Canada)", "Canada &\nAnother country", "Both born outside\n of Canada")
prop <- c(75.7,17,6.7,.6,64.4,19.8,11.8,4.1)
data <- data.frame(group, type, prop)

data$type <- factor(data$type,
                     levels = c("Both white", "Same\nVisible Minority Group", "White &\nVisible Minority Group", "Different\nVisible Minority Groups",
                                "Both born in Canada", "Born same country\n(not Canada)", "Canada &\nAnother country", "Both born outside\n of Canada"), ordered = F)

data$group <- factor(data$group, 
                     levels = c("Visible Minority Group", "Country of Origin"), ordered = F)

# Figure -----------------------------------------------------------------------

p <- ggplot(data, aes(x = factor(type), y = prop, fill = group, label = prop)) +
  geom_col(width = .5) +
  # Set the position to its complementary
  geom_text(show.legend = FALSE, color = "#7b8a8b", vjust=-0.25) +
  facet_grid(col = vars(group), scales = "free_x") +
  theme_minimal(base_size = 20) +
  theme(legend.position    = "none",
        panel.grid.minor   = element_blank(),
        panel.grid.major.x = element_blank(),
        axis.text.x        = element_blank(),
        axis.text.y        = element_blank(),
        plot.subtitle      = element_text(face = "italic"),
        plot.caption       = element_text(hjust=0, colour = "grey", size = 12)) +
  scale_fill_manual(values = c_palette) +
  labs(x        = NULL, 
       y        = NULL,
       fill     = NULL,
       legend   = NULL,
       title    = "Distribution of individuals in different types of unions",
       caption  = "Joanna R. Pepin chart using Canadian long-form census (2016); summary statistics from the Vanier Institute of the 
Family; NOTE: exludes 'multiple visible minority statuses', 'visible minority not included elsewhere', and those 
with Aboriginal ancestry")
p

ggsave("mixed.png", path = figDir, p, width = 9, height = 6, dpi = 300, bg = 'white')
