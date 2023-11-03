#-------------------------------------------------------------------------------
# NOW YOU CANADAKNOW PROJECT
# Households.R
# Joanna R. Pepin
#-------------------------------------------------------------------------------

# Data: https://www150.statcan.gc.ca/n1/daily-quotidien/220713/g-a004-eng.htm
type <- c("One-census family", "Other-census family", "Roommate HH", "1 person")
year <- c("2001", "2001", "2001", "2001",
          "2006", "2006", "2006", "2006",
          "2011", "2011", "2011", "2011",
          "2016", "2016", "2016", "2016",
          "2021", "2021", "2021", "2021")
prop <- c(64.6, 5.9, 3.7, 25.7,
          63.6, 5.9, 3.7, 26.8,
          62.0, 6.3, 4.1, 27.6,
          61.2, 6.5, 4.1, 28.2,
          59.6, 6.6, 4.4, 29.3)
data <- data.frame(type, year, prop)

data$type <- factor(data$type, 
                    levels = c("One-census family", "Other-census family", 
                               "Roommate HH", "1 person"), ordered = FALSE)

hh <- ggplot(data, aes(x = factor(year), y = prop, fill = type, label = prop)) +
  geom_col(position = position_stack(reverse = TRUE),
           width = .5) +
  # Set the position to its complementary
  geom_text(position = position_stack(reverse = TRUE, vjust = .5),
            show.legend = FALSE, color = "white") +
  coord_flip() +
  scale_x_discrete(limits=rev) +
  theme_minimal(base_size = 20) +
  theme(legend.position    = "top",
        panel.grid.minor   = element_blank(),
        panel.grid.major.x = element_blank(),
        axis.text.x        = element_blank(),
        plot.caption       = element_text(hjust=0, colour = "grey",)) +
  scale_fill_manual(values = c_palette) +
  ggtitle("Distribution (%) of household types in Canada") +
  labs(x        = NULL, 
       y        = NULL,
       fill     = NULL,
       legend   = NULL,
       caption  = "Joanna R. Pepin | Source: Census of Population 2001 to 2021 (3901)") 

hh

ggsave("hh.png", path = figDir, hh, width = 9, height = 6, dpi = 300, bg = 'white')
