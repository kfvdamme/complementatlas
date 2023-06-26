
print("Loading server.R")
source("server.R")

print("Loading ui.R")
source("ui.R")

print("starting shinyApp")
runApp( appDir = shinyApp(ui, server), port = 29542 )
