##########################################
### This supplementary R file provides ###
###    functions for the main file     ###
###        to estimate penalized       ###
###         ARMA family models         ###
##########################################
####      The code is developed by     ###
####      @Juri Trifonov, NRU HSE      ###
##########################################
# Disable scientific notation
options(scipen = 999)

# 1. Data Generating Function

arma_sim <- function(n = 1000,
                     b = 10,
                     pi = 0.4)
{
  n <- n + 200
  beta <- b / sqrt(n)

  eps <- rnorm(n) # generate random shocks
  
  # generate y
  y <- rep(NA, n)
  y[1] <- eps[1]
  
  # y for every time period t
  for(t in 2:n)
  {
    y[t] <- (beta + pi) * y[t-1] + eps[t] - pi * eps[t-1]
  }
  # final dataframe
  data <- data.frame(y)
  if ((pi + beta > 0.85) | (pi + beta < -0.85))
  {
    message <- c('Stationarity conditions are not satisfied. Please, try another combination of parameters.')
    return(message)
  }else{
    return(data$y[201:n])
        }
}


###################################################
########### Function for MCP penalty ##############
###################################################

pen_mcp <- function (beta, lambda, pen_a)
{
  if(abs(beta) <= pen_a * lambda)
  {
    pen_mcp <- lambda * abs(beta) - (beta^2 / (2 * pen_a))
  } else{
    pen_mcp <- (pen_a * lambda^2) / 2
  }
  return(pen_mcp)
}

###################################################
########### Function for SCAD penalty #############
###################################################

pen_scad <- function(beta, lambda, pen_a)
{
  if(abs(beta) <= lambda)
  {
    pen_scad <- lambda * abs(beta)
  } else if((abs(beta) <= pen_a * lambda) && (abs(beta) > lambda))
  {
    pen_scad <- (2 * pen_a * lambda * abs(beta) - beta^2 - lambda^2) / (2 * (pen_a - 1))
  } else {
    pen_scad <- (lambda^2 * (pen_a + 1) / 2)
  }
  return(pen_scad)
}


# 2. Log-likelihood function
lnL_arma <- function (x,
                      data,   
                      lambda,
                      is_aggregate = TRUE,
                      penalty,
                      pen_a,
                      w, 
                      sigma_hat = FALSE)     
  
{ 
  beta <- x[1]                              
  pi <- x[2]
  y <- data
  n = length(y)
  eps <- rep(NA, n)
  eps[1] <- 0
  
  # validation of stationarity 
  if (((beta + pi) > 0.9) && ((beta + pi) < -0.9))
  {
    return(-9999999999999999999)
  }
  
  for (t in 2:n)
  {
    eps[t] <- y[t] - (beta + pi) * y[t-1] + pi * eps[t-1]
  }
  
  L_vector <- dnorm(eps, sd = 1) # compute normal pdf values
  
  # log values of densities
  if (penalty == 'nopen')        # without penalty
  {
    lnL_value <- log(L_vector)
  }
  if (penalty == 'lasso')        # for lasso penalty
  {
     lnL_value <- log(L_vector) - lambda * abs(beta)              
  }
  
  if (penalty == 'MCP')          # for mcp penalty
  {
    pen_value <- pen_mcp(beta, lambda, pen_a)
    lnL_value <- log(L_vector) - pen_value            
  }
  
  if (penalty == 'SCAD')         # for scad penalty
  {
    pen_value <- pen_scad(beta, lambda, pen_a)
    lnL_value <- log(L_vector) - pen_value            
  }
  if (penalty == 'alasso')       # for alasso penalty
  {
    lnL_value <- log(L_vector) - w * lambda * abs(beta)            
  }
  
  
  
  if(!is_aggregate)                     
  {                                          
    return(lnL_value)                     
  }
  if (sigma_hat == TRUE)         # estimate of variance
  {
    sigma_sq_hat <- sum(eps^2) / n
    return(sigma_sq_hat)
  }
  
  return(sum(lnL_value))   
  
}



