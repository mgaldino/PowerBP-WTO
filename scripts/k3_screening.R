# k3_screening.R
# K=3 type extension of the unanimity screening model.
# Types: theta=0 (V=1), theta=1 (V=r1), theta=2 (V=r2), where 1 < r1 < r2.
# H observes own type; W only knows prior mu = c(mu[1], mu[2], mu[3]).
# Follows the same Baron-Ferejohn 2-round structure as the K=2 code in
# formal_model_v2.Rmd (lines 335-403).
#
# Indexing convention: mu[1]=P(theta=0), mu[2]=P(theta=1), mu[3]=P(theta=2).
# Similarly VH vectors return c(VH_type0, VH_type1, VH_type2).
#
# Baseline test parameters: N=5, alpha=0.3, beta=0.9, r1=1.5, r2=2.5.


# =============================================================================
# R2 FUNCTIONS (terminal round)
# =============================================================================

#' W's optimal offer region in R2 with K=3 types.
#'
#' W faces three offers:
#'   Low  (y_H = alpha)       — only theta=0 accepts.
#'   Med  (y_H = alpha*r1)    — theta={0,1} accept.
#'   High (y_H = alpha*r2)    — all types accept.
#'
#' @param mu   length-3 belief vector (mu[1], mu[2], mu[3]), must sum to 1.
#' @param r1   scalar, V(theta=1). Must satisfy 1 < r1.
#' @param r2   scalar, V(theta=2). Must satisfy r1 < r2.
#' @param alpha scalar outside-option share for H (alpha in (0,1/r2)).
#' @return integer 1 (low), 2 (medium), or 3 (high).
screening_region_R2_k3 <- function(mu, r1, r2, alpha) {
  # W's surplus from each offer (W keeps all of V(theta) minus what it pays H,
  # conditional on acceptance; non-accepting types give 0 surplus).
  pi_low  <- mu[1] * (1 - alpha)
  pi_med  <- mu[1] * (1 - alpha * r1) + mu[2] * r1 * (1 - alpha)
  pi_high <- mu[1] * (1 - alpha * r2) + mu[2] * (r1 - alpha * r2) + mu[3] * r2 * (1 - alpha)
  which.max(c(pi_low, pi_med, pi_high))
}


#' H's R2 payoff vector for each type, K=3 types.
#'
#' H proposes with prob 1/N (keeps V(theta)), W proposes with prob (N-1)/N
#' (H gets the offer amount that W targeted).
#'
#' @param mu   length-3 belief vector.
#' @param r1,r2,alpha,N model parameters.
#' @return numeric(3): c(VH_theta0, VH_theta1, VH_theta2) in R2.
VH_R2_k3 <- function(mu, r1, r2, alpha, N) {
  region <- screening_region_R2_k3(mu, r1, r2, alpha)

  # When H proposes (prob 1/N), H keeps V(theta_k) (all-accept under unanimity
  # since H proposes a split that satisfies every W at continuation payoff).
  # When W proposes (prob (N-1)/N), H receives the targeted offer amount.
  #
  # Offer amounts: low=alpha, med=alpha*r1, high=alpha*r2.
  # Type k accepts iff offer >= alpha*V(theta_k).
  # Off-path (rejection) leads to R2 continuation — but in R2 there is no
  # further round, so rejection means 0. Thus we adopt the IC offer:
  # the W proposer picks y_H = alpha * V(theta_k^target).

  # H proposer payoff: V(theta) / N (H keeps all, buys N-1 Ws at 0 each in R2
  # terminal — W's continuation is 0 so W accepts any non-negative share).
  # Actually in R2 terminal: H proposes, keeps V(theta), W gets 0. But W
  # accepts iff offered >= 0 under unanimity, which is always satisfied when
  # H offers (V(theta), 0, ..., 0). So H_prop_k = V(theta_k) / N, where the
  # /N arises from the (1/N) probability that H is the proposer.
  # Wait — re-read K=2 code: H_prop_0 = (1 - (N-1)*beta*VW_R2) / N for R1.
  # For R2 (terminal), there is no discounting within R2, and W's continuation
  # value is 0, so H_prop_k = V(theta_k) / N.

  # W proposer: H gets the offer. Types that accept get the offer; types that
  # don't accept get 0 (no further rounds). So effectively if region=low, only
  # theta=0 is offered alpha (accepts); theta=1,2 are offered 0 effectively —
  # no, W offers a single amount. Let me be careful.
  #
  # W proposes a single y_H. The region determines which y_H maximises W.
  # Each type theta_k accepts iff y_H >= alpha * V(theta_k).
  #
  # Low  (y_H = alpha):       theta=0 accepts (1>=1), theta=1,2 reject (r1>1, r2>1).
  # Med  (y_H = alpha*r1):    theta=0,1 accept, theta=2 rejects.
  # High (y_H = alpha*r2):    all accept.
  #
  # Types that reject in R2 terminal get 0 (no continuation).
  # H's expected payoff when W proposes:
  #   = (prob W proposes) * (offer if type accepts, else 0)
  #   = (N-1)/N * (y_H * I(type accepts) + 0 * I(rejects))
  #
  # But we return type-specific payoffs VH[k]:
  #   VH[k] = H_prop[k] + W_prop[k]
  #         = V(theta_k)/N  +  (N-1)/N * y_H * I(theta_k accepts)

  V <- c(1, r1, r2)
  H_prop <- V / N  # prob 1/N * V(theta_k)

  if (region == 1) {
    # Low: y_H = alpha. theta=0 accepts, theta=1,2 reject.
    W_prop <- c((N-1)/N * alpha,
                0,
                0)
  } else if (region == 2) {
    # Med: y_H = alpha*r1. theta=0,1 accept, theta=2 rejects.
    W_prop <- c((N-1)/N * alpha * r1,
                (N-1)/N * alpha * r1,
                0)
  } else {
    # High: y_H = alpha*r2. All accept.
    W_prop <- c((N-1)/N * alpha * r2,
                (N-1)/N * alpha * r2,
                (N-1)/N * alpha * r2)
  }

  VH <- H_prop + W_prop
  return(VH)
}


