# Requirements-Collector: Automating Requirements Specification from Elicitation Sessions and User Feedback

Requirements-Collector: (Automating Requirements Specification from Elicitation Sessions and User Feedback) Tool - Version 1.0

#### Authors: Sebastiano Panichella and Marcela Ruiz

### Tool description:

*In  the  context  of  digital  transformation,  speeding up  the  time-to-market  of  high-quality  software  products  is  a big  challenge.  Software  quality  correlates  with  the  success  of requirements engineering (RE) sessions and the ability to collect feedback  from  end-users  in  an  efficient,  dynamic  way.  Thus, software  analysts  are  tasked  to  collect  all  relevant  material  of RE  sessions  and  user  feedback,  usually  specified  on  written notes,   flip   charts,   pictures,   and   (mobile   apps)   user   reviews. Afterwards comprehensible requirements need to be specified forsoftware implementation and testing. These activities are mostly performed manually, which causes process delays; and software quality attributes like reliability, usability, comprehensibility, etc., are diminished causing software devaluation. This paper presentsthe design of the Requirements-Collector tool, for automating the tasks  of  requirements  specification  and  user  feedback  analysis. The proposed tool involves computational mechanisms to enablethe  automatic  classification  of  requirements  discussed  in  REmeetings   (stored   in   form   of   audio   recordings)   and   textual feedback  in  form  of  user  reviews.  The  requirements  collectortool  has  the  potential  to  renovate  the  role  of  software  analysts,which can experience substantial reduction of manual tasks, moreefficient communication, dedication to more analytical tasks, andassurance  of  software  quality  from  conception  phases.  Results of  this  work  have  shown  that  requirements  collector  is  able  to automatically  exploits  machine  and  deep-learning  strategies  toclassify RE specifications and user review feedback with reliable accuracy*.

