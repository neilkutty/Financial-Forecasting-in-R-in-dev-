###
##
##  Quantmod Shiny Financial data app
##  authored by Neil Kutty
##  original quantmod rshiny code: http://shiny.rstudio.com/tutorial/lesson6/


library(shiny)

shinyUI(fluidPage(

  titlePanel("Quantmod Stock Chart and FBProphet Price Forecast"),
  helpText("For research only.  Not to be used for investment purposes."),
  url <- a("author: Neil Kutty", href="https://www.twitter.com/neilkutty"),
  
  fluidRow(
  
      column(width=4,offset=.5,
        
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
             
             checkboxInput("log", "Plot y axis on log scale", 
                           value = FALSE),
             
             checkboxInput("forecheck", "Generate Forecast",
                           value = FALSE),
             
        
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
         
  )
      
)))