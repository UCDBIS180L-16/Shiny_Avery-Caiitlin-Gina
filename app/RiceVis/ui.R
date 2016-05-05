library(shiny)

#starts SHINY page
shinyUI(fluidPage( 
  
  titlePanel("Rice Data Visualization"),
  
  # Description of application
  helpText("The following application creates a scatterplot of user-chosen ",
           "phenotypic traits. Users can also choose whether to color the traits by",
           " either population or country of origin."),
  
  # phenotypic trait choice
  sidebarLayout(
    sidebarPanel(
      radioButtons("pheno", 
                   "Choose a phenotype to plot",
                   c("Plant.height",
                     "Seed.length",
                     "Seed.width",
                     "Seed.volume")
      ),
      radioButtons("trait", 
                   "Choose a trait to plot the phenotype against",
                   c("Alu.Tol",
                     "Amylose.content",
                     "Blast.resistance")
      ),
      radioButtons("color", 
                   "Choose how to color the plot:",
                   c("Population",
                     "Region")
      )
    ),
    # Show a plot of the generated distribution
      mainPanel(plotOutput("boxPlot"))
    )
  )
)
  