**Requirement-Collector Context:**
![](https://github.com/spanichella/Requirement-Collector-tool/blob/master/Pipeline_AutomatedRE-RE20-P%26D.png)

### Description of the content of folder "Requirement-Collector-ML-Component":

#### License
This program is a free software you can redistribute it under the terms of the GNU Public License
as published by the Free Software Fundation either version 2 of the License, or (at your option)
any later version.

#### Get started with the *"Machine-Learning-classifier"* component of Requirement-Collector
Please clone this repository and copy the content of the folder **"Requirement-Collector-ML-Component"** in a local folder of your choice.
Inside this folder you find the 
  - The jar file ***Requirement-Collector-ML-Component-1.0.jar***  of the *"Requirement-Collector-ML-Component"*, 
  - The folder ***"Resources"*** containing 
      - the folder ***R-scripts*** all required R executable files for enabling the automated classification of requirements  specification  from Requirement:
        meetings transcripts and  user  feedback  in for of user reviews. 
           - *utilities.R*
           - *Script-to-create-test-dataset.r*
           - *Script-to-create-test-dataset-Req-Specifications.r*
           - *MainScript.r*
      - Example of data are provided to experiment with the automated classification of Audio Transcripts of Requirement meetings as well 
        as the automated classification of user reviews feedback:
          - the folder ***Reviews-Dataset***, we explain the content of this folder later.
          - the folder ***RE-meeting-Transcripts***, we explain the content of this folder later.

**Java and R-scripts PRE-REQUISITIES**
The command line tool ***Requirement-Collector-ML-Component-1.0.jar*** requires
  - *java version "1.8.0_211"*
  - and the following R *tm, stringr, stopwords, slam, snakecase, data.table, XML, dplyr* installed

Thus, as ***pre-requisities it is required to verify that*** under the R environment, following R code does not generate errors, and that all required packages are installed:
```
#install packages if not installed yet
print("We install packages if not installed yet")
if (!require(tm)){ install.packages("tm") }
if (!require(stringr)){ install.packages("stringr") } 
if (!require(stopwords)){ install.packages("stopwords") }
if (!require(slam)){ install.packages("slam") }
if (!require(snakecase)){ install.packages("snakecase") }
if (!require(data.table)){ install.packages("data.table") }
if (!require(XML)){ install.packages("XML") }
if (!require(dplyr)){ install.packages("dplyr") } 
```

***Another requirement is to update the location XML configuration files shared as example in the specific folders***:
          - the folder ***Reviews-Dataset***, we explain the content of this folder later.
          - the folder ***RE-meeting-Transcripts***, we explain the content of this folder later.
Then run Requirement-Collector-ML-Component-1.0.jar as described later.

### TO RUN THE TOOL:

**Demonstration Examples (CONFIG FILES, Command LINE TOOL examples):**
Requirement-Collector-ML-Component-1.0.jar tool accepts in input *xml configuration files* for classifying requirement specification from user reviews and transcripts. 

***In the case of user review analysis the *xml configuration files* have the following structure:***

NOTE: The followin examples of config files are customized for the example of data shared in this repository

1) Config File "ORACLE_AND_TbD_ANALYSIS-REVIEWS.xml" - needed to create all relevant data for the ML analysis
```
<?xml version="1.0"?>
<company>
	<ADSORB id="1">
		# path where R scripts are located
		<docs_location> <LOCAL PATH TO REPLACE>/Resources/R-scripts/</docs_location>
		<pathRScriptOracle> <LOCAL PATH TO REPLACE>/Resources/R-scripts/Script-to-create-test-dataset.r</pathRScriptOracle>
		# path where oracle is located
		<baseFolder> <LOCAL PATH TO REPLACE>/Resources/Reviews-Dataset</baseFolder>
		# path oracle
		<oracle_path> <LOCAL PATH TO REPLACE>/Resources/Reviews-Dataset/truth_set_ICSME2015.csv</oracle_path>
		# possible values "User Reviews" or "Requirement Specifications"
		<dataType>User Reviews</dataType>
		# possible values "id"
		<nameOfAttributeID>id</nameOfAttributeID>
		# possible values "review" and "req_specification"
		<nameOfAttributeText>review</nameOfAttributeText>
		# possible values "class"
		<nameOfAttributeClass>class</nameOfAttributeClass>
		<pathTbDRScript> <LOCAL PATH TO REPLACE>/Resources/R-scripts/MainScript.r</pathTbDRScript>
		#path where training set files will be created
		<documentsTrainingSet> <LOCAL PATH TO REPLACE>/Resources/Reviews-Dataset/training-set</documentsTrainingSet>
		#path where test set files will be created
		<documentsTestSet> <LOCAL PATH TO REPLACE>/Resources/Reviews-Dataset/test-set</documentsTestSet>
		#path where simplified Oracle will be created
		<simplifiedOracle_path> <LOCAL PATH TO REPLACE>/Resources/Reviews-Dataset/truth_set-simplified.csv</simplifiedOracle_path>
	</ADSORB>
</company>
```
1) Config File "ML_ANALYSIS-REVIEWS.xml" - needed to performing the ML analysis
```
<?xml version="1.0"?>
<company>
	<ADSORB id="1">
		# possible values "Training_and_test_set" (traiing and test set specified) and "10-fold" (whole dataset specified)
		<strategy>10-fold</strategy>
		#path where the training set file was created
		<pathTrainingSet> <LOCAL PATH TO REPLACE>/Resources/Reviews-Dataset/documents-preprocessed-review/tdm_full_trainingSet_with_oracle_info.csv</pathTrainingSet>
		#path where the test set file was created
		<pathTestSet> <LOCAL PATH TO REPLACE>/Resources/Reviews-Dataset/documents-preprocessed-review/tdm_full_testSet_with_oracle_info.csv</pathTestSet>
		#path where the model (pathModel) will be created
		<pathModel> <LOCAL PATH TO REPLACE>/Resources/Reviews-Dataset/documents-preprocessed-review/ML-method.model</pathModel>
		#path whole dataset (for 10-fold validation)
		<pathWholeDataset> <LOCAL PATH TO REPLACE>/Resources/Reviews-Dataset/documents-preprocessed-review/tdm_full_with_oracle_info_information giving.csv</pathWholeDataset>
		# ML model to experiment, possible values: "J48", "PART", "NaiveBayes",  "IBk", "OneR", "SMO", "Logistic", "AdaBoostM1", "LogitBoost", "DecisionStump", "LinearRegression", "RegressionByDiscretization"
		<machineLearningModel>J48</machineLearningModel>
		#path where the results of the prediction  will be stored
		<pathResultsPrediction> <LOCAL PATH TO REPLACE>/Resources/Reviews-Dataset/documents-preprocessed-review/resultsPrediction.txt</pathResultsPrediction>
	</ADSORB>
</company>

```

Requirement-Collector-ML-Component-1.0.jar classify the user review feedback and RE meeting specification according to relevant categories.  

Here we provide a running example from command Line:

Running example for Unix/Linux/MacOS systems:
java -classpath <TO BE COMPLETED>

where:
  - [MYPATH] is the path in which the ...  
  - <TO BE COMPLETED> 
  - <TO BE COMPLETED>

**Demonstration Video:**

## References

[1] <TO BE COMPLETED>
 DOI: <TO BE COMPLETED>
  
[2] <TO BE COMPLETED>
 DOI: <TO BE COMPLETED>

