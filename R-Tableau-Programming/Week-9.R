install.packages("Scale")
install.packages("syuzhet")
install.packages("fivethirtyeight")
library(ggplot2)
library(lubridate)
library(Scale)
library(reshape2)
library(tm)
library(SnowballC)
library(wordcloud)
library(RColorBrewer)
library(stringr)
library(syuzhet)
library(dplyr)

library(tidytext)
library(hunspell)
library(tidyverse)
library(fivethirtyeight)
library(gridExtra)


text = readLines("WhatsApp Chat with Mtech DS unofficial.txt")

docs <- Corpus(VectorSource(text))

trans <- content_transformer(function(x,pattern) gsub(pattern," ",x))
docs <- tm_map(docs,trans,"/")
docs <- tm_map(docs,trans,"@")
docs <- tm_map(docs,trans,"\\|")
docs <- tm_map(docs,content_transformer(tolower))
docs <- tm_map(docs,removeNumbers)
docs <- tm_map(docs,removeWords,stopwords("en"))
docs <- tm_map(docs,removePunctuation)
docs <- tm_map(docs,stripWhitespace)
docs <- tm_map(docs,stemDocument)
docs <- tm_map(docs,trans,"Jaykrishna")
docs <- tm_map(docs,trans,"Joshi")
docs <- tm_map(docs,trans,"https")


dtm <- TermDocumentMatrix(docs)
mat <- as.matrix(dtm)
v <- sort(rowSums(mat),decreasing = T)

data <- data.frame(word=names(v),freq=v)
head(data,10)

set.seed(1056)
wordcloud(words=data$word,freq=data$freq,min.freq=1,max.words=200,random.order=F,rot.per=0.35,colors=brewer.pal(8,"Dark2"))

Sentiment <- get_nrc_sentiment(text)
head(Sentiment,10)

text <- cbind(text,Sentiment)

#count the sentiment words by category
TotalSentiment <- data.frame(colSums(text[,c(2:11)]))

names(TotalSentiment) <- "count"
TotalSentiment <- cbind("sentiment"=rownames(TotalSentiment),TotalSentiment)
rownames(TotalSentiment) <- NULL

#total sentiment score of all texts
ggplot(data = TotalSentiment,aes(x=sentiment,y=count))+geom_bar(aes(fill=sentiment),stat = "identity")+theme(legend.position = "none")+xlab("Sentiment")+ylab("Total Count")+ggtitle("Total Sentiment Score")

data(trump_twitter, package="fivethirtyeight")
str(trump_twitter)
(minDate = min(date(trump_twitter$created_at)))
(maxDate = max(date(trump_twitter$created_at)))

my_hunspell_stem = function(token){
  stem_token = hunspell_stem(token)[[1]]
  if(length(stem_token)==0)
    return(token)
  else
    return(stem_token[1])
}
vec_hunspell_stem = Vectorize(my_hunspell_stem,"token")
trump_token = trump_twitter %>% 
                mutate(text=str_replace_all(text,pattern=regex("(www|https?[^\\s]+)"),
                                            replacement="")) %>% 
  mutate(text=str_replace_all(text,pattern=regex("[[:digit:]]"),
                              replacement="")) %>%tidytext::unnest_tokens(tokens,text) %>%
  mutate(tokens = vec_hunspell_stem(tokens)) %>%
  filter(!(tokens %in% stop_words$word))

most_used_words = trump_token %>% 
  group_by(tokens) %>%
  summarise(n=n()) %>%
  ungroup() %>%
  arrange(desc(n))

sentimentdf = get_sentiments("afinn") %>% 
  mutate(word = vec_hunspell_stem(word)) %>%
  bind_rows(get_sentiments("afinn"))

trump_sentiment = trump_token %>% inner_join(sentimentdf, by=c("tokens"="word")) %>%
  rename(Score=value)

trump_full_text_sent = trump_sentiment %>% 
  group_by(id) %>%
  summarise(Score = sum(Score)) %>%
  ungroup() %>%
  inner_join(trump_twitter, by="id")