#' W's expected R2 payoff (K=3 types).
#'
#' W proposes with prob 1/N: gets max(pi_low, pi_med, pi_high) / N.
#' W does NOT propose with prob (N-1)/N: but this is a *per-W* function, so
#' we return the expected payoff per W player = max_pi / N.
#' (Matches the K=2 pattern: VW_R2 = ... / N.)
#'
#' @inheritParams screening_region_R2_k3
#' @param N number of players.
#' @return scalar W's R2 expected payoff.
VW_R2_k3 <- function(mu, r1, r2, alpha, N) {
  pi_low  <- mu[1] * (1 - alpha)
  pi_med  <- mu[1] * (1 - alpha * r1) + mu[2] * r1 * (1 - alpha)
  pi_high <- mu[1] * (1 - alpha * r2) + mu[2] * (r1 - alpha * r2) + mu[3] * r2 * (1 - alpha)
  max(pi_low, pi_med, pi_high) / N
}


# =============================================================================
# 2-TYPE R2 SUBGAME FUNCTIONS
# Used after theta=0 is excluded (rejected low offer in R1).
# Residual belief: types theta=1 and theta=2 only.
# =============================================================================

#' Screening region in the 2-type R2 subgame on {theta=1, theta=2}.
#'
#' After theta=0 rejected the low R1 offer, beliefs update to:
#'   p1 = mu[2]/(mu[2]+mu[3])  (prob of theta=1 given not-theta=0)
#'   p2 = mu[3]/(mu[2]+mu[3])  (prob of theta=2 given not-theta=0)
#'
#' W's R2 sub-offers (for the {1,2} types):
#'   Sub-low  (y_H = alpha*r1): theta=1 indifferent (accepts), theta=2 rejects.
#'   Sub-high (y_H = alpha*r2): both accept.
#'
#' @return 1 (sub-low) or 2 (sub-high).
screening_region_R2_2type <- function(mu, r1, r2, alpha) {
  mass <- mu[2] + mu[3]
  if (mass < 1e-12) return(2L)  # degenerate: only theta=0 remains, pick arbitrary
  p1 <- mu[2] / mass   # conditional prob of theta=1
  p2 <- mu[3] / mass   # conditional prob of theta=2

  pi_sub_low  <- p1 * r1 * (1 - alpha)
  pi_sub_high <- p1 * (r1 - alpha * r2) + p2 * r2 * (1 - alpha)

  if (pi_sub_high >= pi_sub_low) 2L else 1L
}


#' H's R2 payoff in the 2-type subgame, for each original type.
#'
#' theta=0 is off-path but accepts whatever W offers (since any offer >= alpha
#' and the sub-game has r1-type or r2-type offers, both >= alpha*1).
#'
#' @inheritParams VH_R2_k3
#' @return numeric(3): payoffs for types theta=0,1,2 in the 2-type subgame.
VH_R2_2type_sub <- function(mu, r1, r2, alpha, N) {
  region <- screening_region_R2_2type(mu, r1, r2, alpha)

  V <- c(1, r1, r2)
  H_prop <- V / N  # prob 1/N * V(theta_k), proposing in terminal R2

  if (region == 1) {
    # Sub-low: y_H = alpha*r1. theta=0 (off-path) and theta=1 accept; theta=2 rejects.
    W_prop <- c((N-1)/N * alpha * r1,   # theta=0 off-path: gets alpha*r1
                (N-1)/N * alpha * r1,   # theta=1 accepts
                0)                       # theta=2 rejects, gets 0
  } else {
    # Sub-high: y_H = alpha*r2. All accept.
    W_prop <- c((N-1)/N * alpha * r2,
                (N-1)/N * alpha * r2,
                (N-1)/N * alpha * r2)
  }

  VH <- H_prop + W_prop
  return(VH)
}