## Optimization function ##
arma_opt <- function(x, data, lambda, penalty, pen_a, w)                                
  
{
  y <- data                               
  
  # initial optimization via Nelder-Mead algorithm
  result <- optim(par = x,                              
                  method = "Nelder-Mead",                      
                  fn = lnL_arma,                         
                  control = list(maxit = 10000,          
                                 fnscale = -1,           
                                 reltol = 1e-10),        
                  hessian = FALSE,                       
                  data = data, 
                  lambda = lambda,
                  pen_a = pen_a,
                  penalty = penalty,
                  w = w)                                
  
  
  gamma_est <- result$par    # parameter estimates                           
  
  
  return_list <- list("gamma" = gamma_est,  # parameter estimates               
                      "data" = data,        # data            
                      "lnL" = result$value) # value of the maximized function                               
  
  class(return_list) <- "ARMA"                          
  
  return(return_list)                                                         
}

###################################################################
###################### COORDINATE DESCENT #########################
###################################################################
soft_tresh <- function(a, b)                   # soft threshold function for lasso
{
     if(a > b)
     {
       out <- a - b
      
     }
     if(abs(a) <= b)
     {
       out <- 0
       
     }
     if(a < -b)
     {
       out <- a + b
       
     }
     return(out)
}
  
mcp_thresh <- function(beta_hat, lambda, pen_a) # soft threshold function for mcp
{
  if(abs(beta_hat) <= pen_a * lambda)
  {
    S <- soft_tresh(a = beta_hat, b = lambda)
    thresh_out <- (pen_a / (pen_a - 1)) * S
  } else{thresh_out <- beta_hat}
  
  return(thresh_out)
}

scad_thresh <- function(beta_hat, lambda, pen_a) # soft threshold function for scad
{
  if(abs(beta_hat) <= 2 * lambda)
  {
    S <- soft_tresh(a = beta_hat, b = lambda)
    thresh_out <- S
  }
  
  if((2 * lambda < abs(beta_hat)) && (abs(beta_hat) <= pen_a * lambda))
  {
    S <- soft_tresh(a = beta_hat, b = (pen_a * lambda)/(pen_a - 1))
    thresh_out <- ((pen_a - 1) / (pen_a - 2)) * S
  }
  
  if(abs(beta_hat) > pen_a * lambda)
  {
    thresh_out <- beta_hat
  }

  return(thresh_out)
}

# 2. Log-likelihood function (modified for cd algorithm)
lnL_arma_cd <- function (cnst,
                         x,
                         data,
                         penalty,
                         lambda,
                         pen_a,
                         is_aggregate = TRUE,
                         j,
                         w)     
  
{ 
  if (j == 1)          # if we maximize for beta
  {
    beta <- x
    pi <- cnst         # pi is treated as constant
  }
  if (j == 2)          # if we maximize for pi
  {
    beta <- cnst       # beta is treated as a constant                        
    pi <- x
  }

  
  
  y <- data
  n = length(y)
  
  eps <- rep(NA, n)
  eps[1] <- 0         # initial value of epsilon
  
  # validation of stationarity 
  if (((beta + pi) > 0.9) && ((beta + pi) < -0.9))
  {
    return(-9999999999999999999)
  }
 
  # calculate epsilon values for every t
  for (t in 2:n)
  {
    eps[t] <- y[t] - (beta + pi) * y[t-1] + pi * eps[t-1]
  }
  
  L_vector <- dnorm(eps, sd = 1)
  if (penalty == 'nopen')                            # without penalty
  {
    lnL_value <- log(L_vector)
  }
  
  if (penalty == 'lasso')
  {
    lnL_value <- log(L_vector) - lambda * abs(beta)  # for lasso penalty           
  }
  
  if (penalty == 'MCP')
  {
    pen_value <- pen_mcp(beta, lambda, pen_a)        # for mcp penalty
    lnL_value <- log(L_vector) - pen_value            
  }
  
  if (penalty == 'SCAD')                             # for scad penalty
  {
    pen_value <- pen_scad(beta, lambda, pen_a)
    lnL_value <- log(L_vector) - pen_value            
  }
  
  if (penalty == 'alasso')                           # for alasso penalty
  {
    lnL_value <- log(L_vector) - w * lambda * abs(beta)            
  }
            
  if(!is_aggregate)                     
  {                                          
    return(lnL_value)                     
  }
 
  
  return(sum(lnL_value))   
  
}

