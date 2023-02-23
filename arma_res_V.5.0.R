############################################
### This R file provides results of the ####
### simulated data analysis for the     ####
###    penalty regressions with the     ####
###            nonlinear OLS            ####
############################################
####      The code is developed by      ####
####      @Juri Trifonov, NRU HSE       ####
############################################


###############################################################################
###############################################################################
#                              !!!NB!!!
#         PLEASE, PROVIDE THE PATH TO THE APPROPRIATE SOURCE
#                  FILE WITH FUNCTIONS ON YOUR PC
#                    ↓↓↓↓↓↓↓↓↓↓↓HERE↓↓↓↓↓↓↓↓↓↓↓
load('/Users/yutrifonov/Desktop/PhD/RA_Sofya/ARMA/Results/des_full.RData')
###############################################################################
###############################################################################

###############################################
# Design 1: b = 0, pi = 0.4, n = 1000
###############################################
# vector containing seed values for
# every simulation
# s, where s = {1:1000}:
seed_vec_1

# Lists containing theta_hat for every lambda
# for every simulation s, where s = {1, 1000}:
theta_hat_lasso_1
theta_hat_mcp_1
theta_hat_scad_1
theta_hat_alasso_1

# data frame containing theta_hat_max:
# optimal estimates for every simulation
# s, where s = {1, 1000}:
theta_hat_max_lasso_1
theta_hat_max_mcp_1
theta_hat_max_scad_1
theta_hat_max_alasso_1

# vector containing the percent of cases when 
# beta_hat = 0 (accuracy)
accuracy_lasso_1
accuracy_mcp_1
accuracy_scad_1
accuracy_alasso_1

##################################################
# Design 2: b = 10, pi = 0.4, n = 1000
##################################################
# vector containing seed values for
# every simulation
# s, where s = {1, 1000}:
seed_vec_2

# Lists contaning theta_hat for every lambda
# for every simulation s, where s = {1, 1000}:
theta_hat_lasso_2
theta_hat_mcp_2
theta_hat_scad_2
theta_hat_alasso_2

# data frame containing theta_hat_max:
# optimal estimates for every simulation
# s, where s = {1, 1000}:
theta_hat_max_lasso_2
theta_hat_max_mcp_2
theta_hat_max_scad_2
theta_hat_max_alasso_2

# vector containing the percent of cases when 
# beta_hat = 0 (accuracy)
accuracy_lasso_2
accuracy_mcp_2
accuracy_scad_2
accuracy_alasso_2

##################################################
# Design 3: b = -4, pi = 0.4, n = 1000
##################################################
# vector containing seed values for
# every simulation
# s, where s = {1, 1000}:
seed_vec_3

# Lists contaning theta_hat for every lambda
# for every simulation s, where s = {1, 1000}:
theta_hat_lasso_3
theta_hat_mcp_3
theta_hat_scad_3
theta_hat_alasso_3

# data frame containing theta_hat_max:
# optimal estimates for every simulation
# s, where s = {1, 1000}:
theta_hat_max_lasso_3
theta_hat_max_mcp_3
theta_hat_max_scad_3 
theta_hat_max_alasso_3

# vector containing the percent of cases when 
# beta_hat = 0 (accuracy)
accuracy_lasso_3
accuracy_mcp_3 
accuracy_scad_3
accuracy_alasso_3

##################################################
# Design 4: b = 0, pi = 0.7, n = 500
##################################################
# vector containing seed values for
# every simulation
# s, where s = {1, 1000}:
seed_vec_4 

# Lists contaning theta_hat for every lambda
# for every simulation s, where s = {1, 1000}:
theta_hat_lasso_4
theta_hat_mcp_4
theta_hat_scad_4
theta_hat_alasso_4

# data frame containing theta_hat_max:
# optimal estimates for every simulation
# s, where s = {1, 1000}:
theta_hat_max_lasso_4
theta_hat_max_mcp_4
theta_hat_max_scad_4 
theta_hat_max_alasso_4

# vector containing the percent of cases when 
# beta_hat = 0 (accuracy)
accuracy_lasso_4
accuracy_mcp_4 
accuracy_scad_4
accuracy_alasso_4

##################################################
# Design 5: b = -4, pi = 0.7, n = 500
##################################################
# vector containing seed values for
# every simulation
# s, where s = {1, 1000}:
seed_vec_5 

# Lists contaning theta_hat for every lambda
# for every simulation s, where s = {1, 1000}:
theta_hat_lasso_5
theta_hat_mcp_5 
theta_hat_scad_5 
theta_hat_alasso_5 

