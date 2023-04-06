metn="China has launched military drills in response to a much-anticipated meeting between Taiwan's president Tsai Ing-wen and US House Speaker Kevin McCarthy.

They met in California on Wednesday, a week after President Tsai was feted in New York with a leadership award.

Ms Tsai hailed their strong and unique partnership, and Mr McCarthy said that arms sales to Taiwan must continue.

Beijing, in turn, has vowed a resolute response and sent warships into the waters around the self-governed island.

Taiwan, it appears, is caught in the middle of a dangerous love triangle.

The timing of Ms Tsai's visit is hardly a coincidence. In the US there is deep and growing hostility to China. And this is driving ever more open displays of support for Taiwan, with Democrats and Republicans competing to out-do each other.

It's a big reason former House Speaker Nancy Pelosi was so keen on landing in Taipei last summer, despite the fact that it set off a furious reaction from China. The self-governed island, which Beijing claims as part of its territory, is arguably the biggest flashpoint between the US and China.

I was personally very opposed to the Pelosi visit, says professor William Stanton, former director of the American Institute in Taiwan. For a high-level politician from the US to make a visit to the island was just poking China without much reward. And the consequences were quite scary.

Chinese missiles flew over the island as Beijing made blood-curdling threats. In capitals around the region governments began talking seriously about the timetable for a Chinese invasion of Taiwan.

Despite that, as soon as he was elected house speaker this January, Mr McCarthy, a Republican, declared his intention to follow Ms Pelosi's example. But President Tsai decided that was not a good idea, Prof Stanton says.

I think it was quite clear that Kevin McCarthy wanted to pull a Pelosi, he says. But Tsai Ing-wen said, 'no thank you, how about we have tea together in California instead'.

Why young people in Taiwan are learning to fight
Defiant Taiwan's identity is moving away from China
President Tsai may not want another contentious visit by a US leader to Taiwan just yet - but she also needs to show China that it will not succeed in shutting down contact between a democratically-elected government in Taipei and its most powerful ally in Washington.

And so, the meeting in California. Mr McCarthy has far from downplayed it, calling the meeting bipartisan, despite China's warning that the US was playing with fire on the Taiwan question.

Afterwards the White House said there was no need for Beijing to overreact to the meeting.

This so-called transit diplomacy is crucial for Taiwan, says Wen-Ti Sung, a political scientist at the Australian National University.

Over the years, China has successfully poached many of Taiwan's formal allies, whittling down the number of governments that recognise Taipei to just 13.

These international visits match Taiwan society's needs for international recognition, Mr Sung says. When there's an absence of international recognition, these other proxy indicators of international support are important to [the] Taiwanese."
library("tm")
library("SnowballC")
library("wordcloud")
library("RColorBrewer")
library("syuzhet")
library("ggplot2")
docs <- Corpus(VectorSource(metn))
toSpace <- content_transformer(function (x , pattern ) gsub(pattern, " ", x))
docs <- tm_map(docs, toSpace, "/")
docs <- tm_map(docs, toSpace, "@")
docs <- tm_map(docs, toSpace, "\\|")
# Convert the text to lower case
docs <- tm_map(docs, content_transformer(tolower))
# Remove numbers
docs <- tm_map(docs, removeNumbers)
# Remove english common stopwords
docs <- tm_map(docs, removeWords, stopwords("english"))
# Remove your own stop word
# specify your stopwords as a character vector
docs <- tm_map(docs, removeWords, c("video", "foto")) 
# Remove punctuations
docs <- tm_map(docs, removePunctuation)
# Eliminate extra white spaces
docs <- tm_map(docs, stripWhitespace)
# Text stemming
# docs <- tm_map(docs, stemDocument)
dtm <- TermDocumentMatrix(docs)
m <- as.matrix(dtm)
v <- sort(rowSums(m),decreasing=TRUE)
d <- data.frame(word = names(v),freq=v)
head(d, 10)
set.seed(1234)
wordcloud(words = d$word, freq = d$freq, min.freq = 1,
          max.words=200, random.order=FALSE, rot.per=0.35, 
          colors=brewer.pal(8, "Dark2"))

syuzhet_vector <- get_sentiment(metn, method="syuzhet")
# see the first row of the vector
head(syuzhet_vector)
# see summary statistics of the vector
summary(syuzhet_vector)