## Optimization function (coordinate descend algorithm) ##
arma_opt_cd <- function(x, data, lambda, penalty, pen_a = 3.7, w = 1, tol = 1e-9, iter = 1000)                                
  
{
  y <- data  
  n <- length(data)
  
  y <- (y - mean(y)) / sd(y)
  
  if (penalty == 'alasso')
  {
   
    result <- optim(par = x,                              
                    method = "BFGS",                      
                    fn = lnL_arma,                         
                    control = list(maxit = 10000,          
                                   fnscale = -1,           
                                   reltol = 1e-10),        
                    hessian = FALSE,                       
                    data = y, 
                    lambda = 0,
                    penalty = 'nopen',
                    pen_a = pen_a) 
    
    gamma_est <- result$par
    w <- 1 /  abs(gamma_est[1])
 
  }

  gamma_est <- c(0,0)


  const <- matrix(NA, ncol = 2, nrow = iter)
  const[1, ] <- gamma_est
  tol_curr <- 1
  i <- 2
  while (tol < tol_curr && i < iter) {
  for (j in 1:2)
  {

    if (j == 1)
    {
      cnst = const[i-1, 2]
    
    }
    if (j == 2)
    {
      cnst = const[i, 1]
    }
  
  res_cd <- optim(par = const[i-1, j],
                  method = "Brent",                      
                  fn = lnL_arma_cd,                         
                  control = list(maxit = 10000,          
                                 fnscale = -1,           
                                 reltol = 1e-10),   
                  lower = -0.9, upper = 0.9,
                  hessian = FALSE,                       
                  data = y, 
                  lambda = 0,
                  j = j,
                  cnst = cnst,
                  penalty = 'lasso',
                  pen_a = pen_a, 
                  w = w
                  )
 

  if (j == 1)
  {
    if (penalty == 'nopen')
    {
      beta_soft <- res_cd$par
    }
    if (penalty == 'lasso')
    {
      beta_soft <- soft_tresh(res_cd$par, lambda)
    }
    if (penalty == 'MCP')
    {
      beta_soft <- mcp_thresh(res_cd$par, lambda, pen_a)
    }
    if (penalty == 'SCAD')
    {
      beta_soft <- scad_thresh(res_cd$par, lambda, pen_a)
    }
    if (penalty == 'alasso')
    {
      beta_soft <-soft_tresh(res_cd$par, w * lambda)
    }

    const[i, 1] <- beta_soft
    const[i, 2] <- const[i-1, 2]
  
  }
  if (j == 2)
  {
    const[i, 2] <- res_cd$par

  }
 
  }

    final <- const[i, ]
   
    tol_curr = crossprod(const[i, ] - const[i-1, ])  
    
  i = i + 1
  }

  theta_est <- final
  lnL <- lnL_arma(x = theta_est, data = data, lambda = lambda, pen_a = pen_a, penalty = penalty, w = w)
  
  
  return_list <- list("theta" = theta_est,               
                      "data" = data,                    
                      "lnL" = lnL,
                      'lambda' = lambda)                                
  
  class(return_list) <- "ARMA"              
  
  return(return_list)                                                         
}



