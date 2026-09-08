# R1 majority conditional interface
Source: architecture_note.Rmd section 2.4. Input: exact R2_M.md.
Weak cutoff w=beta/m. Count n_Y of weak respondents with x_j>=w.
If n_Y>=k: H compares x_H to max(x_H,o); Y iff x_H>=o.
If n_Y=k-1: H compares x_H to beta*o; Y iff x_H>=beta*o.
If n_Y<=k-2: both H votes lead to beta*o, hence Y.
Optimal passing without H: x_H=0, k weak respondents each w, residual 1-k*w.
Pivotal candidates: beta*ell (screening) or beta*h (pooling), k-1 weak respondents each w.
PiE=1-k*w; PiS=(1-p)*(1-(k-1)*w-beta*ell)+p*w; PiP=1-(k-1)*w-beta*h; PiD=w.
Respect feasibility. PiE-PiD>0. Preserve proposer min-H tie and common proposal weights.
Full private classification is transported relative to historical G0 by C4; not an independent recertification of all legacy assertions.
