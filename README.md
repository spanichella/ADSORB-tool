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
          - the folder ***Reviews-Dataset***
          - the folder ***RE-meeting-Transcripts***

>The command line tool uses the following open-source R libraries:
> >  tm, stringr, stopwords, slam, snakecase, data.table, XML, dplyr

Thus, as **pre-requisities it is required to verify that** under the R environment, following R code does not generate errors, and all required packages are installed:
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

You can find the needed R scripts files for running the tool in the "/lib" folder contained in the ADSORB-tool.zip file

Please update the location of relevant files in the ADSORB configuration files shared as example in the ADSORB-tool folder. 
Then run ADSORB as described later.

ADSORB tool accepts in input xml files having the structure showed
in the following example:

<EXAMPLE TO BE ADDED>

ADSORB classify the user review feedback and RE meeting specification according to relevant categories.  


### TO RUN THE TOOL:
Here we provide a running example from command Line:

Running example for Unix/Linux/MacOS systems:
java -classpath <TO BE COMPLETED>

where:
  - [MYPATH] is the path in which the ...  
  - <TO BE COMPLETED> 
  - <TO BE COMPLETED>
  
## References

[1] <TO BE COMPLETED>
 DOI: <TO BE COMPLETED>
  
[2] <TO BE COMPLETED>
 DOI: <TO BE COMPLETED>

