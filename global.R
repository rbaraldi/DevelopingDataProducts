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

library(tm)
library(wordcloud)
library(memoise)

# The list of valid books
books <<- list("Romeo and Juliet" = "romeo",
               "The First Part of King Henry the Fourth" = "king",
               "The Kama Sutra of Vatsyayana" = "kama",
               "Metamorphosis" = "kafka",
               "The Picture of Dorian Gray" = "wilde",
               "Emma" = "emma",
               "Pride and Prejudice" = "pride",
               "Les Miserables" = "miserables",
               "Ulysses" = "ulysses", 
               "Moby Dick" = "moby")

# Using "memoise" to automatically cache the results
getTermMatrix <- memoise(function(book) {
  # Careful not to let just any name slip in here; a
  # malicious user could manipulate this value.
  if (!(book %in% books))
    stop("Unknown book")
  
  text <- readLines(sprintf("./%s.txt", book),
                    encoding="UTF-8")
  
  myCorpus = Corpus(VectorSource(text))
  myCorpus = tm_map(myCorpus, content_transformer(tolower))
  myCorpus = tm_map(myCorpus, removePunctuation)
  myCorpus = tm_map(myCorpus, removeNumbers)
  myCorpus = tm_map(myCorpus, removeWords,
                    c(stopwords("SMART"), "thy", "thou", "thee", "the", "and", "but"))
  
  myDTM = TermDocumentMatrix(myCorpus,
                             control = list(minWordLength = 1))
  
  m = as.matrix(myDTM)
  
  sort(rowSums(m), decreasing = TRUE)
})