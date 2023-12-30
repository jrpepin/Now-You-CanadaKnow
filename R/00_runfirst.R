#-------------------------------------------------------------------------------
# NOW YOU CANADAKNOW PROJECT
# 00_runfirst.R
# Joanna R. Pepin
#-------------------------------------------------------------------------------

# PACKAGES ---------------------------------------------------------------------

## WARNING: Remove the leading # to install packages below the first time. 
## Change filepaths below once

# install.packages("pacman")  # Install pacman package if not installed

# Installs and loads packages automatically
library("pacman")                  # Load pacman package

pacman::p_load(
  here,       # relative file paths
  readxl,     # import excel data tables
  dplyr,      # variable processing
  tidyr,      # reshaping data
  forcats,    # reverse factor variables
  srvyr,      # calc % with survey weights
  purrr,      # to use modify_at
  MESS,       # round prop & preserve sum to 100%
  data.table, #
  gtsummary,  # pretty weighted tables
  ggplot2,    # graphing
  colorspace, # color palettes  
  scales,     # format axes
  conflicted) # choose default packages

# Address any conflicts in the packages
conflict_scout() # identify the conflicts
conflict_prefer("between",   "dplyr")
conflict_prefer("filter",    "srvyr")
conflict_prefer("first",     "dplyr")
conflict_prefer("lag",       "dplyr")
conflict_prefer("last",      "dplyr")
conflict_prefer("transpose", "data.table")

# Set-up the Directories -------------------------------------------------------

## Set the project directory to the current working directory.
projDir <- here::here()     # File path to this project's directory
figDir  <- "figs"           # Name of the sub-folder where we will save generated figures


## This will create sub-directory folders in the master project directory if doesn't exist
if (!dir.exists(here::here(figDir))){
  dir.create(figDir)
} else {
  print("Figure directory already exists!")
}

# STYLE ------------------------------------------------------------------------

## Define color palette
c_palette <- c("#20c997",
               "#3498DB",
               "#F39C12",
               "#e74c3c")
