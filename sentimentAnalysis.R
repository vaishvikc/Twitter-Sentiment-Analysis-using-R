source("worldCloud.R")

pos.words = read.csv("pos.csv")
neg.words = read.csv("neg.csv")

pos.words = scan("pos.csv",what = "character")
neg.words = scan("neg.csv",what = "character")

score.sentiment <- function(sentences, pos.words, neg.words, .progress='none')
{
  require(plyr)
  require(stringr)
  scores <- laply(sentences, function(sentence, pos.words, neg.words){
    sentence <- gsub('[[:punct:]]', "", sentence)
    sentence <- gsub('[[:cntrl:]]', "", sentence)
    sentence <- gsub('\\d+', "", sentence)
    sentence <- tolower(sentence)
    word.list <- str_split(sentence, '\\s+')
    words <- unlist(word.list)
    pos.matches <- match(words, pos.words)
    neg.matches <- match(words, neg.words)
    pos.matches <- !is.na(pos.matches)
    neg.matches <- !is.na(neg.matches)
    score <- sum(pos.matches) - sum(neg.matches)
    return(score)
  }, pos.words, neg.words, .progress=.progress)
  scores.df <- data.frame(score=scores, text=sentences)
  return(scores.df)
}

test = ldply(modi,function(t) t$toDataFrame() )
result <- score.sentiment(test$text,pos.words,neg.words)
head(result)

summary(result$score)
hist(result$score,col ="red", main ="score of tweets", ylab = " count of tweets")

count(result$score)

library(ggplot2)
qplot(result$score,xlab = "Score of tweets")

##Results:
# high amount of neutral comments but almost equal number of positive and negative tweets.
# closely resembling a 50/50 opinion poll