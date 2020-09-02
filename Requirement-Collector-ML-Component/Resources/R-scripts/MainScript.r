

args <- commandArgs(trailingOnly = TRUE)
base_folder2 <- args[1]
trainingSetDirectory2 <- args[2]
testSetDirectory2  <- args[3]
simplifiedOracle2_path  <- args[4]
nameOfAttributeID2  <- args[5]
nameOfAttributeClass2  <- args[6]
nameOfAttributeText2  <- args[7]
oracleFolder2  <- args[8]

# @author sebastiano panichella

#install packages if not installed yet
print("We install packages if not installed yet")
if (!require(tm)){ install.packages("tm") }
if (!require(stringr)){ install.packages("stringr") } 
if (!require(stopwords)){ install.packages("stopwords") }
if (!require(slam)){ install.packages("slam") }
if (!require(snakecase)){ install.packages("snakecase") }
if (!require(data.table)){ install.packages("data.table") }
if (!require(XML)){ install.packages("XML") }

#load the libraries...
print("We load the libraries")
library(tm)
library(stringr)
library(stopwords)
library(slam)

base_folder <- "~/Desktop/Zurich-applied-Science/Collaborations/Marcela/eclipse/workspace/ML-pipeline/Resources/R-scripts/"

if(!is.na(base_folder2))
{
  base_folder<- base_folder2
  print("1) argument \"docs_location\" used in R by setwd() ")
}

setwd(base_folder)
print("base_folder:")
print(base_folder)

source("./utilities.R")
#path software artifacts
#trainingSetDirectory <- "./documents/1-use_cases"
#testSetDirectory <- "./documents/4-class_description"
trainingSetDirectory <- ".../training-set"
testSetDirectory <- ".../test-set"
simplifiedOracle_path <- ".../truth_set_ICSME2015-simplified.csv"


if( (!is.na(trainingSetDirectory2)) && (!is.na(testSetDirectory2)) )
{
  trainingSetDirectory<- paste(oracleFolder2,"/training-set",sep="")
  testSetDirectory<- paste(oracleFolder2,"/test-set",sep="")
  
  if(!is.na(nameOfAttributeText2) && nameOfAttributeText2=="req_specification")
    {
    trainingSetDirectory<- paste(oracleFolder2,"/training-set-Req-Specifications",sep="")
    testSetDirectory<- paste(oracleFolder2,"/test-set-Req-Specifications",sep="")
    }
  print("2) argument \"trainingSetDirectory\" given as argumet to the R script ")
  print("3) \"testSetDirectory\" given as argumet to the R script ")
  }

dir.create(trainingSetDirectory, showWarnings = FALSE, recursive = TRUE)
dir.create(testSetDirectory, showWarnings = FALSE, recursive = TRUE)

if(!is.na(simplifiedOracle2_path))
{
  simplifiedOracle_path <- simplifiedOracle2_path
  print("4) argument \"simplifiedOracle2_path\" given as argumet to the R script ")
}

#dir.create(simplifiedOracle_path, showWarnings = FALSE, recursive = TRUE)

