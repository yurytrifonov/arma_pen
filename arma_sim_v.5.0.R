############################################
### This R file provides simulated data ####
### analysis for the penalty regressions ###
###       with the nonlinear OLS         ###
############################################
####      The code is developed by      ####
####      @Juri Trifonov, NRU HSE       ####
############################################

########################################
#          Libraries required
########################################
install.packages("ncvreg")
install.packages('glmnet')
install.packages('gena')
install.packages('matrixcalc')
install.packages('psych')
install.packages('R.itils')
install.packages('lubridate')

library('ncvreg')
library('glmnet')
library('gena')
library('matrixcalc')
library('psych')
library('R.utils')
library('dplyr')
library('lubridate')




options(scipen = 999)                   # disable scientific notation

######################################################################
######################################################################
#                              !!!NB!!!
#         PLEASE, PROVIDE THE PATH TO THE APPROPRIATE SOURCE
#                  FILE WITH FUNCTIONS ON YOUR PC
#                    ↓↓↓↓↓↓↓↓↓↓↓HERE↓↓↓↓↓↓↓↓↓↓↓
source("/Users/yutrifonov/Desktop/PhD/RA_Sofya/ARMA/arma_func_v.5.0.R")
#######################################################################
#######################################################################

####### ↓↓↓ SIMULATION PARAMETERS SHOULD BE DEFINED HERE ↓↓↓ ##########


# TRUE VALUES OF PARAMETERS FOR DGP #
s <- 1000          # define the number of simulations
n <- 1000          # define the sample size
b <- 0             # true value of b
pi <- 0.4          # true value of pi
iter <- 20         # number of iterations in the CD algorithm

