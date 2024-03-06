library(tidyverse)
library(shiny)
library(shinydashboard)

UC_admit <- read_csv("data/UC_admit.csv")


UC_admit <-UC_admit %>% 
  mutate(`Perc FR`= as.numeric(substr(`Perc FR`, 1, nchar(`Perc FR`) -1 )))

ui <- dashboardPage(
  
  dashboardHeader(title = "UC Admissions"),
  
  dashboardSidebar(disable=T),
  
  dashboardBody(
    fluidRow(
      box(width=3,
          radioButtons("x", "Select Campus", choices = unique(UC_admit$Campus)), hr() 
      ), 
      box(width=3,
          selectInput("y", "Select Admit Category", choices = unique(UC_admit$Category)), hr()  
      ),
      box(width=3,
          selectInput("z", "Select Academic Year", choices = unique(UC_admit$Academic_Yr)), hr()  
      ),
      box(width=7,
          plotOutput("plot", width = "500px", height = "400px")
      ) # close the row
    ) # close the dashboard body
  ) # close the ui
)

server <- function(input, output, session) {
  
  session$onSessionEnded(stopApp) #automatically stop the app when we close it
  
  output$plot <- renderPlot({
    UC_admit %>% 
      filter(Campus == input$x) %>%
      filter(Category == input$y) %>% 
      filter(Academic_Yr == input$z) %>% 
      filter(Ethnicity != "All") %>% 
      ggplot(aes(x=reorder(Ethnicity, `Perc FR`), y=`Perc FR`, fill=Ethnicity))+
      geom_col() + 
      labs(title="Admissions by Etnicity", x="Ethnicity", y="% Admissions") + 
      theme(legend.position = "none", axis.text.x = element_text(angle=50, hjust=1))
  })
}

shinyApp(ui, server) 
