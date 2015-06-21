#
# This application was based on the examples provided by the Shiny gallery
# The Shiny gallery it´s a project sponsored by RSturio
#
# http://shiny.rstudio.com/gallery/ (Take a look at the gallery, a lot of great examples)
#
# Developing Data Products - Course Project
#
# Books provided by http://www.gutenberg.org/
#

function(input, output, session) {
  # Define a reactive expression for the document term matrix
  terms <- reactive({
    # Change when the "update" button is pressed...
    input$update
    # ...but not for anything else
    isolate({
      withProgress({
        setProgress(message = "Processing corpus...")
        getTermMatrix(input$selection)
      })
    })
  })
  
  # Make the wordcloud drawing predictable during a session
  wordcloud_rep <- repeatable(wordcloud)
  
  output$plot <- renderPlot({
    v <- terms()
    wordcloud_rep(names(v), v, scale=c(4,0.5),
                  min.freq = input$freq, max.words=input$max,
                  colors=brewer.pal(8, "Dark2"))
  })
}