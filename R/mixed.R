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
type <- c("Both white", "Same Visible\nMinority Group", "White & Visible\nMinority Group", "Different Visible\nMinority Groups",
           "Both born\nin Canada", "Born same country\n(not Canada)", "Canada &\nAnother country", "Both born outside\nof Canada")
colors <- c("same", "same", "mixedVMG", "mixedVMG", "same", "same", "mixedOrigin", "mixedOrigin")
prop <- c(75.7,17,6.7,.6,64.4,19.8,11.8,4.1)
data <- data.frame(group, type, prop, colors)

data$type <- factor(data$type,
                     levels = c("Both white", "Same Visible\nMinority Group", "White & Visible\nMinority Group", "Different Visible\nMinority Groups",
                                "Both born\nin Canada", "Born same country\n(not Canada)", "Canada &\nAnother country", "Both born outside\nof Canada"), ordered = F)

data$group <- factor(data$group, 
                     levels = c("Visible Minority Group", "Country of Origin"), ordered = F)

# Figure -----------------------------------------------------------------------

p <- ggplot(data, aes(x = factor(type), y = prop, fill = colors, label = prop)) +
  geom_col(width = .5) +
  # Set the position to its complementary
  geom_text(show.legend = FALSE, color = "#7b8a8b", vjust=-0.25) +
  facet_grid(col = vars(group), scales = "free_x") +
  theme_minimal(base_size = 20) +
  theme(legend.position    = "none",
        panel.grid.minor   = element_blank(),
        panel.grid.major.x = element_blank(),
        axis.text.y        = element_blank(),
        axis.text.x        = element_text(angle = 35, vjust = 1.2, hjust=1, size = 12),
        plot.subtitle      = element_text(face = "italic"),
        plot.caption       = element_text(hjust=0, colour = "grey", size = 12)) +
  scale_fill_manual(values = c("#3498DB",  "#20c997", "#b4bcc2")) +
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
