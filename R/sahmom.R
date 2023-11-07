#-------------------------------------------------------------------------------
# NOW YOU CANADAKNOW PROJECT
# FamilySuffers.R
# Joanna R. Pepin
#-------------------------------------------------------------------------------

# Setup & Packages: ------------------------------------------------------------
# The packages & color palette are available in a separate script that should be
# run first: https://github.com/jrpepin/Now-You-CanadaKnow/blob/main/R/00_runfirst.R


# Data: ------------------------------------------------------------------------
# Source: Statistics Canada, Labour Force Survey, 1976 to 2015.
# https://www150.statcan.gc.ca/n1/pub/11-630-x/11-630-x2016007-eng.htm#def1
# 2016 Data: https://www.statcan.gc.ca/en/dai/smr08/2017/smr08_216_2017

# Variable Processing ----------------------------------------------------------
data <- data.frame(
  year = c(
    1976,  1977,  1978,  1979,  1980,  1981,  1982,  1983,
    1984,  1985,  1986,  1987,  1988,  1989,  1990,  1991,
    1992,  1993,  1994,  1995,  1996,  1997,  1998,  1999,
    2000,  2001,  2002,  2003,  2004,  2005,  2006,  2007,
    2008,  2009,  2010,  2011,  2012,  2013,  2014,  2015, 2016),
  sah = c(
    1466,  1423,  1336,  1307,  1235,  1135,  1060,   994,
     945,   893,   827,   785,   734,   705,   672,   614,
     603,   586,   579,   575,   578,   557,   543,   536,
     540,   513,   480,   462,   465,   469,   468,   438,
     467,   437,   433,   439,   433,   426,   446,   441, 445))

# Figure -----------------------------------------------------------------------

labels <- data %>%
  filter(year == 1976 | year == 2016)

p <- ggplot(data, aes(x = year, y = sah)) +
  geom_line() +
  geom_label(data = labels, aes(x= year, y = sah, label= sah), color = "white", fill = "#20c997", fontface = "bold") +
  theme_minimal(base_size = 20) +
  theme(legend.position = "none",
        panel.grid.minor   = element_blank(),
        panel.grid.major.x = element_blank(),
        axis.title.y       = element_text(angle=0, vjust = 1, hjust = .5),
        plot.subtitle      = element_text(face = "italic", colour = "grey", size = 14),
        plot.title.position = "plot",
        plot.caption       = element_text(hjust=0, colour = "grey", size = 12)) +
  scale_y_continuous(label=comma, breaks = seq(from = 0, to = 1600, by = 200), limits = c(0,1600)) +
  scale_x_continuous(breaks = seq(from = 1976, to = 2016, by = 5), limits = c(1976,2016)) +
  labs(x        = NULL, 
       y        = NULL,
       fill     = NULL,
       legend   = NULL,
       title    = "Canadian stay-at-home mothers",
       subtitle = "thousands",
       caption  = "Joanna R. Pepin chart using Statistics Canada, Labour Force Survey, 1976 to 2016 data") 

p

ggsave("sahmom.png", path = figDir, p, width = 9, height = 6, dpi = 300, bg = 'white')
