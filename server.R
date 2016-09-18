library(shiny)
library(DT)
library(ggplot2)

# Cty<-read.csv("mydata/Counties.csv")
# Cty<- data.table(Cty)

Florida<- fread("mydata/20141516v3.csv")
Florida$Year<-as.factor(Florida$Year)
Florida$Carrier<-as.factor(Florida$Carrier)
Florida$Metal<-as.factor(Florida$Metal)
Florida$Type<-as.factor(Florida$Type)
# can't figure out, it wants to replace names with 1,2,3  Florida$County<-as.factor(Florida$County)


CountyNames <-sort(unique(Florida$County))

shinyServer(
  function(input, output, session) {

output$CountyControls <- renderUI({
  checkboxGroupInput("CountyInput", "County",
	sort(unique(Florida$County)),
	selected = CountyNames)
})

   
filtered<- reactive ({
	Florida %>% 
	filter(Year == input$YearPick,
		Metal == input$MetalLevel,
		County %in% input$CountyInput
		)
})
filteredplot<- reactive ({
	Florida %>% 
	filter(	Metal == input$MetalLevel,
		County %in% input$CountyInput
		)
})


# Probably should have flattened table so people could pick age
# but I have already put about 50 hours into this so am
# just putting 3 plots at different age buckets to show
# age 40, age 21, and age 60

output$plot40 <- renderPlot({
	
qplot(Age_40, data=filteredplot(), fill=Year) +
labs(title = "Price of Health Insurance for Age = 30",
x = "Price of Policy",
y = "Count of Policies Offered at that Price") +
geom_histogram(binwidth=50)

	})

output$dataCounty <- renderDataTable({
     filtered()
   })


output$plot21 <- renderPlot({
	
qplot(Age_21, data=filteredplot(), fill=Year) +
labs(title = "Price of Health Insurance for Age = 21",
x = "Price of Policy",
y = "Count of Policies Offered at that Price")+
geom_histogram(binwidth=50)

	})

output$dataCounty <- renderDataTable({
     filtered()
   })



output$plot60 <- renderPlot({
	
qplot(Age_60, data=filteredplot(), fill=Year) +
labs(title = "Price of Health Insurance for Age = 60",
x = "Price of Policy",
y = "Count of Policies Offered at that Price")+
geom_histogram(binwidth=50)

	})

output$dataCounty <- renderDataTable({
     filtered()
   })

})