#' W's expected payoff in the 2-type R2 subgame.
#'
#' Uses conditional beliefs over {theta=1, theta=2}.
#' Returns per-W payoff = max(pi_sub_low, pi_sub_high) / N.
#'
#' @inheritParams VH_R2_k3
#' @return scalar.
VW_R2_2type_sub <- function(mu, r1, r2, alpha, N) {
  mass <- mu[2] + mu[3]
  if (mass < 1e-12) return(0)
  p1 <- mu[2] / mass
  p2 <- mu[3] / mass

  pi_sub_low  <- p1 * r1 * (1 - alpha)
  pi_sub_high <- p1 * (r1 - alpha * r2) + p2 * r2 * (1 - alpha)

  # W's surplus is weighted by unconditional mass of the subgame population.
  # But VW_R2_2type_sub is the continuation value when W proposes in this
  # subgame. We return max payoff / N (matching VW_R2_k3 convention).
  max(pi_sub_low, pi_sub_high) / N
}


# =============================================================================
# R1 FUNCTIONS (first round, three possible R1 offer strategies for W)
# =============================================================================

#' H's expected R1 payoff under unanimity, K=3 types.
#'
#' Three R1 offer strategies for W as proposer:
#'   HIGH: y_H = beta * r2*(1+(N-1)*alpha) / N  [theta=2 indifferent, all accept]
#'   MED:  y_H = beta * (r1+(N-1)*alpha*r2) / N  [theta=1 indifferent; theta=2 rejects]
#'   LOW:  y_H = beta * VH_R2_2type_sub[1]        [theta=0 indifferent; theta={1,2} reject]
#'
#' W picks the strategy that maximises its R1 proposer surplus F_high/F_med/F_low.
#'
#' @param mu    length-3 prior belief vector c(mu0, mu1, mu2).
#' @param r1    V(theta=1).
#' @param r2    V(theta=2).
#' @param alpha outside-option share.
#' @param beta  discount factor.
#' @param N     number of players (1 H + N-1 Ws).
#' @return scalar: E[VH_R1] = sum(mu * VH_R1_vector).
VH_R1_k3_unanimity <- function(mu, r1, r2, alpha, beta, N) {
  mu0 <- mu[1]; mu1 <- mu[2]; mu2 <- mu[3]

  # ------------------------------------------------------------------
  # Step (a): R2 continuation values at current beliefs
  # ------------------------------------------------------------------
  VW_R2   <- VW_R2_k3(mu, r1, r2, alpha, N)
  VH_R2   <- VH_R2_k3(mu, r1, r2, alpha, N)       # length-3
  VH_2sub <- VH_R2_2type_sub(mu, r1, r2, alpha, N) # length-3
  VW_2sub <- VW_R2_2type_sub(mu, r1, r2, alpha, N) # scalar

  # omega: (N-2) other Ws each receive beta*VW_R2 as non-proposers
  # (their continuation value in R1 when someone else proposes and the deal passes)
  omega <- (N - 2) * beta * VW_R2

  # ------------------------------------------------------------------
  # Step (b): R1 offer levels (W as proposer)
  # These are what W offers H to make type theta_k indifferent.
  # ------------------------------------------------------------------
  # HIGH: makes theta=2 (highest type) indifferent between accepting and R2.
  #   theta=2 indifferent: y_high = beta * VH_R2[3]
  #   VH_R2[3] = r2*(1+(N-1)*alpha)/N (always; theta=2 always accepts in R2)
  y_high <- beta * r2 * (1 + (N-1)*alpha) / N

  # MED: makes theta=1 indifferent between accepting and going to R2.
  #   theta=1 in R2 with full 3-type beliefs: VH_R2[2]
  #   Under full beliefs, if R2 region is NOT high, theta=1's R2 payoff differs.
  #   However, if theta=2 rejects the MED offer and goes to R2, then in R2 we
  #   have beliefs (mu0, mu1, mu2) still — but wait, theta=2 rejected means
  #   beliefs in R2 are (mu0/(mu0+mu1), mu1/(mu0+mu1), 0). But that is after
  #   on-path rejection by theta=2, so beliefs update. Let's be precise:
  #
  #   Under MED strategy: theta=2 rejects (gets beta*VH_R2_certain_theta2).
  #   "Certain theta=2" means beliefs (0,0,1) in R2.
  #   VH_R2(beliefs=(0,0,1), theta=2) = r2*(1+(N-1)*alpha)/N.
  #
  #   theta=1 indifferent between y_med and beta*VH_R2[2] at beliefs (mu0,mu1,mu2).
  #   BUT: if theta=2 rejects, the R2 subgame has beliefs updating on {0,1}.
  #   On the equilibrium path of MED, theta=2 rejects and beliefs become
  #   (mu0/(mu0+mu1), mu1/(mu0+mu1), 0). theta=1's R2 payoff at those beliefs:
  #
  #   However, to make theta=1 indifferent, we use the R2 payoff that theta=1
  #   expects when theta=2 has rejected (beliefs concentrate on {0,1}).
  #   At beliefs (mu0', mu1', 0): VH_R2 for theta=1 = ? That depends on
  #   whether W in R2 plays low or med in the {0,1} 2-type sub.
  #
  #   Since this gets complex, we use VH_R2[2] at full current beliefs as the
  #   reference, following the same approach as the K=2 code which uses
  #   VH_R2 at current beliefs to set the indifference offer.
  #   The key simplification in K=2: y_con = beta*(r+x)/N where x=(N-1)*alpha*r
  #   = beta * VH_R2(theta=1, all-accept R2). In K=3: analogously,
  #   y_med = beta * VH_R2[2] — but we must use the R2 payoff for theta=1
  #   in the HIGH region (alpha*r2 offered), since under MED, theta=2 rejects
  #   and goes to R2 with beliefs that certify theta IN {0,1}; in that 2-type
  #   R2, W offers alpha*r1 (sub-low) or alpha*r2 (sub-high) to {0,1} types.
  #   For theta=1, the best R2 outcome is (r1+(N-1)*alpha*r2)/N (sub-high offer).
  #
  #   Per the task specification: y_med = beta * (r1 + (N-1)*alpha*r2) / N
  #   which corresponds to W offering alpha*r2 in R2 (sub-high for the {0,1}
  #   types), making theta=1 indifferent.
  y_med <- beta * (r1 + (N-1)*alpha*r2) / N

  # LOW: makes theta=0 indifferent between accepting and going to R2.
  #   theta=0's R2 payoff in the 2-type subgame (beliefs on {1,2} after theta=0 rejects):
  #   VH_2sub[1] = theta=0's payoff in the 2-type R2 subgame (off-path but defined).
  y_low <- beta * VH_2sub[1]

  # ------------------------------------------------------------------
  # Step (c): W's proposer surplus from each strategy
  # ------------------------------------------------------------------
  Ve <- mu0 * 1 + mu1 * r1 + mu2 * r2  # expected pie = E[V(theta)]

  # F_high: all accept. W gets Ve - y_high for each type (weighted).
  # omega covers other Ws' continuation. F_high is W proposer's surplus net of
  # payments to H and to other Ws (omega).
  F_high <- Ve - y_high - omega

  # F_med: theta={0,1} accept at y_med; theta=2 rejects and goes to R2.
  # theta=2's continuation for W: beta * VW_R2_certain_theta2 per W.
  # At beliefs (0,0,1): VW_R2 = r2*(1-alpha)/N.
  VW_R2_t2_certain <- r2 * (1 - alpha) / N
  # omega for {0,1}: (N-2)*beta*VW_R2 (same, since deal passes and W gets VW_R2 continuation)
  # omega for {2}: theta=2 rejects, goes to R2 with beliefs (0,0,1), other Ws get
  #   (N-2)*beta*VW_R2_t2_certain. But F_med is the expected payoff:
  F_med <- (mu0 * (1 - y_med - omega) +
            mu1 * (r1 - y_med - omega) +
            mu2 * beta * r2 * (1 - alpha) / N)
  # Note: mu2 term: theta=2 rejects, goes to R2 with certain theta=2, W gets
  # r2*(1-alpha)/N in that R2. The (N-2)*omega doesn't apply for theta=2 because
  # the deal doesn't pass for theta=2. We include theta=2's contribution to W
  # proposer as beta * VW_R2_t2_certain = beta * r2*(1-alpha)/N.

  # F_low: theta=0 accepts at y_low; theta={1,2} reject and go to 2-type R2.
  # theta=0: W gets 1 - y_low - omega.
  # theta={1,2}: W goes to 2-type R2, gets beta * VW_R2_2type_sub (per W).
  # BUT: the 2-type subgame VW must be scaled by the conditional mass that
  # arrives at R2. Since theta={1,2} rejected, W gets beta*VW_2sub for those types.
  F_low <- (mu0 * (1 - y_low - omega) +
            (mu1 + mu2) * beta * VW_2sub)

  # ------------------------------------------------------------------
  # Step (d): W picks the strategy that maximises F
  # ------------------------------------------------------------------
  F_vec <- c(F_low, F_med, F_high)
  strategy <- which.max(F_vec)  # 1=LOW, 2=MED, 3=HIGH

  # ------------------------------------------------------------------
  # Step (e): H proposes (prob 1/N)
  # H keeps V(theta_k), pays (N-1)*beta*VW_R2 to each of N-1 Ws.
  # H_prop[k] = (V(theta_k) - (N-1)*beta*VW_R2) / N
  # ------------------------------------------------------------------
  V <- c(1, r1, r2)
  H_prop <- (V - (N-1) * beta * VW_R2) / N

  # ------------------------------------------------------------------
  # Step (f): W proposes (prob (N-1)/N): H receives the offer
  # ------------------------------------------------------------------
  if (strategy == 3) {
    # HIGH: all types accept y_high.
    W_prop <- rep((N-1)/N * y_high, 3)

  } else if (strategy == 2) {
    # MED: theta={0,1} accept y_med; theta=2 rejects and gets beta*VH_R2_certain_theta2.
    # VH at beliefs (0,0,1) for theta=2 in R2: r2*(1+(N-1)*alpha)/N.
    VH_R2_t2_certain <- r2 * (1 + (N-1)*alpha) / N
    W_prop <- c((N-1)/N * y_med,
                (N-1)/N * y_med,
                (N-1)/N * beta * VH_R2_t2_certain)

  } else {
    # LOW: theta=0 accepts y_low; theta={1,2} reject and go to 2-type R2.
    W_prop <- c((N-1)/N * y_low,
                (N-1)/N * beta * VH_2sub[2],
                (N-1)/N * beta * VH_2sub[3])
  }

  # ------------------------------------------------------------------
  # Step (g): Combine and return expected payoff
  # ------------------------------------------------------------------
  VH_vec <- H_prop + W_prop
  EVH <- sum(mu * VH_vec)
  return(EVH)
}


