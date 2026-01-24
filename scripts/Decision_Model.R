# Model testing ####

library(decisionSupport)
# make variables for testing our model (only for construction)
source("scripts/make_variables.R")
make_variables(decisionSupport::estimate_read_csv(paste("data/inputs_decision.csv",sep="")))

# --- Optional: Check variables ------------------------------------------------
# Keeps your "inputs CSV ↔ script variable name" check idea, but simplified.

data <- read.csv("data/inputs_decision.csv")
var_list <- unique(data$variable)

r_script_lines <- readLines("scripts/Decision_Model.R")
r_script_text <- paste(r_script_lines, collapse = " ")

missing_in_script <- var_list[!sapply(var_list, function(v) grepl(v, r_script_text, fixed = TRUE))]
missing_in_script
# If this prints something, the inputs CSV includes variables you don't use here.

# The model ####

# Generic decision model (see index.Rmd for narrative + assumptions)

decision_function <- function(x, varnames){

  # 1) COST (one cost)
  # Up-front implementation cost (year 1 only)
  total_cost <- rep(0, number_of_years)
  total_cost[1] <- implementation_cost

  # 2) BENEFIT (one benefit)
  # Annual benefit stream with variability + trend
  benefit_stream <- vv(
    annual_benefit,
    var_CV = CV_value,
    n = number_of_years,
    relative_trend = inflation_rate
  )

  # 3) RISK (one risk, using chance_event)
  # A single risk event (e.g., "project fails / adoption fails") that reduces benefits.
  risk_penalty_fraction <- 0.4
  # chance_event() returns 1 or 0.
  # If it occurs (1), we apply a penalty multiplier to benefits.
  risk_occurs <- chance_event(prob_risk_event)  # prob in [0,1]

  risk_multiplier <- if (risk_occurs == 1) {
    (1 - risk_penalty_fraction)  # e.g., 0.4 means benefits drop by 40%
  } else {
    1
  }

  benefit_stream_risk_adjusted <- benefit_stream * risk_multiplier

  # 4) Net cashflow
  cashflow <- benefit_stream_risk_adjusted - total_cost

  # 5) NPV
  NPV_decision <- discount(
    x = cashflow,
    discount_rate = discount_rate,
    calculate_NPV = TRUE
  )

  return(list(
    NPV_decision = NPV_decision,
    Cashflow = cashflow
  ))
}

