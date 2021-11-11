# gene-expression-variability

## central question: how does TF concentration affect gene expression, aka, transcription rate?

- lg_TF_ss and lg_TF_nss shows the relationship between log gain at steady state and non-steady state respectively (assuming rate constants are known for steady state, and rate constants and time are known for transient state)
- lg_ss is a function that can compute log gain at any given TF for a steady state system
- main_ss and main_nss try to find the best parameter k to maximize the log gain at steady state and transient state using particle swarm and latin hypercube sampling


