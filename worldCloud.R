source("twitterAuthorization.R")
head(modi)

install.packages("SnowballC")
library(wordcloud)
library(SnowballC)
library(tm)

modi_text = sapply(modi,function(x) x$getText())
#typeof(modi_text)
#head(modi_text)

modi_corpus = Corpus(VectorSource(modi_text))

modi_corpus = tm_map(modi_corpus,removePunctuation)
modi_corpus = tm_map(modi_corpus,content_transformer(tolower))

modi_corpus = tm_map(modi_corpus,function(x)removeWords(x,stopwords(kind = "SMART")))
modi_corpus = tm_map(modi_corpus,removeWords,c("RT","@","https","com","www","...","ani"))
removeUrl = function(x) gsub("http[[:alnum:]]*","", x)
modi_corpus = tm_map(modi_corpus,content_transformer(removeUrl))

modi_tdm = TermDocumentMatrix(modi_corpus)
modi_tdm = as.matrix(modi_tdm)
modi_tdm = sort(rowSums(modi_tdm),decreasing = TRUE)

modi_tdm = data.frame(word = names(modi_tdm),freq=modi_tdm)

barplot(modi_tdm[1:20,]$freq,las=2,names.arg=modi_tdm[1:20,]$word,col="red",main="Most frequent words",ylab="Frequency")
set.seed(1234)
wordcloud(modi_corpus,min.freq = 1,max.words = 80,scale = c(2.2,1),colors = brewer.pal(8,"Dark2"),random.color = T,random.order = F)