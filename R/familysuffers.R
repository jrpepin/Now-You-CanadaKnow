#-------------------------------------------------------------------------------
# NOW YOU CANADAKNOW PROJECT
# FamilySuffers.R
# Joanna R. Pepin
#-------------------------------------------------------------------------------

# Setup & Packages: ------------------------------------------------------------
# The packages & color palette are available in a separate script that should be
# run first: https://github.com/jrpepin/Now-You-CanadaKnow/blob/main/R/00_runfirst.R


# Data: ------------------------------------------------------------------------
# https://epe.lac-bac.gc.ca/100/200/301/pwgsc-tpsgc/por-ef/women_gender_equality_Canada/2020/070-18-e/report.html#section_3_1


# Variable Processing ----------------------------------------------------------
group <- c("All", "All", "All", "Women", "Women", "Women", "Men", "Men", "Men")
index <- c("Agree", 	"Disagree", "Don't know",
           "Agree", 	"Disagree", "Don't know",
           "Agree", 	"Disagree", "Don't know")
prop <- c(33, 64, 3, 33, 65, 2, 34, 63, 3)
data <- data.frame(group, index, prop)

data$group <- factor(data$group, 
                     levels = c("All", "Women", "Men"), ordered = F)

data$index <- factor(data$index,
                     levels = c("Don't know", "Agree", "Disagree"), ordered = F)


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
  scale_fill_manual(values = c_palette) +
  labs(x        = NULL, 
       y        = NULL,
       fill     = NULL,
       legend   = NULL,
       title    = "% of Canadians who _____________",
       subtitle = "'Family life suffers when the woman has a full-time job'",
       caption  = "Joanna R. Pepin chart using Women and Gender Equality Canada (2019) data")
  
p

ggsave("famsuffer.png", path = figDir, p, width = 9, height = 6, dpi = 300, bg = 'white')

