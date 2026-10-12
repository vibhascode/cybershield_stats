# CyberShield Stats: Statistical Detection of Network Traffic Anomalies

**A probability-based approach to identifying unusual network request counts using Base R**

## 📌 Overview

CyberShield Stats is a statistical simulation project that explores how probability distributions and hypothesis testing can be used to identify unusual patterns in network traffic.

The project models network request counts using the **Poisson distribution** and applies an exact upper-tail hypothesis test to identify intervals with unusually high request counts. The statistical predictions are then compared with simulated anomaly labels to evaluate detection performance.

The project is implemented entirely in **Base R**, with a focus on understanding the practical applications of probability and statistics in cybersecurity.

> **Note:** CyberShield Stats is an educational simulation, not a production-grade intrusion detection system. It uses simulated network traffic and does not monitor live networks.

## 🎯 Objectives

- Simulate network request counts using the Poisson distribution.
- Establish a baseline model for normal network traffic.
- Apply hypothesis testing to identify statistically unusual request counts.
- Investigate how significance levels affect anomaly detection and false alarms.
- Explore Bonferroni correction when conducting multiple statistical tests.
- Evaluate the detection results using confusion-matrix metrics.
- Visualize simulated traffic and statistical detection results.

## 🔍 Problem Statement

Network traffic can vary over time, and unusually high request counts may indicate a possible anomaly. However, a high count does not automatically imply malicious activity.

This project investigates whether statistical hypothesis testing can distinguish unusually high request counts from traffic consistent with an assumed baseline.

The simulation uses a baseline Poisson rate of:

\[
\lambda_0 = 20
\]

For each interval, the observed request count is evaluated against this baseline. Intervals with sufficiently small upper-tail p-values are flagged for further investigation.

The project also examines the trade-off between detecting anomalies and generating false positives.

## 📊 Statistical Concepts Used

### 1. Poisson Distribution

The Poisson distribution is used to model the number of requests observed within a fixed interval, assuming a constant average event rate and independent occurrences.

Its probability mass function is:

\[
P(X=k)=\frac{e^{-\lambda}\lambda^k}{k!}
\]

Where:

- \(X\) represents the number of requests in an interval.
- \(k\) is the observed request count.
- \(\lambda\) is the expected average request count.
- \(e\) is Euler's number.

For a Poisson random variable:

\[
E(X)=\lambda
\]

\[
\operatorname{Var}(X)=\lambda
\]

The baseline rate in this project is \(\lambda_0=20\).

### 2. Hypothesis Testing

The project uses a one-sided hypothesis test to identify unusually high request counts.

- **Null hypothesis (\(H_0\))**: The request count follows the baseline Poisson model with \(\lambda=20\).
- **Alternative hypothesis (\(H_1\))**: The request count is unusually high relative to the baseline model.

The upper-tail p-value is calculated as:

\[
p=P(X\geq x\mid\lambda=20)
\]

Where \(x\) is the observed request count.

An interval is flagged when its p-value is less than or equal to the selected significance level \(\alpha\).

### 3. Significance Level

The significance level controls how much evidence is required to flag an interval.

Common values considered in the project include:

- \(\alpha=0.05\)
- \(\alpha=0.01\)
- \(\alpha=0.001\)

A smaller significance level generally makes the test more conservative, potentially reducing false positives while also making some anomalies harder to detect.

### 4. Bonferroni Correction

When several intervals are tested independently or simultaneously, repeatedly applying the same significance threshold can increase the probability of obtaining false positives across the collection of tests.

The Bonferroni correction adjusts the threshold as follows:

\[
\alpha_{\text{adjusted}}=\frac{\alpha}{m}
\]

Where:

- \(\alpha\) is the desired family-wise significance level.
- \(m\) is the number of statistical tests.

This correction is used to explore multiple-testing control in the anomaly-detection workflow.

## 🏗️ Project Structure

The project is organized into separate R scripts, each responsible for a specific part of the workflow.

```text
CyberShield-Stats/
│
├── simulation.R       # Generates simulated network traffic
├── statistics.R       # Performs statistical tests and corrections
├── main.R             # Runs the workflow and generates plots
├── test_sanity.R      # Checks basic correctness and reproducibility
└── README.md          # Project documentation
```

*The structure above reflects the intended project organization; adjust filenames if your repository uses a different layout.*

### File Responsibilities

| File | Responsibility |
|---|---|
| `simulation.R` | Generates network request counts using Poisson-based simulation. |
| `statistics.R` | Calculates statistical p-values, applies decision thresholds, and handles Bonferroni adjustments. |
| `main.R` | Coordinates simulation, statistical analysis, result evaluation, and visualization. |
| `test_sanity.R` | Checks reproducibility with fixed random seeds and validates basic p-value behavior. |

## ⚙️ Methodology

The project follows these steps:

1. **Generate traffic:** Simulate request counts for multiple time intervals using a baseline Poisson rate of 20 and the project's configured anomaly scenarios.
2. **Define the baseline:** Treat the baseline rate as the expected request count under normal simulated conditions.
3. **Calculate p-values:** Evaluate the upper-tail probability of observing each count under the baseline model.
4. **Apply statistical thresholds:** Compare the p-values against the selected significance level.
5. **Flag anomalies:** Mark intervals that satisfy the statistical decision rule.
6. **Evaluate predictions:** Compare the detected intervals with the known labels assigned by the simulation.
7. **Visualize results:** Use plots to examine request counts, flagged intervals, and detection performance.
8. **Validate behavior:** Run sanity checks for reproducibility and basic statistical correctness.

