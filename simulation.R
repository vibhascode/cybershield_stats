
# CyberShield Stats: Traffic Simulation

simulate_traffic <- function(n = 200, lambda0 = 20,
                             attack_start = 80,
                             attack_duration = 10,
                             attack_multiplier = 3,
                             seed = 42) {
  set.seed(seed)
  
  if (n < 1 || lambda0 <= 0 ||
      attack_duration < 0 || attack_multiplier <= 0) {
    stop("Invalid simulation parameters.")
  }
  
  counts <- rpois(n, lambda0)
  is_attack <- rep(FALSE, n)
  
  if (attack_duration > 0) {
    start <- max(1, min(n, attack_start))
    end <- min(n, start + attack_duration - 1)
    is_attack[start:end] <- TRUE
    
    counts[start:end] <- rpois(
      length(start:end),
      lambda0 * attack_multiplier
    )
  }
  
  data.frame(
    interval = seq_len(n),
    requests = counts,
    is_attack = is_attack
  )
}