######## ^^^ SIMULATION PARAMETERS SHOULD BE DEFINED HERE ^^^ ##########
{
  {
  ### 1. Creating objects for storing the values ###
  
  seed_vec <- rep(NA, s)                     # prepare the vector for storing seed values
  total_list_lasso <- vector(mode = 'list',  # prepare the list for storing 
                             length = s)     # total frames for all lambdas
  total_list_mcp <- vector(mode = 'list',    # prepare the list for storing 
                           length = s)       # total frames for all lambdas
  total_list_scad <- vector(mode = 'list',   # prepare the list for storing 
                            length = s)      # total frames for all lambdas
  total_list_alasso <- vector(mode = 'list', # prepare the list for storing 
                              length = s)    # total frames for all lambdas
  
  
    optimal_vec_lasso <- matrix(rep(NA, 6*s), nrow = s)  # prepare the matrix for storing optimal estimates (lasso)
    optimal_vec_mcp <- matrix(rep(NA, 6*s), nrow = s)    # prepare the matrix for storing optimal estimates (mcp)
    optimal_vec_scad <- matrix(rep(NA, 6*s), nrow = s)   # prepare the matrix for storing optimal estimates (scad)
    optimal_vec_alasso <- matrix(rep(NA, 6*s), nrow = s) # prepare the matrix for storing optimal estimates (alasso)
}

pb <- txtProgressBar(min = 0,      # Minimum value of the progress bar
                     max = s,      # Maximum value of the progress bar
                     style = 3,    # Progress bar style (also available style = 1 and style = 2)
                     width = s,    # Progress bar width. Defaults to getOption("width")
                     char = "=")   # Character used to create the bar

init <- numeric(s)
end <- numeric(s)

for (j in 1:s)
{
  init[j] <- Sys.time()
  #print('################################')
  #print('################################')
  #print(paste0(' SIMULATION NUMBER:', j, ' OUT OF ', s))
  #print(paste0(' SIMULATION NUMBER:', j, ' OUT OF ', s))
  #print(paste0(' SIMULATION NUMBER:', j, ' OUT OF ', s))
  #print('################################')
  #print('################################')
  
  
  
  seed <- (18 - 1) * 1000 + j
  
  seed_vec[j] <- seed
  set.seed(seed)      # define the seed value
  
  
  ### 2. Generate the data according to the DGP ###
  data <- arma_sim(n = n,
                   b = b,
                   pi = pi)
  
  ### 3.          Estimate the model            ###

  model_lasso <- arma_est(data = data, iter = iter, penalty = 'lasso')
  model_mcp <- arma_est(data = data, iter = iter, penalty = 'MCP')
  model_scad <- arma_est(data = data, iter = iter, penalty = 'SCAD')
  model_alasso <- arma_est(data = data, iter = iter, penalty = 'alasso')
  
  
  total_list_lasso[[j]] <- model_lasso$total_frame[-length(model_lasso$total_frame)]
  total_list_mcp[[j]] <- model_mcp$total_frame[-length(model_mcp$total_frame)]
  total_list_scad[[j]] <- model_scad$total_frame[-length(model_scad$total_frame)]
  total_list_alasso[[j]] <- model_alasso$total_frame[-length(model_alasso$total_frame)]
  
  optimal_vec_lasso[j, ] <- as.vector(as.numeric(as.character(unlist(model_lasso$optimal_frame))))
  optimal_vec_mcp[j, ] <- as.vector(as.numeric(as.character(unlist(model_mcp$optimal_frame))))
  optimal_vec_scad[j, ] <- as.vector(as.numeric(as.character(unlist(model_scad$optimal_frame))))
  optimal_vec_alasso[j, ] <- as.vector(as.numeric(as.character(unlist(model_alasso$optimal_frame))))
  
  optimal_vec_lasso[is.na(optimal_vec_lasso)] <- 'NOIND'
  optimal_vec_mcp[is.na(optimal_vec_mcp)] <- 'NOIND'
  optimal_vec_scad[is.na(optimal_vec_scad)] <- 'NOIND'
  optimal_vec_alasso[is.na(optimal_vec_alasso)] <- 'NOIND'
  if (j == s)
  {
      optimal_vec_lasso <- as.data.frame(optimal_vec_lasso)
      optimal_vec_mcp <- as.data.frame(optimal_vec_mcp)
      optimal_vec_scad <- as.data.frame(optimal_vec_scad)
      optimal_vec_alasso <- as.data.frame(optimal_vec_alasso)
      
      names(optimal_vec_lasso) <- c('bic', 'lambda', 'beta', 'pi', 'lnL', 'DF')
      names(optimal_vec_mcp) <- c('bic', 'lambda', 'beta', 'pi', 'lnL', 'DF')
      names(optimal_vec_scad) <- c('bic', 'lambda', 'beta', 'pi', 'lnL', 'DF')
      names(optimal_vec_alasso) <- c('bic', 'lambda', 'beta', 'pi', 'lnL', 'DF')
      
    optimal_vec_lasso <- optimal_vec_lasso[-length(optimal_vec_lasso)]
    optimal_vec_mcp <- optimal_vec_mcp[-length(optimal_vec_mcp)]
    optimal_vec_scad <- optimal_vec_scad[-length(optimal_vec_scad)]
    optimal_vec_alasso <- optimal_vec_alasso[-length(optimal_vec_alasso)]
    
  }
  
  end[j] <- Sys.time()
  
  setTxtProgressBar(pb, j)
  time <- round(seconds_to_period(sum(end - init)), 0)
  
  # Estimated remaining time based on the
  # mean time that took to run the previous iterations
  est <- s * (mean(end[end != 0] - init[init != 0])) - time
  remainining <- round(seconds_to_period(est), 0)
  
  cat(paste(" // Execution time:", time,
            " // Estimated time remaining:", remainining,
            " // SIMULATION NUMBER:", j), "")
  }

close(pb)
}
 
total_list_lasso
total_list_mcp
total_list_scad
total_list_alasso

optimal_vec_lasso
optimal_vec_mcp
optimal_vec_scad
optimal_vec_alasso

accuracy_lasso <- sum(optimal_vec_lasso$beta == 0) / length(optimal_vec_lasso$beta)
accuracy_mcp <- sum(optimal_vec_mcp$beta == 0) / length(optimal_vec_mcp$beta)
accuracy_scad <- sum(optimal_vec_scad$beta == 0) / length(optimal_vec_scad$beta)

accuracy_alasso <- sum(optimal_vec_alasso$beta == 0) / length(optimal_vec_alasso$beta)


accuracy_lasso
accuracy_mcp
accuracy_scad
accuracy_alasso
seed_vec

