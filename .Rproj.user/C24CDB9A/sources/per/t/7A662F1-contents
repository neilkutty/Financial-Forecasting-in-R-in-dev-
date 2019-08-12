###
##
##  Quantmod Shiny Financial data app
##  authored by Neil Kutty
##  original quantmod rshiny code: http://shiny.rstudio.com/tutorial/lesson6/


library(shiny)

shinyUI(fluidPage(
  tags$code('<.<.<. -------------------------- currently under development -------------------------- .>.>.>'),
  titlePanel("Stock Price Charting and FB Prophet Forecast"),
  helpText("For research only.  Not to be used for investment purposes."),
  tags$code('<.<.<. -------------------------- currently under development -------------------------- .>.>.>'),
  br(),br(),
  url <- a("author: Neil Kutty", href="https://www.twitter.com/neilkutty"),
  
  fluidRow(
  
      column(width=3,
        
        textInput("symb", "Symbol", "TWTR"),
        
       
        selectInput("themeselection", "Choose chart theme:",
                    choices = c('Black chart theme'='black',
                                'White chart theme'='white',
                                'Beige chart theme'='beige'),
                    selected = 'black')
            ),
      
      column(width=4,
             dateRangeInput("dates",  
                            "Date range",
                            start = "2018-01-01", 
                            end = as.character(Sys.Date())),
             
             
             # 
             # checkboxInput("forecheck", "Generate Forecast",
             #               value = FALSE),
             
             
             selectInput("charttype", "Choose chart type:",
                         choices = c('Auto'='auto',
                                     'Line chart'='line',
                                     'Candlesticks'='candlesticks',
                                     'Matchsticks'='matchsticks',
                                     'Bar chart'='bars'),
                         selected='auto')
             
             ),
      
      column(width=3,offset = -0.5,
             checkboxInput("log", "Plot y axis on log scale",
                           value = FALSE))
  ),
  
  fluidRow(
      column(width=4, 
             submitButton(text = "Apply Changes", icon = NULL, width = NULL)
             )
    ),
    
  fluidRow(
        column(width=12,
             h3(textOutput('symb_name')),
             plotOutput("plot", height = "600px")
      )
     ),


  fluidRow(

    br(),
    br(),
    hr(),
    br(),
    column(width=12,
           tags$b((textOutput('proph_label'))),
        
           plotOutput("plot2", height = "600px")
           ),
    tags$code('<.<.<. -------------------------- currently under development -------------------------- .>.>.>'),
    br(),
    url <- a("author: Neil Kutty", href="https://www.twitter.com/neilkutty"),
    br(),
    br()
    
    )))

