library(shiny)

#starts SHINY page
shinyUI(fluidPage( 
  
  titlePanel("Rice Data Visualization"),
  
  # Description of application
  helpText("The following application creates a user-friendly visualization of various rice phenotypic traits of
            as they relate to their population or country of origin. User has choice to display data in multiple graph styles ,
           including violin, scatter, or box-plot formats. Users can also choose whether to color the traits by",
           " either population or country of origin."),
  
  # phenotypic trait choice
  sidebarLayout(
    sidebarPanel(
      radioButtons("plot", 
                   "Choose a graph format",
                   c("Violin Plot"="violin",
                     "Box Plot" = "boxplot",
                     "Scatter Plot" = "scatterplot"
                     )
      ),
      radioButtons("trait", 
                   "Choose a trait to plot",
                   c("Aluminum Tolerance" = "Alu.Tol",
                     "Amylose Content" = "Amylose.content",
                     "Blast Resistance" = "Blast.resistance",
                     "Plant Height" = "Plant.height",
                     "Seed Length" = "Seed.length",
                     "Seed Width" = "Seed.width",
                     "Seed Volume" = "Seed.volume")
      ),
      radioButtons("pheno", 
                   "Choose a trait to plot against (only for scatterplot)",
                   c("Aluminum Tolerance" = "Alu.Tol",
                     "Amylose Content" = "Amylose.content",
                     "Blast Resistance" = "Blast.resistance",
                     "Plant Height" = "Plant.height",
                     "Seed Length" = "Seed.length",
                     "Seed Width" = "Seed.width",
                     "Seed Volume" = "Seed.volume")
      ),
      radioButtons("color", 
                   "Choose how to color the plot:",
                   c("popID",
                     "Region")
      )
    ),
    # Show a plot of the generated distribution
      mainPanel(plotOutput("boxPlot"))
    )
  )
)
  