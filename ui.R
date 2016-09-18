library(shiny)
library(ggplot2)
require(data.table)
library(dplyr)

# Read in the Data
CountyDATA<-read.csv("mydata/Counties.csv")


shinyUI(fluidPage(
    
# Application title
titlePanel("Florida ACA Pricing By County"),
  
#Sidebar
  
sidebarLayout(
    sidebarPanel(

# Selection of Policy Year (2014-2016)

    radioButtons("YearPick", label = h3("Year"),
	 choices = c("2016", "2015", "2014"),
	 selected = "2016"),
	 hr(),

# Selection of Plan Metal Level
    radioButtons("MetalLevel", label = h3("Metal Levels"), 
    choices = c("Platinum", "Gold", "Silver", "Bronze", "Catastrophic"),
    selected = "Silver"),
        
  hr(),
  hr(),
        
# I spent hours and days figuring the next part out, want user
# to be able to focus in by County

     uiOutput("CountyControls") 
                  
             ),

    
    # Show a tabset that includes a plot, summary, and table view
    # of the generated distribution
    mainPanel(
      tabsetPanel(type = "tabs", 
        tabPanel("Plot", plotOutput("plot40"), plotOutput("plot21"), plotOutput("plot60")), 
       
        tabPanel("Table", DT::dataTableOutput(outputId="dataCounty"),
		DT::dataTableOutput(outputId="dataCounty2015"),
		DT::dataTableOutput(outputId="dataCounty2014")

)

      )
    )
  )
))

