library(shiny)

data(airquality)


#install.packages("RMariaDB")
#install.packages("odbc")

library(RMariaDB)


con <- dbConnect(
  drv = RMariaDB::MariaDB(), 
  username = "root",
  password = "1234", 
  dbname = "Test",
  host = "localhost", 
  port = 3306
)

rs = dbSendQuery(con,"SELECT * from pax_numbers")

daten = dbFetch(rs, n = -1)



# Define UI for app that draws a diagram ----
ui <- fluidPage(
  
  # App title ----
  titlePanel("PAX Counter"),
  
  
  # Main panel for displaying outputs ----
  mainPanel(
    
    # Output: Plot ----
    plotOutput(outputId = "dataPlot")
    
  )
  
)


server <- function(input, output){  
  
  output$dataPlot<-renderPlot({
    
    rs = dbSendQuery(con,"SELECT * from pax_numbers")
    
    daten = dbFetch(rs, n = -1)
    
  })
}

shinyApp(ui = ui, server = server)
