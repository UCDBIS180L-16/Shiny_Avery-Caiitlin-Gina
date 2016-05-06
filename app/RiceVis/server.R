#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

test <- readRDS(file="data.Rda")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  output$boxPlot <- renderPlot({
    
    # set up the plot
    pl <- ggplot(data = test,
                 #Use aes_string below so that input$trait is interpreted
                 #correctly.  The other variables need to be quoted
                 aes_string(x=input$color,
                            y=input$trait,
                            color=input$color
                 )
    )
    pl2 <- ggplot(data = data.pheno.mds, 
                 aes_string(x=input$pheno, 
                            y=input$trait, 
                            color=input$color
                 ))
    
    # draw the boxplot for the specified trait
    if(input$plot=="violin"){pl + geom_violin()}
    else{
      if(input$plot=="boxplot"){pl + geom_boxplot()}
      else(pl2 + geom_point() + geom_smooth(method=lm,   # Add linear regression lines
                                            se=FALSE,    # Don't add shaded confidence region
                                            fullrange=FALSE))
    }
    })
})
