#######################################################
####################Experiment 9#######################
#######################################################

install.packages("hunspell")
install.packages("janeaustenr")
install.packages("stringr")
install.packages("swirl")
install.packages("tidytext")
install.packages("textdata")

library(textdata)
library(tidytext)
sentiments
library(dplyr)
library(tidyr)
library(hunspell)
library(stringr)
library(janeaustenr)
library(ggplot2)
library(wordcloud)
#Getting sentitments
a <-  get_sentiments("afinn")
a

#Hunspell is used to check Typos, spell checks, 
words <- c("cat", "chetah", "lion")
correct <- hunspell_check(words)
print(correct)
hunspell_suggest(words[!correct])

bad <-  hunspell("spell checkers are not necessairy for the language ninijas!")
print(bad)

hunspell_suggest(bad[[1]])

#Gives the original word, the root word
words <-  c("love", "loving", "lovingly", "loved", "lover", "lovely")
hunspell_stem(words)
hunspell_analyze(words)

#Unnesting Tokens
text <- c("Because I could not stop for the death", "He kindly stopped for me", "The carriage held but just ourselves", "and  Immortality" )
text 
text_df <-  data_frame(line = 1:4, text = text)
text_df %>% unnest_tokens(word, text)




#Playing around with Jane Austen book
austen_books()
tidy_books <- austen_books() %>% group_by(book) %>%  mutate(linenumber = row_number(), chapter = cumsum(str_detect(text, regex("^chapter [\\divxlc]", ignore_case = T))))  %>%  ungroup() %>% unnest_tokens(word,text)
View(tidy_books)
nrc_joy <-  get_sentiments("nrc") %>%  filter(sentiment == "joy")
tidy_books %>%  filter(book  == "Emma") %>%  inner_join(nrc_joy) %>% count(word, sort = T)

jane_austen_sentiment <- tidy_books %>% inner_join(get_sentiments("bing")) %>% count(book, index = linenumber %/% 80, sentiment) %>% spread(sentiment, n, fill = 0) %>% mutate(sentiment = positive - negative)
View(jane_austen_sentiment)

#Playing around with Sherlock Data
sherlock_book <-  readRDS( "D:\\Vikraant\\M-Tech DS 2019-2021\\Sem 1\\R & Tableau\\humanitiesDataInR\\data\\ch09\\holmes_anno\\01_a_scandal_in_bohemia.Rds")
View(sherlock_book)



#GGPLOT , plotting the sentiments in the data
ggplot(jane_austen_sentiment, aes(index, sentiment, fill = book)) + geom_col(show.legend = F) + facet_wrap(~book, ncol = 2, scales = "free_x")


bing_word_counts <-  tidy_books %>%  inner_join(get_sentiments("bing")) %>% count(word, sentiment, sort=TRUE) %>% ungroup()


bing_word_counts %>%  group_by(sentiment) %>%  top_n(10) %>%  ungroup() %>%  mutate( word  = reorder(word, n) )  %>%  ggplot(aes(word, n, fill = sentiment)) + geom_col(show.legend = F)  +facet_wrap(~sentiment, scales = "free_y") + labs(y = "Contribn to senti", x = NULL) + coord_flip() 


#WORD CLOUD with stop words
tidy_books %>% count(word) %>%  with(wordcloud(word, n, max.words = 100))

#WOrd cloud without stop words
tidy_books %>%  anti_join(stop_words) %>%  count(word) %>%  with(wordcloud(word, n, random.order = F, max.words = 50, scale = c(5, 0.5)))


#Pride and Prejudice
PandP_sentences <- data_frame(text)

PandP_sentences= data_frame(text = prideprejudice) %>% unnest_tokens(sentence, text, token="sentences")
PandP_sentences$sentence[2]


austen_chapters = austen_books() %>% group_by(book) %>% unnest_tokens(chapter, text, token = "regex",
                                                                      pattern="Chapter|CHAPTER[\\divxlc]")

austen_chapters %>% group_by(book) %>% summarise(chapters= n())