if(length(args)==8)
{
  print("All fine with the arguments..")
#print("Reading oracle information from:")
#print(simplifiedOracle_path)
simplifiedOracle <- read.csv(simplifiedOracle_path)
print("")
print("FINISHED to read oracle information, first two lines of oracle:")
print(simplifiedOracle[1:2,])
print("...")
simplifiedOracle[[nameOfAttributeID2]] <- as.character(simplifiedOracle[[nameOfAttributeID2]])
#print("Finished changing format simplifiedOracle$id ")
simplifiedOracle[[nameOfAttributeClass2]] <- as.character(simplifiedOracle[[nameOfAttributeClass2]])
#print("Finished changing format simplifiedOracle$class ")
print("")
# creating folders with pre-processed documents (e.g., camel case splitting, etc.)
print("-> CREATING folders with pre-processed documents")
trainingSetDirectory_preprocessed <- paste(oracleFolder2,"/documents-preprocessed-",nameOfAttributeText2,"/trainingSetDirectory",sep="")
testSetDirectory_preprocessed <- paste(oracleFolder2,"/documents-preprocessed-",nameOfAttributeText2,"/testSetDirectory",sep="")

# files where the matrices of training and test sets will be stored with all oracle information
print("-> STORING files concerning the matrices of training and test sets will all oracle information in the last column")
tdm_full_trainingSet_with_oracle_info_path <- paste(oracleFolder2,"/documents-preprocessed-",nameOfAttributeText2,"/tdm_full_trainingSet_with_oracle_info.csv",sep="")
tdm_full_testSet_with_oracle_info_path <- paste(oracleFolder2,"/documents-preprocessed-",nameOfAttributeText2,"/tdm_full_testSet_with_oracle_info.csv",sep="")
tdm_full_with_oracle_info_path <- paste(oracleFolder2,"/documents-preprocessed-",nameOfAttributeText2,"/tdm_full_with_oracle_info.csv",sep="")

# we preprocess files
#pre_processing(trainingSetDirectory, trainingSetDirectory_preprocessed, ".txt")
#pre_processing(testSetDirectory, testSetDirectory_preprocessed, ".txt")
#-> check if the directory need to be cleaned before nex step
print("---> PREPROCESSING Training and Test Sets files ")
pre_processing(trainingSetDirectory, trainingSetDirectory_preprocessed)
pre_processing(testSetDirectory, testSetDirectory_preprocessed)

# directories to index
#print("directories with files to index")
directories <- c(trainingSetDirectory_preprocessed, testSetDirectory_preprocessed)

# the following command index the software artifacts
# and store this data in "tm" (it is a sparse matrix)
tdm <- build_tm_matrix(directories)
print("---> CREATING Sparse Term-by-Document-Matrix from Training and Test Sets files ")

# extract only the interesting part of the matrix
Training_files <- list.files(trainingSetDirectory, recursive=TRUE)
TestSet_files <- list.files(testSetDirectory, recursive=TRUE)

#we obtain the full term by document matrics
print("---> we obtain the full term by document matrics")
tdm_full <- as.matrix(tdm)
tdm_full<- t(tdm_full)
print("---> Created Non-Sparse Term-by-Document-Matrix from Training and Test Sets files ")

tdm_full_trainingSet <- tdm_full[Training_files,]
tdm_full_testSet <- tdm_full[TestSet_files,]

#FINAL PART: we finally add oracle information to the csv files
print("---FINAL PART: we add oracle information to the Term-by-Document-Matrix")
tdm_full_trainingSet_with_oracle_info<- as.data.frame(tdm_full_trainingSet)
tdm_full_testSet_with_oracle_info<- as.data.frame(tdm_full_testSet)

temp1<- rep("",length(tdm_full_trainingSet_with_oracle_info[,1]))
temp2<- rep("",length(tdm_full_testSet_with_oracle_info[,1]))

tdm_full_trainingSet_with_oracle_info<- cbind(tdm_full_trainingSet_with_oracle_info,temp1)
tdm_full_testSet_with_oracle_info<- cbind(tdm_full_testSet_with_oracle_info,temp2)

#we rename the last column in "oracle"
print("---> ADD column with \"oracle\" name")
colnames(tdm_full_trainingSet_with_oracle_info)[length(colnames(tdm_full_trainingSet_with_oracle_info))] <-"oracle"
colnames(tdm_full_testSet_with_oracle_info)[length(colnames(tdm_full_testSet_with_oracle_info))] <-"oracle"
tdm_full_trainingSet_with_oracle_info$oracle<- ""
tdm_full_testSet_with_oracle_info$oracle<- ""

#for each raw in training set we update the oracle information
print("---> UPDATING the oracle information for each raw in training set")
i<-1
rows_trainingSet<- rownames(tdm_full_trainingSet_with_oracle_info)
for(i in 1:length(rows_trainingSet)){
  pos<- which(simplifiedOracle==rows_trainingSet[i]) 
  tdm_full_trainingSet_with_oracle_info$oracle[i] <- simplifiedOracle[[nameOfAttributeClass2]][pos]
}

#for each raw in test set we update the oracle information
print("---> UPDATING the oracle information for each raw in test set")
i<-1
rows_testSet<- rownames(tdm_full_testSet_with_oracle_info)
for(i in 1:length(rows_testSet)){
  pos<- which(simplifiedOracle==rows_testSet[i]) 
  tdm_full_testSet_with_oracle_info$oracle[i] <- simplifiedOracle[[nameOfAttributeClass2]][pos]
}

print("WRITING the CSV files (uuseful for WEKA) of training and test sets with the oracle information")
write.csv(tdm_full_trainingSet_with_oracle_info,tdm_full_trainingSet_with_oracle_info_path)
write.csv(tdm_full_testSet_with_oracle_info,tdm_full_testSet_with_oracle_info_path)

tdm_full_with_oracle_info<- rbind(tdm_full_trainingSet_with_oracle_info,tdm_full_testSet_with_oracle_info)
write.csv(tdm_full_with_oracle_info,tdm_full_with_oracle_info_path)
print("DONE Rscript analysis")
}
if(length(args)!=8)
{
  print("Error: some problems with the arguments of the TbD analysis")
}

classes<- unique(tdm_full_with_oracle_info$oracle)
#print(classes)
paths<-classes #temporary
i<-1
for(i in 1:length(classes))
  {
    replacement <- paste("_",classes[i],".csv",sep="")
    paths[i]<- str_replace(tdm_full_with_oracle_info_path,".csv",replacement)
    temp<- tdm_full_with_oracle_info
    temp[ which(temp$oracle!= classes[i]), "oracle"] = "no"
    write.csv(temp, paths[i])
    }


