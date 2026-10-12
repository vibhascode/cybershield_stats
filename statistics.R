
# CyberShield Stats: Statistical Tests

# Exact upper-tail Poisson test
poisson_test <- function(x, lambda0, alpha = 0.05) {
  if (lambda0 <= 0 || alpha <= 0 || alpha >= 1) {
    stop("Invalid lambda0 or alpha.")
  }
  
  p_value <- ppois(
    x - 1,
    lambda = lambda0,
    lower.tail = FALSE
  )
  
  list(
    p_value = p_value,
    flagged = p_value < alpha
  )
}

# Approximate Z-test with continuity correction
z_test <- function(x, lambda0, alpha = 0.05) {
  if (lambda0 <= 0 || alpha <= 0 || alpha >= 1) {
    stop("Invalid lambda0 or alpha.")
  }
  
  z <- (x - 0.5 - lambda0) / sqrt(lambda0)
  p_value <- pnorm(z, lower.tail = FALSE)
  
  if (lambda0 < 30) {
    warning("Z-test approximation may be unreliable for lambda0 < 30.")
  }
  
  list(
    z = z,
    p_value = p_value,
    flagged = p_value < alpha
  )
}

# Confidence interval for a Poisson request rate
rate_ci <- function(counts, confidence = 0.95) {
  if (length(counts) == 0 ||
      any(counts < 0) ||
      any(counts != floor(counts)) ||
      confidence <= 0 || confidence >= 1) {
    stop("Invalid counts or confidence level.")
  }
  
  total <- sum(counts)
  n <- length(counts)
  tail_prob <- (1 - confidence) / 2
  
  lower <- if (total == 0) {
    0
  } else {
    qchisq(tail_prob, df = 2 * total) / (2 * n)
  }
  
  upper <- qchisq(
    1 - tail_prob,
    df = 2 * (total + 1)
  ) / (2 * n)
  
  c(lower = lower, upper = upper)
}

# Detect unusual request counts
detect_anomalies <- function(data, lambda0 = 20,
                             alpha = 0.05,
                             bonferroni = FALSE) {
  threshold <- if (bonferroni) {
    alpha / nrow(data)
  } else {
    alpha
  }
  
  p_values <- ppois(
    data$requests - 1,
    lambda = lambda0,
    lower.tail = FALSE
  )
  
  data$p_value <- p_values
  data$flagged <- p_values < threshold
  data
}
