#install.packages("RColorBrewer")
#install.packages("tm")
#install.packages("wordcloud")
#install.packages('base64enc')
#install.packages('ROAuth')
#install.packages('plyr')
#install.packages('stringr')
#install.packages('twitteR')

library(httk)
library(httpuv)
library(RColorBrewer)
library(wordcloud)
library(tm)
library(twitteR)
library(ROAuth)
library(plyr)
library(stringr)
library(base64enc)

requestURL <- "https://api.twitter.com/oauth/request_token"
accessURL <- "https://api.twitter.com/oauth/access_token"
authURL <- "https://api.twitter.com/oauth/authorize"

consumerKey = ""
consumerSecret = ""
accessToken = ""
accessSecret = "6k"

options(httr_oauth_cache=T)
setup_twitter_oauth(consumerKey,consumerSecret,accessToken,accessSecret)

cricket = searchTwitter("cricket",n=3000,lang = NULL)

modi = searchTwitteR("modi",n=3000,lang = "en")
## twitter authorization complete
