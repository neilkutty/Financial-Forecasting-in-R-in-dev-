###
##
##  Quantmod Shiny Financial data app
##  authored by Neil Kutty
##  original quantmod rshiny code: http://shiny.rstudio.com/tutorial/lesson6/


library(shiny)
library(shinycssloaders)
library(shinythemes)

shinyUI(fluidPage(theme = shinytheme("united"),
  div(tags$code('<.<.<. -------------------------- currently under development -------------------------- .>.>.>'),
  titlePanel("Price Charting and FB Prophet Forecast for Stocks"),
  helpText("For research only.  Not to be used for investment purposes."),
  div(tags$i(tags$b('BETA')), align="center") ,
  br(),
  tags$code('<.<.<. -------------------------- currently under development -------------------------- .>.>.>'),
  br(),br(), align="center"),
  
  
  fluidRow(
  
      column(width=6,
        
        textInput("symb", "Symbol", "TWTR"),
        
       
        selectInput("themeselection", "Choose chart theme:",
                    choices = c('Black chart theme'='black',
                                'White chart theme'='white',
                                'Beige chart theme'='beige'),
                    selected = 'black')
            ),
      
      column(width=6,
             dateRangeInput("dates",  
                            "Date range",
                            start = as.character(Sys.Date()-200), 
                            end = as.character(Sys.Date())),
             
             
             
             # checkboxInput("forcheck", "Generate Forecast",
             #                value = FALSE),
             
             
             selectInput("charttype", "Choose chart type:",
                         choices = c('Auto'='auto',
                                     'Line chart'='line',
                                     'Candlesticks'='candlesticks',
                                     'Matchsticks'='matchsticks',
                                     'Bar chart'='bars'),
                         selected='auto')
             
             )
  ),
  
  fluidRow(
      column(width=4, 
             submitButton(text = "Apply Changes", icon = NULL, width = NULL)
             )
    ),
    
  fluidRow(
        column(width=12,
             h3(textOutput('symb_name')),
            withSpinner(plotOutput("plot", height = "600px"))
      )
     ),


 fluidRow(

    br(),
    br(),
    hr(),
    br(),
    column(width=12,
           tags$b((textOutput('proph_label'))),
        
           withSpinner(plotOutput("plot2", height = "600px"))
           )
  ),

 
 
  fluidRow(
   column(width=10,
          tableOutput('table1')
   ),
   
   fluidRow(
     column(width=12, plotOutput("plot3"))
   )
   
   # fluidRow(
   #   column(width=4, textOutput("text1"))
   # )
 ),

 
 fluidRow(
    column(width=12, align="center",
    tags$code(' <.<.<. -------------------------- currently under development -------------------------- .>.>.>'),
    br(),
    url <- a(" author: Neil Kutty", href="https://www.twitter.com/neilkutty"),
    br(),
    helpText('data provided by quantmod'),
    br()
    )
  )

  
))