## 📈 Evaluation Metrics

The project compares predicted anomaly flags with the known labels from the simulation.

| Metric | Meaning |
|---|---|
| True Positive (TP) | An anomalous interval correctly flagged. |
| False Positive (FP) | A normal interval incorrectly flagged. |
| True Negative (TN) | A normal interval correctly left unflagged. |
| False Negative (FN) | An anomalous interval that was not flagged. |

Two important performance measures are:

**Detection rate (Recall)**

\[
\text{Recall}=\frac{TP}{TP+FN}\times100
\]

This measures the proportion of simulated anomalies detected by the statistical test.

**False positive rate (FPR)**

\[
\text{FPR}=\frac{FP}{FP+TN}\times100
\]

This measures the proportion of normal intervals incorrectly flagged as anomalous.

### Reported Simulation Results

The project's reported evaluation contains the following results for 200 intervals:

| Metric | Result |
|---|---:|
| True Positives | 10 |
| False Positives | 5 |
| True Negatives | 185 |
| False Negatives | 0 |
| Detection Rate (Recall) | 100% |
| False Positive Rate | 2.63% |

These figures describe the reported simulation, not performance on real-world network traffic. Results may depend on the random seed, simulation settings, anomaly construction, and significance threshold.

## 🛠️ Technologies Used

- **R** — Statistical computing and simulation.
- **Base R** — Probability calculations, data processing, testing, and visualization.
- **Poisson distribution** — Modeling request counts.
- **Hypothesis testing** — Identifying statistically unusual observations.
- **Bonferroni correction** — Adjusting significance thresholds for multiple tests.
- **Statistical visualization** — Exploring traffic patterns and detection outcomes.

No external R packages are required for the core implementation if all functionality is provided by the listed Base R scripts.

## 🚀 Getting Started

### Prerequisites

- R installed on your computer.
- A text editor or R development environment, such as RStudio or VS Code with R support.
- The project source files.

### Installation

Clone the repository:

```bash
git clone <your-repository-url>
```

Navigate to the project directory:

```bash
cd CyberShield-Stats
```

### Run the Project

Run the main script using R:

```bash
Rscript main.R
```

If you are using RStudio, open the project folder and execute `main.R`.

To run the sanity checks:

```bash
Rscript test_sanity.R
```

**Note:** Run the scripts from the project directory so that relative file paths work correctly. The commands assume that `main.R` and `test_sanity.R` are the entry points in your repository.

## ⚠️ Limitations

- **Simulated data:** The project uses generated traffic rather than live network logs.
- **Fixed baseline:** The baseline rate is assumed to be 20 and may not represent changing traffic patterns.
- **Poisson assumptions:** Real network traffic may exhibit burstiness, temporal dependence, or overdispersion that a simple Poisson model does not capture.
- **Threshold sensitivity:** Detection and false-positive rates depend on the significance level and correction method.
- **Random variation:** Results can change with the random seed and simulation parameters.
- **Limited threat context:** A statistically unusual request count does not establish that an interval represents a cyberattack.

These limitations mean the results should be interpreted as a demonstration of statistical anomaly detection rather than proof of real-world attack detection capability.

## 🔮 Future Improvements

Potential extensions include:

- Testing the model with anonymized real-world network traffic.
- Evaluating results over multiple random seeds and simulation configurations.
- Developing adaptive baselines for traffic patterns that change over time.
- Comparing the Poisson model with alternative statistical approaches.
- Investigating burst-aware models and overdispersed count distributions.
- Improving visualizations to make detected intervals and false alarms easier to interpret.
- Expanding automated tests for statistical calculations and edge cases.

## 🎓 Academic Relevance

CyberShield Stats demonstrates how concepts from probability and statistics can be applied to a cybersecurity-related problem. It connects probability distributions, hypothesis testing, significance levels, multiple-testing correction, and performance evaluation within a single reproducible simulation.

The project is intended to strengthen the understanding of statistical reasoning through a practical implementation in R.

## 📚 References

- R Project for Statistical Computing: https://www.r-project.org/
- R documentation for the Poisson distribution (`dpois`, `ppois`): https://stat.ethz.ch/R-manual/R-devel/library/stats/html/Poisson.html
- NIST/SEMATECH e-Handbook of Statistical Methods: https://www.itl.nist.gov/div898/handbook/
- Dunn, O. J. (1961). *Multiple comparisons among means.* Journal of the American Statistical Association, 56(293), 52–64. https://doi.org/10.1080/01621459.1961.10482090

---

## 👥 Project Team

- **Muskan Srivastava**
- **Vibha S**

**Project type:** Academic course project  
**Implementation:** Base R  
**Domain:** Probability, Statistics, and Cybersecurity

---

*CyberShield Stats is an educational project demonstrating statistical methods for identifying unusual network request counts. It is not intended to replace dedicated network monitoring or intrusion detection systems.*