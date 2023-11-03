library(tidyverse)
library(dplyr)

#Reading CSV data
GCB78 <- read.csv("GCB78.csv")
  GCB78 <- mutate(GCB78, wid = 1)
GCB87 <- read.csv("GCB87.csv")
  GCB87 <- mutate(GCB87, wid = 2)
GCB91 <- read.csv("GCB91.csv")
  GCB91 <- mutate(GCB91, wid = 3)
GCB92 <- read.csv("GCB92.csv")
  GCB92 <- mutate(GCB92, wid = 4)
GCB93 <- read.csv("GCB93.csv")
  GCB93 <- mutate(GCB93, wid = 5)
GCB98 <- read.csv("GCB98.csv")
  GCB98 <- mutate(GCB98, wid = 6)
GCB99 <- read.csv("GCB99.csv")
  GCB99 <- mutate(GCB99, wid = 7)
GCB102 <- read.csv("GCB102.csv")
  GCB102 <- mutate(GCB102, wid = 8)
GCB115 <- read.csv("GCB116.csv")
  GCB115 <- mutate(GCB115, wid = 9)
GCB116 <- read.csv("GCB116.csv")
  GCB116 <- mutate(GCB116, wid = 10)
GCB121 <- read.csv("GCB121.csv")
  GCB121 <- mutate(GCB121, wid = 11)
GCB124 <- read.csv("GCB124.csv")
  GCB124 <- mutate(GCB124, wid = 12)
GCB125 <- read.csv("GCB125.csv")
  GCB125 <- mutate(GCB125, wid = 13)
GCB127 <- read.csv("GCB127.csv")
  GCB127 <- mutate(GCB127, wid = 14)
GCB131 <- read.csv("GCB131.csv")
  GCB131 <- mutate(GCB131, wid = 15)
GCB132 <- read.csv("GCB132.csv")
  GCB132 <- mutate(GCB132, wid = 16)
GCB133 <- read.csv("GCB133.csv")
  GCB133 <- mutate(GCB133, wid = 17)
GCB134 <- read.csv("GCB134.csv")
  GCB134 <- mutate(GCB134, wid = 18)
GCB139 <- read.csv("GCB139.csv")
  GCB139 <- mutate(GCB139, wid = 19)
GCB143 <- read.csv("GCB143.csv")
  GCB143 <- mutate(GCB143, wid = 20)
GCB145 <- read.csv("GCB145.csv")
  GCB145 <- mutate(GCB145, wid = 21)
GCB146 <- read.csv("GCB146.csv")
  GCB146 <- mutate(GCB146, wid = 22)
GCB151 <- read.csv("GCB151.csv")
  GCB151 <- mutate(GCB151, wid = 23)



#Merge into one dataframe
Briand <- do.call("rbind", list(GCB78,
                                GCB87,
                                GCB91,
                                GCB92,
                                GCB93,
                                GCB98,
                                GCB99, 
                                GCB102,
                                GCB115,
                                GCB116,
                                GCB121,
                                GCB124,
                                GCB125,
                                GCB127,
                                GCB131,
                                GCB132,
                                GCB133,
                                GCB134,
                                GCB139,
                                GCB143,
                                GCB145,
                                GCB146,
                                GCB151))

#Cleaning data by including only necessary columns
Briand <- data.frame("wid" = Briand$wid, 
                       "block_type" = Briand$block_type, 
                       "condition" = Briand$condition,
                       "target_present" = Briand$target_present, 
                       "cue_valid" = Briand$cue_valid, 
                       "correct" = Briand$correct,
                       "rt" = Briand$rt, 
                       "practicing" = Briand$practicing)

#Removing NA values from Briand to make Briand
Briand <- na.omit(Briand)                      

#Removing practice trials and including only rows that have target-response reaction times
  #rather than cue-response reaction times.
Briand <- filter(Briand, practicing != "TRUE" & practicing != "true",
                    rt != "null")

#Removing blocks from Briand
Briand[Briand == "false"] <- "FALSE"
Briand[Briand == "true"] <- "TRUE"

#Changing cue_valid so that validity is identified by "valid" and "invalid".
Briand["cue_valid"][Briand["cue_valid"] == "TRUE"] <- "valid"
Briand["cue_valid"][Briand["cue_valid"] == "FALSE"] <- "invalid"

#Changing target_present so that target presence is identified by "present" and "absent". 
Briand["target_present"][Briand["target_present"] == "TRUE"] <- "present"
Briand["target_present"][Briand["target_present"] == "FALSE"] <- "absent"

#Setting variable rt to numeric type. 
Briand <- transform(Briand,rt = as.numeric(rt))

#Save cleaned data file, BriandCleaned
write.csv(Briand, "Briand_dataset.csv")
