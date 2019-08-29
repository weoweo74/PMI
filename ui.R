@@ -1,4 +1,3 @@

## app.R ##
# install.packages("sp")
# install.packages("rgdal", repos="http://R-Forge.R-project.org", type="source")
# install.packages("raster")
# install.packages("shiny")
# install.packages("RColorBrewer")
# install.packages("malariaAtlas")
# install.packages("shinydashboard")
# install.packages("stringr")
# install.packages("shinyalert")
# install.packages("shinyBS")
# install.packages("shinythemes")
# install.packages("shinycssloaders")
# install.packages("shinyjs")
# install.packages("mapview")
# install.packages("leaflet")
# install.packages("kableExtra")
# install.packages("plotfunctions")
# install.packages("sf")
# #devtools::install_github("r-spatial/mapview@develop")
# install.packages("DT")
###############################################################pre-processing raster
@@ -504,127 +503,126 @@
                         bsTooltip(id = "processStats",
                                   title = "Run generation of statistics and ranking system. This will produce results which feature in the tabs to the right.",
                                   placement = "right", trigger = "hover", options = list(container = "body")),
                         
                         # download report button (defined in server)
                         uiOutput("downloadbutton")
                       ),
                       
                       mainPanel(
                         
                         tabsetPanel(id='main0', type = "tabs",
                                     #tabPanel(value ='tab1', title = "Selected country and districts", div(style = 'overflow-y:scroll;height:750px;',plotOutput("select_country", height = '750px', width = '750px'))),
                                     tabPanel(value ='tab1', title = "Map", div(style = 'overflow-y:scroll;height:750px;',leafletOutput("mapview_country_raster", height = '750px', width = '750px'))),
                                     #tabPanel(value ='tab1', title = "Map", leafletOutput("mapview_country_raster")),
                                     tabPanel(value ='tab3', title = "Table", DT::dataTableOutput("activetable")),
                                     tabPanel(value ='tab2', title = "Output Report", div(style = 'overflow-y:scroll;height:750px;',htmlOutput("report"))))
                       ) # end of main panel
                     ) # end of fluid page # end of sidebar layout
                         ) 
                       ), # end of tab panel
  
  # help main panel
  tabPanel("Help",
           # sub-panels within the 'help' tab
           tabsetPanel(type = 'tabs',
                       tabPanel(title='Help', includeMarkdown('help.md')),
                       tabPanel(title='About', includeMarkdown('about.md'))))
                     )
# create the server functions for the dashboard  
#### load required libraries ####
if(!require(raster)){
  install.packages("raster")
  library(raster)
}
if(!require(shiny)){
  install.packages("shiny")
  library(shiny)
}
if(!require(RColorBrewer)){
  install.packages("RColorBrewer")
  library(RColorBrewer)
}
if(!require(malariaAtlas)){
  install.packages("malariaAtlas")
  library(malariaAtlas)
}
if(!require(shinydashboard)){
  install.packages("shinydashboard")
  library(shinydashboard)
}
if(!require(stringr)){
  install.packages("stringr")
  library(stringr)
}
if(!require(shinyalert)){
  install.packages("shinyalert")
  library(shinyalert)
}
if(!require(shinyBS)){
  install.packages("shinyBS")
  library(shinyBS)
}
if(!require(shinythemes)){
  install.packages("shinythemes")
  library(shinythemes)
}
if(!require(knitr)){
  install.packages("knitr")
  library(knitr)
}
if(!require(kableExtra)){
  install.packages("kableExtra")
  library(kableExtra)
}
if(!require(shinyjs)){
  install.packages("shinyjs")
  library(shinyjs)
}
if(!require(plotfunctions)){
  install.packages("plotfunctions")
  library(plotfunctions)
}
if(!require(sf)){
  install.packages("sf")
  library(sf)
}
if(!require(mapview)){
  #devtools::install_github("r-spatial/mapview@develop")
  install.packages("mapview")
  library(mapview)
}
if(!require(leaflet)){
  install.packages("leaflet")
  library(leaflet)
}
#for interactive table
if(!require(DT)){
  install.packages("DT")
  library(DT)
}


# read in MAP availability lookup table
lookup <- read.csv('data/combined_lookup.csv', sep = ',', check.names = FALSE)

  5  ui.R 
@@ -24,46 +24,51 @@
  library(shinydashboard)
}
if(!require(stringr)){
  install.packages("stringr")
  library(stringr)
}
if(!require(shinyalert)){
  install.packages("shinyalert")
  library(shinyalert)
}
if(!require(shinyBS)){
  install.packages("shinyBS")
  library(shinyBS)
}
if(!require(shinythemes)){
  install.packages("shinythemes")
  library(shinythemes)
}
if(!require(shinycssloaders)){
  install.packages("shinycssloaders")
  library(shinycssloaders)
}
if(!require(shinyjs)){
  install.packages("shinyjs")
  library(shinyjs)
}
if(!require(mapview)){
  install.packages("mapview")
  library(mapview)
}
if(!require(leaflet)){
  install.packages("leaflet")
  library(leaflet)
}

if(!require(DT)){
  install.packages("DT")
  library(DT)
}

# generate a list of countries for which MAP data exists
# fix some encoding and country issues
load('data/sf_afr_simp_fao.rda')
sf_afr_simp <- sf_afr_simp[sf_afr_simp$COUNTRY_ID != "XXX",]
sf_afr_simp <- sf_afr_simp[sf_afr_simp$COUNTRY_ID != "MYT",]	
sf_afr_simp$name[sf_afr_simp$GAUL_CODE == "16840"] <- "Goh-Djiboua"
sf_afr_simp$name[sf_afr_simp$GAUL_CODE == "818"] <- "Extreme-Nord"
country_names <- sf_afr_simp$name[sf_afr_simp$ADMN_LEVEL==0]	
country_names <- country_names[country_names != "Hala'ib triangle"]	
country_names <- country_names[country_names != "Ma'tan al-Sarra"]
country_names <- country_names[country_names != "Ilemi triangle"]
country_names <- country_names[country_names != "Abyei"]
country_names <- country_names[country_names != "Cape Verde"]
country_names <- country_names[country_names != "Djibouti"]
country_names <- country_names[country_names != "Seychelles"]
country_names <- sort(country_names)
country_names[7] <- "Cote d'Ivoire"
# define a UI use a fluid bootstrap layout
appCSS <- "
#loading-content {
  position: absolute;
  background: #344151;