#' W's expected R1 payoff under unanimity, K=3 types.
#'
#' Mirrors VH_R1_k3_unanimity but returns W's perspective.
#'
#' @inheritParams VH_R1_k3_unanimity
#' @return scalar W's expected R1 payoff.
VW_R1_k3_unanimity <- function(mu, r1, r2, alpha, beta, N) {
  mu0 <- mu[1]; mu1 <- mu[2]; mu2 <- mu[3]

  # R2 continuation values
  VW_R2   <- VW_R2_k3(mu, r1, r2, alpha, N)
  VH_2sub <- VH_R2_2type_sub(mu, r1, r2, alpha, N)
  VW_2sub <- VW_R2_2type_sub(mu, r1, r2, alpha, N)

  omega <- (N - 2) * beta * VW_R2

  # Offer levels (same as in VH_R1_k3_unanimity)
  y_high <- beta * r2 * (1 + (N-1)*alpha) / N
  y_med  <- beta * (r1 + (N-1)*alpha*r2) / N
  y_low  <- beta * VH_2sub[1]

  Ve <- mu0 * 1 + mu1 * r1 + mu2 * r2

  VW_R2_t2_certain <- r2 * (1 - alpha) / N

  F_high <- Ve - y_high - omega
  F_med  <- (mu0 * (1 - y_med - omega) +
             mu1 * (r1 - y_med - omega) +
             mu2 * beta * r2 * (1 - alpha) / N)
  F_low  <- (mu0 * (1 - y_low - omega) +
             (mu1 + mu2) * beta * VW_2sub)

  F_vec <- c(F_low, F_med, F_high)
  strategy <- which.max(F_vec)
  F_proposer <- max(F_vec)

  # Non-proposer W's continuation depends on strategy:
  if (strategy == 3) {
    # HIGH: all deals pass in R1. Non-proposer W gets beta*VW_R2 regardless.
    nonprop <- (N - 1) / N * beta * VW_R2

  } else if (strategy == 2) {
    # MED: theta={0,1} accept (deal passes), theta=2 rejects (R2 with certain theta=2).
    # VW_R2 at beliefs (0,0,1): r2*(1-alpha)/N.
    # Non-proposer W payoff:
    #   - H proposes (1/N): deal always passes → beta*VW_R2
    #   - Other W proposes (N-2)/N: deal passes for theta={0,1} → beta*VW_R2;
    #                               deal fails for theta=2 → beta*VW_R2_t2_certain
    nonprop <- (beta * VW_R2 / N +
                (N - 2) / N * ((mu0 + mu1) * beta * VW_R2 +
                               mu2 * beta * VW_R2_t2_certain))

  } else {
    # LOW: theta=0 accepts (deal passes), theta={1,2} reject (2-type R2).
    # Non-proposer W payoff:
    #   - H proposes (1/N): deal always passes → beta*VW_R2
    #   - Other W proposes (N-2)/N: deal passes for theta=0 → beta*VW_R2;
    #                               deal fails for theta={1,2} → beta*VW_2sub
    nonprop <- (beta * VW_R2 / N +
                (N - 2) / N * (mu0 * beta * VW_R2 +
                               (mu1 + mu2) * beta * VW_2sub))
  }

  VW_R1 <- F_proposer / N + nonprop
  return(VW_R1)
}


