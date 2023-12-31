#-------------------------------------------------------------------------------
# NOW YOU CANADAKNOW PROJECT
# class.R
# Joanna R. Pepin
#-------------------------------------------------------------------------------

# Setup & Packages: ------------------------------------------------------------
# The packages & color palette are available in a separate script that should be
# run first: https://github.com/jrpepin/Now-You-CanadaKnow/blob/main/R/00_runfirst.R

# Data: ------------------------------------------------------------------------
# Source: Angus Reid Institute in partnership with the University of Alberta Sociology Department  
# https://angusreid.org/great-canadian-class-study/

# Variable Processing ----------------------------------------------------------
group <- c("Poverty", "Poverty", "Poverty", "Poverty",  
           "Working", "Working", "Working", "Working", 
           "Lower\nmiddle", "Lower\nmiddle", "Lower\nmiddle", "Lower\nmiddle", 
           "Middle", "Middle", "Middle", "Middle", 
           "Upper\nmiddle", "Upper\nmiddle", "Upper\nmiddle", "Upper\nmiddle")
act  <- c( "My family regularly ate dinner\ntogether most weeknights", 
           "Someone read to me\nwhen I was growing up", 
           "My parents or gaurdians did not\nhave to work nights or weekends", 
           "My family paid someone to help\nwith the cooking or cleaning",
           "My family regularly ate dinner\ntogether most weeknights", 
           "Someone read to me\nwhen I was growing up", 
           "My parents or gaurdians did not\nhave to work nights or weekends", 
           "My family paid someone to help\nwith the cooking or cleaning",
           "My family regularly ate dinner\ntogether most weeknights", 
           "Someone read to me\nwhen I was growing up", 
           "My parents or gaurdians did not\nhave to work nights or weekends", 
           "My family paid someone to help\nwith the cooking or cleaning",
           "My family regularly ate dinner\ntogether most weeknights", 
           "Someone read to me\nwhen I was growing up", 
           "My parents or gaurdians did not\nhave to work nights or weekends", 
           "My family paid someone to help\nwith the cooking or cleaning",
           "My family regularly ate dinner\ntogether most weeknights", 
           "Someone read to me\nwhen I was growing up", 
           "My parents or gaurdians did not\nhave to work nights or weekends", 
           "My family paid someone to help\nwith the cooking or cleaning")
prop <- c(49, 31, 26, 1,
          69, 44, 33, 2,
          71, 54, 40, 4,
          77, 58, 50, 7,
          76, 66, 55, 26)

data <- data.frame(group, act, prop)

data$group <- factor(data$group, 
                     levels = c("Poverty", "Working", "Lower\nmiddle", "Middle", "Upper\nmiddle"), ordered = F)

data$act <- factor(data$act,
                     levels = c("My family regularly ate dinner\ntogether most weeknights", 
                                "Someone read to me\nwhen I was growing up", 
                                "My parents or gaurdians did not\nhave to work nights or weekends", 
                                "My family paid someone to help\nwith the cooking or cleaning"), ordered = F)

# Figure -----------------------------------------------------------------------

p <- ggplot(data, aes(x = factor(group), y = prop, fill = group, label = prop)) +
  geom_col(width = .5) +
  geom_text(show.legend = FALSE, color = "#7b8a8b", hjust=-0.25) +
  facet_wrap(~ act, ncol = 2) +
  coord_flip() +
  theme_minimal(base_size = 15) +
  theme(legend.position    = "none",
        panel.grid.minor   = element_blank(),
        panel.grid.major.x = element_blank(),
        axis.text.x        = element_blank(),
        axis.text.y        = element_text(size = 12),
        plot.subtitle      = element_text(face = "italic"),
        plot.caption       = element_text(hjust=0, colour = "grey", size = 12)) +
  scale_fill_manual(values = c("#e74c3c", "#F39C12", "#3498DB", "#20c997", "#b4bcc2")) +
  labs(x        = NULL, 
       y        = NULL,
       fill     = NULL,
       legend   = NULL,
       title    = "Distribution of childhood situations by Canadians' class identity",
       caption  = "Joanna R. Pepin chart from summary statistics from 2023 survey of 8,043 Canadians conducted by the \nAngus Reid Institute and University of Alberta Sociology Department")

p

ggsave("class.png", path = figDir, p, width = 9, height = 6.5, dpi = 300, bg = 'white')

  
