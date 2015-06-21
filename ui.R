#
# This application was based on the examples provided by the Shiny gallery
# The Shiny gallery it´s a project sponsored by RSturio
#
# http://shiny.rstudio.com/gallery/ (Take a look at the gallery, a lot of great examples)
#
# Developing Data Products - Course Project
#
# Books provided by http://www.gutenberg.org/
#

fluidPage(
  # Application title
  titlePanel("Word Cloud - a Shiny gallery example"),
  
  sidebarLayout(
    # Sidebar with a slider and selection inputs
    sidebarPanel(
      selectInput("selection", "Choose a book:",
                  choices = books),
      actionButton("update", "Change"),
      hr(),
      sliderInput("freq",
                  "Minimum Frequency:",
                  min = 1,  max = 50, value = 15),
      sliderInput("max",
                  "Maximum Number of Words:",
                  min = 1,  max = 300,  value = 100)
    ),
    
    # Show Word Cloud
    mainPanel(
      plotOutput("plot")
    )
  )
)