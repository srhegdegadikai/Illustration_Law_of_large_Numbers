Law of Large Numbers
================
Suhas Hegde
11/2/2017

Law of Large Numbers (LLN) states that "the sample average converges in probability towards the expected value as the size of the sample increases." This can be illustrated using for the lambda distribution. The lambda distribution has a heretical mean of 1/lambda. So according to "LLN", as our sample size is increased the mean derived should approach the theoretical mean.

The following R-shiny application lets the users play with different sample sizes and to see the effect on the sample mean. The application can be run using the following two lines of code in your "Rstudio" console.

    # checks if the "shiny" package has been installed, if not installs it and loads it up
    if (!require("shiny")) install.packages("shiny")

    # run the application 
    runGist("7ff89bc3858de914f5514a7dc1a9d32c")

If you don't have R and Rstudio installed on your machine, you can go to the link below and use the application.

[LLN-shiny-app](https://suhas-hegde.shinyapps.io/law_of_large_numbers/)
