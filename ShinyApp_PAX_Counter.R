# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Anzahl der BesucherInnen ueber die Zeit"),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("distPlot")
        )
    )

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$distPlot <- renderPlot({
        # from ui.R
        x<-datatest$Time <- as.POSIXct(paste0(as.character(datatest$DATE),substr(as.character(datatest$TIME),11,20)))
        Anzahl_BesucherInnen    <- datatest$NUMBER
        
        # plot
        ggplot(datatest, aes(x=Time,y=NUMBER)) + geom_line()
        
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
