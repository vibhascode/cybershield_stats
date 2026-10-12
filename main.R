
# CyberShield Stats
# Probability and Statistics Project

source("simulation.R")
source("statistics.R")

# Experiment settings
lambda0 <- 20
alpha <- 0.05

# Generate simulated traffic
traffic <- simulate_traffic(
  n = 200,
  lambda0 = lambda0,
  attack_start = 80,
  attack_duration = 10,
  attack_multiplier = 3,
  seed = 42
)

# Detect anomalies using the exact Poisson test
results <- detect_anomalies(
  traffic,
  lambda0 = lambda0,
  alpha = alpha
)

# Display summary
cat("\nCYBERSHIELD STATS\n")
cat("=================\n")
cat("Baseline request rate:", lambda0, "\n")
cat("Significance level:", alpha, "\n")
cat("Total intervals:", nrow(results), "\n")
cat("Simulated attack intervals:", sum(results$is_attack), "\n")
cat("Flagged intervals:", sum(results$flagged), "\n")

# Print the first 10 rows
cat("\nSample results:\n")
print(head(results, 10))

# Calculate performance
actual <- results$is_attack
predicted <- results$flagged

tp <- sum(predicted & actual)
tn <- sum(!predicted & !actual)
fp <- sum(predicted & !actual)
fn <- sum(!predicted & actual)

cat("\nCONFUSION MATRIX\n")
print(matrix(
  c(tn, fp, fn, tp),
  nrow = 2,
  byrow = TRUE,
  dimnames = list(
    Actual = c("Normal", "Attack"),
    Predicted = c("Normal", "Attack")
  )
))

cat("\nFalse-positive rate:",
    round(fp / sum(!actual), 4), "\n")
cat("Detection rate:",
    round(tp / sum(actual), 4), "\n")

# Estimate the overall request rate
cat("\n95% confidence interval for overall mean rate:\n")
print(rate_ci(results$requests))

# Plot traffic
plot(
  results$interval,
  results$requests,
  type = "l",
  xlab = "Time interval",
  ylab = "Requests",
  main = "CyberShield: Network Traffic"
)

points(
  results$interval[results$flagged],
  results$requests[results$flagged],
  col = "red",
  pch = 19
)

abline(h = lambda0, col = "blue", lty = 2)

legend(
  "topleft",
  legend = c("Traffic", "Flagged", "Baseline"),
  col = c("black", "red", "blue"),
  lty = c(1, NA, 2),
  pch = c(NA, 19, NA),
  bty = "n"
)

# Compare observed flags at different significance levels
cat("\nALPHA COMPARISON\n")

for (a in c(0.05, 0.01, 0.001)) {
  test_result <- detect_anomalies(
    traffic, lambda0 = lambda0, alpha = a
  )
  
  cat(
    "Alpha =", a,
    "| Flagged =", sum(test_result$flagged),
    "| False positives =",
    sum(test_result$flagged & !actual), "\n"
  )
}