# data frame containing theta_hat_max:
# optimal estimates for every simulation
# s, where s = {1, 1000}:
theta_hat_max_lasso_5
theta_hat_max_mcp_5
theta_hat_max_scad_5
theta_hat_max_alasso_5

# vector containing the percent of cases when 
# beta_hat = 0 (accuracy)
accuracy_lasso_5
accuracy_mcp_5 
accuracy_scad_5
accuracy_alasso_5

##################################################
# Design 6: b = -12, pi = 0.4, n = 500
##################################################
# vector containing seed values for
# every simulation
# s, where s = {1, 1000}:
seed_vec_6 

# Lists contaning theta_hat for every lambda
# for every simulation s, where s = {1, 1000}:
theta_hat_lasso_6
theta_hat_mcp_6
theta_hat_scad_6 
theta_hat_alasso_6 

# data frame containing theta_hat_max:
# optimal estimates for every simulation
# s, where s = {1, 1000}:
theta_hat_max_lasso_6
theta_hat_max_mcp_6
theta_hat_max_scad_6 
theta_hat_max_alasso_6

# vector containing the percent of cases when 
# beta_hat = 0 (accuracy)
accuracy_lasso_6
accuracy_mcp_6 
accuracy_scad_6
accuracy_alasso_6

##################################################
# Design 7: b = 0, pi = 0, n = 500
##################################################
# vector containing seed values for
# every simulation
# s, where s = {1, 1000}:
seed_vec_7 

# Lists contaning theta_hat for every lambda
# for every simulation s, where s = {1, 1000}:
theta_hat_lasso_7
theta_hat_mcp_7 
theta_hat_scad_7 
theta_hat_alasso_7 

# data frame containing theta_hat_max:
# optimal estimates for every simulation
# s, where s = {1, 1000}:
theta_hat_max_lasso_7
theta_hat_max_mcp_7
theta_hat_max_scad_7
theta_hat_max_alasso_7

# vector containing the percent of cases when 
# beta_hat = 0 (accuracy)
accuracy_lasso_7
accuracy_mcp_7 
accuracy_scad_7
accuracy_alasso_7

##################################################
# Design 8: b = -8, pi = 0, n = 500
##################################################
# vector containing seed values for
# every simulation
# s, where s = {1, 1000}:
seed_vec_8

# Lists contaning theta_hat for every lambda
# for every simulation s, where s = {1, 1000}:
theta_hat_lasso_8
theta_hat_mcp_8 
theta_hat_scad_8 
theta_hat_alasso_8 

# data frame containing theta_hat_max:
# optimal estimates for every simulation
# s, where s = {1, 1000}:
theta_hat_max_lasso_8
theta_hat_max_mcp_8
theta_hat_max_scad_8 
theta_hat_max_alasso_8

# vector containing the percent of cases when 
# beta_hat = 0 (accuracy)
accuracy_lasso_8
accuracy_mcp_8 
accuracy_scad_8
accuracy_alasso_8

##################################################
# Design 9: b = -2, pi = 0.7, n = 500
##################################################
# vector containing seed values for
# every simulation
# s, where s = {1, 1000}:
seed_vec_9

# Lists contaning theta_hat for every lambda
# for every simulation s, where s = {1, 1000}:
theta_hat_lasso_9
theta_hat_mcp_9
theta_hat_scad_9 
theta_hat_alasso_9 

# data frame containing theta_hat_max:
# optimal estimates for every simulation
# s, where s = {1, 1000}:
theta_hat_max_lasso_9
theta_hat_max_mcp_9
theta_hat_max_scad_9 
theta_hat_max_alasso_9

# vector containing the percent of cases when 
# beta_hat = 0 (accuracy)
accuracy_lasso_9
accuracy_mcp_9 
accuracy_scad_9
accuracy_alasso_9

##################################################
# Design 10: b = 0, pi = 0.4, n = 100
##################################################
# vector containing seed values for
# every simulation
# s, where s = {1, 1000}:
seed_vec_10

# Lists contaning theta_hat for every lambda
# for every simulation s, where s = {1, 1000}:
theta_hat_lasso_10
theta_hat_mcp_10
theta_hat_scad_10 
theta_hat_alasso_10 

# data frame containing theta_hat_max:
# optimal estimates for every simulation
# s, where s = {1, 1000}:
theta_hat_max_lasso_10
theta_hat_max_mcp_10
theta_hat_max_scad_10
theta_hat_max_alasso_10

# vector containing the percent of cases when 
# beta_hat = 0 (accuracy)
accuracy_lasso_10
accuracy_mcp_10 
accuracy_scad_10
accuracy_alasso_10