# =============================================================================
# MAJORITY RULE (no screening, works for any K)
# =============================================================================

#' H's expected R1 payoff under majority K=3
#' Key property: affine in V_e(mu) = mu[1] + mu[2]*r1 + mu[3]*r2
VH_R1_k3_majority <- function(mu, r1, r2, alpha, beta, N) {
  q <- floor(N/2) + 1
  Ve <- mu[1] + mu[2] * r1 + mu[3] * r2
  VW_R2_M <- (1 - alpha) * Ve / N
  H_prop <- (Ve - (q - 1) * beta * VW_R2_M) / N
  W_prop_H <- (N - 1) / N * alpha * Ve
  H_prop + W_prop_H
}

#' W's expected R1 payoff under majority K=3
VW_R1_k3_majority <- function(mu, r1, r2, alpha, beta, N) {
  Ve <- mu[1] + mu[2] * r1 + mu[3] * r2
  EVH <- VH_R1_k3_majority(mu, r1, r2, alpha, beta, N)
  (Ve - EVH) / (N - 1)
}


# =============================================================================
# VERIFICATION BLOCK
# =============================================================================

if (!exists("k3_screening_skip_verify")) {
  cat("=== K=3 Screening Verification ===\n\n")

  # Baseline parameters
  N     <- 5
  alpha <- 0.3
  beta  <- 0.9
  r1    <- 1.5
  r2    <- 2.5

  # -------------------------------------------------------------------
  # R2 Corner Checks
  # -------------------------------------------------------------------
  cat("--- R2 Corner Checks ---\n")

  # (1,0,0): only theta=0 present → low region, VH[1] = (1+(N-1)*alpha)/N
  mu_100 <- c(1, 0, 0)
  reg_100 <- screening_region_R2_k3(mu_100, r1, r2, alpha)
  VH_100  <- VH_R2_k3(mu_100, r1, r2, alpha, N)
  expected_VH0 <- (1 + (N-1)*alpha) / N
  cat(sprintf("mu=(1,0,0): region=%d (expect 1), VH[1]=%.6f (expect %.6f), OK=%s\n",
              reg_100, VH_100[1], expected_VH0,
              ifelse(reg_100==1 && abs(VH_100[1]-expected_VH0)<1e-10, "YES", "NO")))

  # (0,1,0): only theta=1 present → medium region, VH[2] = r1*(1+(N-1)*alpha)/N
  mu_010 <- c(0, 1, 0)
  reg_010 <- screening_region_R2_k3(mu_010, r1, r2, alpha)
  VH_010  <- VH_R2_k3(mu_010, r1, r2, alpha, N)
  expected_VH1 <- r1 * (1 + (N-1)*alpha) / N
  cat(sprintf("mu=(0,1,0): region=%d (expect 2), VH[2]=%.6f (expect %.6f), OK=%s\n",
              reg_010, VH_010[2], expected_VH1,
              ifelse(reg_010==2 && abs(VH_010[2]-expected_VH1)<1e-10, "YES", "NO")))

  # (0,0,1): only theta=2 present → high region, VH[3] = r2*(1+(N-1)*alpha)/N
  mu_001 <- c(0, 0, 1)
  reg_001 <- screening_region_R2_k3(mu_001, r1, r2, alpha)
  VH_001  <- VH_R2_k3(mu_001, r1, r2, alpha, N)
  expected_VH2 <- r2 * (1 + (N-1)*alpha) / N
  cat(sprintf("mu=(0,0,1): region=%d (expect 3), VH[3]=%.6f (expect %.6f), OK=%s\n",
              reg_001, VH_001[3], expected_VH2,
              ifelse(reg_001==3 && abs(VH_001[3]-expected_VH2)<1e-10, "YES", "NO")))

  # -------------------------------------------------------------------
  # K=2 Reduction: r1=r2=r, mu[3]=0 → must match K=2 functions
  # -------------------------------------------------------------------
  cat("\n--- K=2 Reduction Check (r1=r2=r, mu[3]=0) ---\n")

  # K=2 reference functions (from formal_model_v2.Rmd)
  VH_R1_unanimity <- function(r, alpha, mu, N, beta) {
    x <- (N - 1) * alpha * r
    mu_s_R2 <- alpha * (r - 1) / (r - alpha)
    Ve <- 1 + mu * (r - 1)
    if (mu < mu_s_R2) {
      VW_R2 <- (1 - mu) * (1 - alpha) / N
    } else {
      VW_R2 <- (Ve - alpha * r) / N
    }
    omega <- (N - 2) * beta * VW_R2
    F1_con <- Ve - beta * (r + x) / N - omega
    F1_agg <- (1 - mu) * (1 - beta * (1 + x) / N - omega) + mu * beta * r * (1 - alpha) / N
    H_prop_0 <- (1 - (N - 1) * beta * VW_R2) / N
    H_prop_1 <- (r - (N - 1) * beta * VW_R2) / N
    if (F1_agg > F1_con) {
      VH_0 <- H_prop_0 + (N - 1) * beta * (1 + x) / (N^2)
      VH_1 <- H_prop_1 + (N - 1) * beta * (r + x) / (N^2)
    } else {
      VH_0 <- H_prop_0 + (N - 1) * beta * (r + x) / (N^2)
      VH_1 <- H_prop_1 + (N - 1) * beta * (r + x) / (N^2)
    }
    mu * VH_1 + (1 - mu) * VH_0
  }

  VW_R1_unanimity <- function(r, alpha, mu, N, beta) {
    x <- (N - 1) * alpha * r
    mu_s_R2 <- alpha * (r - 1) / (r - alpha)
    Ve <- 1 + mu * (r - 1)
    if (mu < mu_s_R2) {
      VW_R2 <- (1 - mu) * (1 - alpha) / N
    } else {
      VW_R2 <- (Ve - alpha * r) / N
    }
    omega <- (N - 2) * beta * VW_R2
    F1_con <- Ve - beta * (r + x) / N - omega
    F1_agg <- (1 - mu) * (1 - beta * (1 + x) / N - omega) + mu * beta * r * (1 - alpha) / N
    F_proposer <- max(F1_agg, F1_con)
    if (F1_agg > F1_con) {
      VW_R2_1 <- r * (1 - alpha) / N
      nonprop <- beta * VW_R2 / N + (N - 2) / N * ((1 - mu) * beta * VW_R2 + mu * beta * VW_R2_1)
    } else {
      nonprop <- (N - 1) / N * beta * VW_R2
    }
    F_proposer / N + nonprop
  }

  r_test <- 1.5
  mu_vals <- c(0.1, 0.3, 0.5, 0.7, 0.9)
  cat("mu_val   K2_VH       K3_VH       err_VH     K2_VW       K3_VW       err_VW\n")
  all_pass <- TRUE
  for (mu_val in mu_vals) {
    mu_k3 <- c(1 - mu_val, mu_val, 0)
    k2_VH <- VH_R1_unanimity(r_test, alpha, mu_val, N, beta)
    k3_VH <- VH_R1_k3_unanimity(mu_k3, r_test, r_test, alpha, beta, N)
    k2_VW <- VW_R1_unanimity(r_test, alpha, mu_val, N, beta)
    k3_VW <- VW_R1_k3_unanimity(mu_k3, r_test, r_test, alpha, beta, N)
    err_VH <- abs(k2_VH - k3_VH)
    err_VW <- abs(k2_VW - k3_VW)
    ok <- err_VH < 1e-8 && err_VW < 1e-8
    if (!ok) all_pass <- FALSE
    cat(sprintf("%.1f      %.6f    %.6f    %.2e   %.6f    %.6f    %.2e   %s\n",
                mu_val, k2_VH, k3_VH, err_VH, k2_VW, k3_VW, err_VW,
                ifelse(ok, "OK", "FAIL")))
  }
  cat(sprintf("\nK=2 reduction: %s\n", ifelse(all_pass, "ALL PASS", "SOME FAILED")))

  # -------------------------------------------------------------------
  # Sanity: R1 values at K=3 baseline
  # -------------------------------------------------------------------
  cat("\n--- K=3 Baseline (N=5, alpha=0.3, beta=0.9, r1=1.5, r2=2.5) ---\n")
  mu_test <- c(0.4, 0.35, 0.25)
  cat(sprintf("mu = (%.2f, %.2f, %.2f)\n", mu_test[1], mu_test[2], mu_test[3]))
  VH_k3 <- VH_R1_k3_unanimity(mu_test, r1, r2, alpha, beta, N)
  VW_k3 <- VW_R1_k3_unanimity(mu_test, r1, r2, alpha, beta, N)
  Ve_k3 <- sum(mu_test * c(1, r1, r2))
  cat(sprintf("VH_R1 = %.6f\n", VH_k3))
  cat(sprintf("VW_R1 = %.6f\n", VW_k3))
  cat(sprintf("Ve    = %.6f\n", Ve_k3))
  budget_check <- abs(VH_k3 + (N-1) * VW_k3 - Ve_k3)
  cat(sprintf("Budget check |VH + (N-1)*VW - Ve| = %.2e  %s\n",
              budget_check, ifelse(budget_check < 1e-6, "(OK)", "(WARN)")))

  cat("\n--- Majority Checks ---\n")
  # Affinity check: lambda_M * Ve
  q <- floor(N/2) + 1
  lambda_M <- (N * (1 + (N-1)*alpha) - beta * (q-1) * (1-alpha)) / N^2

  set.seed(42)
  cat("Affinity (VH_M = lambda_M * Ve):\n")
  for (i in 1:5) {
    mu_test <- runif(3); mu_test <- mu_test / sum(mu_test)
    Ve <- mu_test[1] + mu_test[2] * r1 + mu_test[3] * r2
    evh <- VH_R1_k3_majority(mu_test, r1, r2, alpha, beta, N)
    expected <- lambda_M * Ve
    err <- abs(evh - expected)
    cat(sprintf("  test %d: err=%.2e %s\n", i, err, ifelse(err < 1e-10, "OK", "FAIL")))
  }

  # K=2 reduction for majority
  VH_R1_majority <- function(r, alpha, mu, N, beta) {
    q <- floor(N/2) + 1; Ve <- 1 + mu * (r - 1)
    VW_R2_M <- (1 - alpha) * Ve / N
    H_prop <- (Ve - (q - 1) * beta * VW_R2_M) / N
    W_prop_H <- (N - 1) / N * alpha * Ve
    H_prop + W_prop_H
  }

  cat("K=2 reduction (majority):\n")
  for (mu_val in c(0.2, 0.5, 0.8)) {
    mu_k3 <- c(1 - mu_val, mu_val, 0)
    evh_k3 <- VH_R1_k3_majority(mu_k3, 1.5, 1.5, alpha, beta, N)
    evh_k2 <- VH_R1_majority(1.5, alpha, mu_val, N, beta)
    err <- abs(evh_k3 - evh_k2)
    cat(sprintf("  mu=%.1f: err=%.2e %s\n", mu_val, err, ifelse(err < 1e-10, "OK", "FAIL")))
  }

  # -------------------------------------------------------------------
  # MED strategy coverage (quality review gap)
  # -------------------------------------------------------------------
  cat("\n--- MED Strategy Test ---\n")
  # Find a belief where MED is optimal and verify budget identity
  mu_med_test <- c(0.05, 0.75, 0.20)  # heavy theta=1: MED is optimal here
  VW_R2_t <- VW_R2_k3(mu_med_test, r1, r2, alpha, N)
  omega_t <- (N - 2) * beta * VW_R2_t
  Ve_t <- sum(mu_med_test * c(1, r1, r2))
  y_high_t <- beta * r2 * (1 + (N-1)*alpha) / N
  y_med_t <- beta * (r1 + (N-1)*alpha*r2) / N
  VH_2sub_t <- VH_R2_2type_sub(mu_med_test, r1, r2, alpha, N)
  y_low_t <- beta * VH_2sub_t[1]
  VW_2sub_t <- VW_R2_2type_sub(mu_med_test, r1, r2, alpha, N)
  VW_R2_t2 <- r2 * (1 - alpha) / N
  F_low_t  <- mu_med_test[1]*(1 - y_low_t - omega_t) + (mu_med_test[2]+mu_med_test[3])*beta*VW_2sub_t
  F_med_t  <- mu_med_test[1]*(1 - y_med_t - omega_t) + mu_med_test[2]*(r1 - y_med_t - omega_t) + mu_med_test[3]*beta*VW_R2_t2
  F_high_t <- Ve_t - y_high_t - omega_t
  strat_t <- which.max(c(F_low_t, F_med_t, F_high_t))
  cat(sprintf("  mu=(%.2f,%.2f,%.2f): F_low=%.4f, F_med=%.4f, F_high=%.4f -> strategy=%d\n",
              mu_med_test[1], mu_med_test[2], mu_med_test[3], F_low_t, F_med_t, F_high_t, strat_t))
  VH_med <- VH_R1_k3_unanimity(mu_med_test, r1, r2, alpha, beta, N)
  VW_med <- VW_R1_k3_unanimity(mu_med_test, r1, r2, alpha, beta, N)
  budget_med <- abs(VH_med + (N-1)*VW_med - Ve_t)
  # Budget gap expected: MED has theta=2 rejection → surplus destruction from discounting
  cat(sprintf("  VH=%.6f, VW=%.6f, Budget gap=%.4f (expected: theta=2 rejection destroys surplus)\n",
              VH_med, VW_med, budget_med))

  cat("\n=== Verification complete ===\n")
}
