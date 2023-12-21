#-------------------------------------------------------------------------------
# NOW YOU CANADAKNOW PROJECT
# marrace.R
# Joanna R. Pepin
#-------------------------------------------------------------------------------

# Setup & Packages: ------------------------------------------------------------
# The packages & color palette are available in a separate script that should be
# run first: https://github.com/jrpepin/Now-You-CanadaKnow/blob/main/R/00_runfirst.R


# Data: ------------------------------------------------------------------------
# Source: Ipsos poll conducted on behalf of Global News
# https://www.ipsos.com/sites/default/files/ct/news/documents/2019-05/19-032401-01-03_735_b-racism-weighted_banner1_sort.pdf
# Table 2_3. Please indicate whether you strongly agree, somewhat agree, somewhat disagree or strongly disagree with the following:
# - I would never marry or have a relationship with someone of a different race

# Variable Processing ----------------------------------------------------------
group <- c("All", "All", "All", "All", "All", "Ages:\n18-34", "Ages:\n18-34",  "Ages:\n18-34", "Ages:\n18-34", "Ages:\n18-34", 
           "35-54", "35-54", "35-54", "35-54", "35-54", "55+", "55+", "55+", "55+", "55+")
index <- c("Strongly\nagree", "Somewhat\nagree", "Somewhat\ndisagree", "Strongly\ndisagree", "Don't\nknow",
           "Strongly\nagree", "Somewhat\nagree", "Somewhat\ndisagree", "Strongly\ndisagree", "Don't\nknow",
           "Strongly\nagree", "Somewhat\nagree", "Somewhat\ndisagree", "Strongly\ndisagree", "Don't\nknow",
           "Strongly\nagree", "Somewhat\nagree", "Somewhat\ndisagree", "Strongly\ndisagree", "Don't\nknow")
prop <- c(6,  8, 20, 58,  9,
          7,  7, 12, 66,  8,
          6, 11, 14, 58, 11,
          6,  7, 29, 47, 10)
data <- data.frame(group, index, prop)

data$group <- factor(data$group, 
                     levels = c("All", "Ages:\n18-34", "35-54", "55+"), ordered = F)

data$index <- factor(data$index,
                     levels = c("Don't\nknow", "Strongly\nagree", "Somewhat\nagree", "Somewhat\ndisagree", "Strongly\ndisagree"), ordered = F)


# Figure -----------------------------------------------------------------------
p <- ggplot(data, aes(x = factor(group), y = prop, fill = index, label = prop)) +
  geom_col(position = position_stack(),
           width = .5) +
  # Set the position to its complementary
  geom_text(position = position_stack(vjust = .5),
            show.legend = FALSE, color = "white") +
  coord_flip() +
  scale_x_discrete(limits=rev) +
  guides(fill = guide_legend(reverse=TRUE)) +
  theme_minimal(base_size = 20) +
  theme(legend.position="top",
        panel.grid.minor = element_blank(),
        panel.grid.major.x = element_blank(),
        axis.text.x        = element_blank(),
        plot.subtitle      = element_text(face = "italic"),
        plot.caption       = element_text(hjust=0, colour = "grey", size = 12)) +
  scale_fill_manual(values = c("#b4bcc2", "#20c997", "#3498DB", "#F39C12", "#e74c3c")) +
  labs(x        = NULL, 
       y        = NULL,
       fill     = NULL,
       legend   = NULL,
       title    = "% of Canadians who _____________",
       subtitle = "'I would never marry or have a relationship with\nsomeone of a different race'",
       caption  = "Joanna R. Pepin chart using Ipsos 2019 poll conducted on behalf of Global News\n(may not sum to 100% due to rounding)")

p

ggsave("marrace.png", path = figDir, p, width = 9, height = 6, dpi = 300, bg = 'white')