##################################################
# Design 11: b = 6, pi = 0.4, n = 100
##################################################
# vector containing seed values for
# every simulation
# s, where s = {1, 1000}:
seed_vec_11

# Lists contaning theta_hat for every lambda
# for every simulation s, where s = {1, 1000}:
theta_hat_lasso_11
theta_hat_mcp_11 
theta_hat_scad_11 
theta_hat_alasso_11

# data frame containing theta_hat_max:
# optimal estimates for every simulation
# s, where s = {1, 1000}:
theta_hat_max_lasso_11
theta_hat_max_mcp_11
theta_hat_max_scad_11 
theta_hat_max_alasso_11

# vector containing the percent of cases when 
# beta_hat = 0 (accuracy)
accuracy_lasso_11
accuracy_mcp_11 
accuracy_scad_11
accuracy_alasso_11

##################################################
# Design 12: b = 2, pi = 0.7, n = 100
##################################################
# vector containing seed values for
# every simulation
# s, where s = {1, 1000}:
seed_vec_12 

# Lists contaning theta_hat for every lambda
# for every simulation s, where s = {1, 1000}:
theta_hat_lasso_12
theta_hat_mcp_12 
theta_hat_scad_12 
theta_hat_alasso_12 

# data frame containing theta_hat_max:
# optimal estimates for every simulation
# s, where s = {1, 1000}:
theta_hat_max_lasso_12
theta_hat_max_mcp_12
theta_hat_max_scad_12 
theta_hat_max_alasso_12

# vector containing the percent of cases when 
# beta_hat = 0 (accuracy)
accuracy_lasso_12
accuracy_mcp_12 
accuracy_scad_12
accuracy_alasso_12

##################################################
# Design 13: b = -12, pi = 0, n = 100
##################################################
# vector containing seed values for
# every simulation
# s, where s = {1, 1000}:
seed_vec_13 

# Lists contaning theta_hat for every lambda
# for every simulation s, where s = {1, 1000}:
theta_hat_lasso_13
theta_hat_mcp_13 
theta_hat_scad_13 
theta_hat_alasso_13 

# data frame containing theta_hat_max:
# optimal estimates for every simulation
# s, where s = {1, 1000}:
theta_hat_max_lasso_13
theta_hat_max_mcp_13
theta_hat_max_scad_13 
theta_hat_max_alasso_13

# vector containing the percent of cases when 
# beta_hat = 0 (accuracy)
accuracy_lasso_13
accuracy_mcp_13 
accuracy_scad_13
accuracy_alasso_13

##################################################
# Design 14: b = 0, pi = 0.7, n = 250
##################################################
# vector containing seed values for
# every simulation
# s, where s = {1, 1000}:
seed_vec_14

# Lists contaning theta_hat for every lambda
# for every simulation s, where s = {1, 1000}:
theta_hat_lasso_14
theta_hat_mcp_14
theta_hat_scad_14 
theta_hat_alasso_14 

# data frame containing theta_hat_max:
# optimal estimates for every simulation
# s, where s = {1, 1000}:
theta_hat_max_lasso_14
theta_hat_max_mcp_14
theta_hat_max_scad_14 
theta_hat_max_alasso_14

# vector containing the percent of cases when 
# beta_hat = 0 (accuracy)
accuracy_lasso_14
accuracy_mcp_14 
accuracy_scad_14
accuracy_alasso_14

##################################################
# Design 15: b = -6, pi = 0.4, n = 250
##################################################
# vector containing seed values for
# every simulation
# s, where s = {1, 1000}:
seed_vec_15

# Lists contaning theta_hat for every lambda
# for every simulation s, where s = {1, 1000}:
theta_hat_lasso_15
theta_hat_mcp_15
theta_hat_scad_15 
theta_hat_alasso_15 

# data frame containing theta_hat_max:
# optimal estimates for every simulation
# s, where s = {1, 1000}:
theta_hat_max_lasso_15
theta_hat_max_mcp_15
theta_hat_max_scad_15
theta_hat_max_alasso_15

# vector containing the percent of cases when 
# beta_hat = 0 (accuracy)
accuracy_lasso_15
accuracy_mcp_15 
accuracy_scad_15
accuracy_alasso_15

##################################################
# Design 16: b = 2, pi = 0.7, n = 250
##################################################
# vector containing seed values for
# every simulation
# s, where s = {1, 1000}:
seed_vec_16 

# Lists contaning theta_hat for every lambda
# for every simulation s, where s = {1, 1000}:
theta_hat_lasso_16
theta_hat_mcp_16
theta_hat_scad_16 
theta_hat_alasso_16 