##########################################
###$ 4. Define the BIC-type criterion ####
## %% This function calculates the BIC-type 
## %% criterion for finding an optimal penalty
## %% parameter lambda
##########################################
bic_func <- function(model, is_DF = FALSE)
{
  n <- length(model$data)
  lambda <- model$lambda
  beta_hat <- model$theta[1]
  
  ar_root <- (arroots(model))$roots
  ma_root <- (maroots(model))$roots
  
  if (ar_root == ma_root)
  {
    DF <- 0
  }else{
    DF <- 1
  }
  

  BIC <- DF * log(n) - 2 * model$lnL

  
  if(is_DF == TRUE)
  {
    return(DF)
  }
  
  return(BIC)
  
}






#################################################
arma_est <- function(data, seq = 'default', iter = 100, penalty, w = 1, pen_a = 3.7)
{
  pen <- 1/sqrt(length(data))                       # define the penalty as 1/ sqrt(n)
  s <- seq(0.001 * pen, 4 * pen, length.out = 100)  # define the sequence of lambdas
  #s <- 10^seq(10,-2,length=100)
  if (seq != 'default')                             # define the default sequence for lambdas
  {
    s <- seq
  }
  bic_vec <- c(rep(NA, length(s)))                  # prepare the vector for storing bic values for every lambda in the sequence
  theta_matr <- matrix(NA, length(s), 2)
  lambda_vec <- c(rep(NA, length(s)))               # prepare the vector for storing lambdas
  lnL_value <- c(rep(NA, length(s)))                # prepare the vector for storing lnL values
  DF_set <- c(rep(NA, length(s)))                   # prepare the vector for storing numbers of degrees of freedom for every lambda in the sequence
  
  x0 <- c(rep(0, 2))
  
  for (i in 1:length(s))
  {
    #print(c(paste('Lambda number:', i)))
    
    model <- arma_opt_cd(x = x0, data = data, lambda = s[i], iter = iter, pen_a = pen_a, penalty = penalty)
   
    
    theta_matr[i, ] <- model$theta
    lnL_value[i] <- model$lnL
    lambda_vec[i] <- model$lambda
    bic_vec[i] <- bic_func(model)
    DF_set[i] = bic_func(model, is_DF = TRUE)
  }
    total <- data.frame(round(bic_vec,7), round(lambda_vec,7), round(theta_matr,7), round(lnL_value,7), round(DF_set, 7))
    
    names(total) <- c('bic', 'lambda', 'beta', 'pi', 'lnL', 'DF')
    for (k in 1:length(total$lambda))
    {
      if(total$beta[k] == 0)
      {
        total$pi[k] <- 'NONIND'
      }
    }
    
    optimal_frame <- total[total$bic == min(total$bic), ]
    optimal_frame <- optimal_frame[optimal_frame$lambda == min(optimal_frame$lambda), ]
    
    theta_opt <- as.vector(optimal_frame[3:4])
    names(theta_opt) <- c('beta', 'pi')
    
    result <- list('theta_opt' = theta_opt,
                   'bic_opt' = optimal_frame[1],
                   'lambda_opt' = optimal_frame[2],
                   'total_frame' = total,
                   'optimal_frame' = optimal_frame)
  
    return(result)
  
}

### Functions for computing roots of the process ###
# Compute AR roots
arroots <- function(object)
{
    parvec <- (object$theta[1] + object$theta[2]) # ar part coefficient

  if(length(parvec) > 0)
  {
    last.nonzero <- max(which(abs(parvec) > 1e-08))
    if (last.nonzero > 0)
      return(structure(list(roots=polyroot(c(1,-parvec[1:last.nonzero])),
                            type="AR"), class='armaroots'))
  }
  return(structure(list(roots=numeric(0),type="AR"),class='armaroots'))
}

# Compute MA roots
maroots <- function(object)
{
  parvec <- object$theta[2] # ma part coefficient
  if(length(parvec) > 0)
  {
    last.nonzero <- max(which(abs(parvec) > 1e-08))
    if (last.nonzero > 0)
      return(structure(list(roots=polyroot(c(1,-parvec[1:last.nonzero])),
                            type="MA"), class='armaroots'))
  }
  return(structure(list(roots=numeric(0),type="MA"),class='armaroots'))
}


