0.	Use the Processed Video Game dataset created by the TA or clean up the raw dataset yourself! 

1.	Compute the covariance matrix for each pair of the following attributes: 
    Critic_Score
    User_Score
    NA_Sales
    JP_Sales
    Global_Sales
    Next, compute the correlations for each of the pairs of attributes. Interpret the statistical findings! 

2.	Create scatter plot for the attributes Critic_score/Critic_Count and User_Score/Global_Sales Interpret the two scatter plots! 

3.	Create histograms for Platform and User_Count attributes for High, Medium and Low GS_category classes; interpret the obtained histograms. 

4.	Create box plots for the User_Score/Critic_Score attributes for the instances of the 3 GS_category class— low/medium/high — and a fourth box plot for all instances in the dataset. Interpret and compare the box plots for each attribute! 

5.	Create supervised scatter plots for the following 3 pairs of attributes using the GS_category as a class variable: Critic Score/NA_Sales, NA_Sales/User Score and Critic Score/User Score. Use different colors for the class variable. Interpret the obtained plots; in particular, address what can be said about the difficulty in predicting the Global Sales Target and the distribution of the instances of the three classes. 

6.	Create 2 density plots for the instances of the 3 GS_category classes in the Critic_Score/User_score space. Compare the density plots! 

7.	Create a table which reports the frequency of associations of the 12 genres with the three classes of the GS_Category attribute. Create histograms for the Global_Sales attribute for the instances of each of the 12 genres. Interpret the table and the histograms you created. 

8.	Create a new dataset Z-Processed Video Games from the Processed Video Games dataset by transforming the Year, Critic_Score, Critic_Count, User_Score, User_Count attributes into z-scores. Fit a linear model that predicts the values of the Global_Sales attribute using the 5 z-scored, continuous attributes as the independent variables. Report the R2 of the linear model and the coefficients of each attribute in the obtained regression function. What do the obtained coefficients tell you about the importance of each attribute for predicting a successful game? 

9.	Create 3 decision tree models with 20 or less nodes for the dataset (both intermediate and leaf nodes count; do not submit models with more than 20 nodes!); use the GS_Category attribute as the class variable, and use the remaining attributes of the dataset excluding attribute Global_Sales of the dataset when building the decision tree model. Explain how the 3 decision tree models were obtained! Report the training accuracy and the testing accuracy of the submitted decision trees. Interpret the learnt decision tree. What does it tell you about the importance of the chosen attributes for the classification problem? 

10.	Write a conclusion (at most 13 sentences!) summarizing the most important findings of this task; in particular, address the findings obtained related to predicting a successful game (high global sales) using attributes 1-14. If possible, write about which attributes seem useful for predicting high video game sales and what you as an individual can learn from this dataset!