# data frame containing theta_hat_max:
# optimal estimates for every simulation
# s, where s = {1, 1000}:
theta_hat_max_lasso_16
theta_hat_max_mcp_16
theta_hat_max_scad_16 
theta_hat_max_alasso_16

# vector containing the percent of cases when 
# beta_hat = 0 (accuracy)
accuracy_lasso_16
accuracy_mcp_16 
accuracy_scad_16
accuracy_alasso_16

##################################################
# Design 17: b = 10, pi = 0, n = 250
##################################################
# vector containing seed values for
# every simulation
# s, where s = {1, 1000}:
seed_vec_17 

# Lists contaning theta_hat for every lambda
# for every simulation s, where s = {1, 1000}:
theta_hat_lasso_17
theta_hat_mcp_17
theta_hat_scad_17
theta_hat_alasso_17 

# data frame containing theta_hat_max:
# optimal estimates for every simulation
# s, where s = {1, 1000}:
theta_hat_max_lasso_17
theta_hat_max_mcp_17
theta_hat_max_scad_17 
theta_hat_max_alasso_17

# vector containing the percent of cases when 
# beta_hat = 0 (accuracy)
accuracy_lasso_17
accuracy_mcp_17
accuracy_scad_17
accuracy_alasso_17

##################################################
# Design 18: b = 0, pi = 0.4, n = 10000
##################################################
# vector containing seed values for
# every simulation
# s, where s = {1, 1000}:
seed_vec_18

# Lists contaning theta_hat for every lambda
# for every simulation s, where s = {1, 1000}:
theta_hat_lasso_18
theta_hat_mcp_18
theta_hat_scad_18 
theta_hat_alasso_18 

# data frame containing theta_hat_max:
# optimal estimates for every simulation
# s, where s = {1, 1000}:
theta_hat_max_lasso_18
theta_hat_max_mcp_18
theta_hat_max_scad_18 
theta_hat_max_alasso_18

# vector containing the percent of cases when 
# beta_hat = 0 (accuracy)
accuracy_lasso_18
accuracy_mcp_18
accuracy_scad_18
accuracy_alasso_18

##################################################
# Design 19: b = 6, pi = 0, n = 10000
##################################################
# vector containing seed values for
# every simulation
# s, where s = {1, 1000}:
seed_vec_19

# Lists contaning theta_hat for every lambda
# for every simulation s, where s = {1, 1000}:
theta_hat_lasso_19
theta_hat_mcp_19 
theta_hat_scad_19 
theta_hat_alasso_19 

# data frame containing theta_hat_max:
# optimal estimates for every simulation
# s, where s = {1, 1000}:
theta_hat_max_lasso_19
theta_hat_max_mcp_19
theta_hat_max_scad_19 
theta_hat_max_alasso_19

# vector containing the percent of cases when 
# beta_hat = 0 (accuracy)
accuracy_lasso_19
accuracy_mcp_19 
accuracy_scad_19
accuracy_alasso_19

##################################################
# Design 20: b = -2, pi = 0.7, n = 10000
##################################################
# vector containing seed values for
# every simulation
# s, where s = {1, 1000}:
seed_vec_20

# Lists contaning theta_hat for every lambda
# for every simulation s, where s = {1, 1000}:
theta_hat_lasso_20
theta_hat_mcp_20 
theta_hat_scad_20 
theta_hat_alasso_20 

# data frame containing theta_hat_max:
# optimal estimates for every simulation
# s, where s = {1, 1000}:
theta_hat_max_lasso_20
theta_hat_max_mcp_20
theta_hat_max_scad_20 
theta_hat_max_alasso_20

# vector containing the percent of cases when 
# beta_hat = 0 (accuracy)
accuracy_lasso_20
accuracy_mcp_20 
accuracy_scad_20
accuracy_alasso_20

##################################################
# Design 21: b = -4, pi = 0, n = 10000
##################################################
# vector containing seed values for
# every simulation
# s, where s = {1, 1000}:
seed_vec_21 

# Lists contaning theta_hat for every lambda
# for every simulation s, where s = {1, 1000}:
theta_hat_lasso_21
theta_hat_mcp_21 
theta_hat_scad_21 
theta_hat_alasso_21

# data frame containing theta_hat_max:
# optimal estimates for every simulation
# s, where s = {1, 1000}:
theta_hat_max_lasso_21
theta_hat_max_mcp_21
theta_hat_max_scad_21 
theta_hat_max_alasso_21

# vector containing the percent of cases when 
# beta_hat = 0 (accuracy)
accuracy_lasso_21
accuracy_mcp_21
accuracy_scad_21
accuracy_alasso_21

