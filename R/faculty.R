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
