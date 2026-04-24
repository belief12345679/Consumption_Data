---
marp: true
theme: default
paginate: true
style: |
  section {
    font-size: 24px;
  }
---

# Deriving the Relaxation Time Formula
**Bridging Physics and Econometrics**

This derivation elegantly connects continuous-time physical concepts (decay processes) with the discrete-time series models (econometrics) used in actual data analysis.

---

## Step 1: System Recovery in Continuous Time (Physics Perspective)

Assume a system deviates from its equilibrium due to an external shock. Without new shocks, it naturally recovers. In classic models (like Newton's law of cooling or the Ornstein-Uhlenbeck process in finance), **the speed of recovery is proportional to the current deviation.**

Expressed as a differential equation, the rate of change of the deviation $y(t)$ is:

$$\frac{dy(t)}{dt} = -k y(t)$$

Here, $k > 0$ is the **decay rate**. The negative sign ensures the deviation shrinks toward $0$. 

Solving this first-order ODE gives the state at any time $t$:

$$y(t) = y_0 e^{-kt}$$

*(Where $y_0$ is the initial deviation at the moment of the shock. This shows the shock decays exponentially.)*

---

## Step 2: The Rigorous Definition of "Relaxation Time"

In physics and engineering, we don't ask "when will the system reach exactly $0$?" (as exponential functions only infinitely approach $0$). Instead, we ask:

**"How long does it take for the system to decay to $1/e$ (approx. 36.8%) of its initial shock scale?"** This specific duration is defined as the **Relaxation Time ($\tau$)**.

By definition, when $t = \tau$, $y(\tau) = y_0 e^{-1}$. Substituting this into our solution:

$$y_0 e^{-k\tau} = y_0 e^{-1}$$

Canceling $y_0$ and comparing the exponents:

$$k\tau = 1 \implies \tau = \frac{1}{k}$$

*Conclusion: Relaxation time is the reciprocal of the decay rate $k$.*

---

## Step 3: Mapping Continuous to Discrete Time Series

In reality (e.g., with CPI or consumption data), we cannot observe data continuously. We sample at fixed intervals, let's call it $\Delta t$ (e.g., monthly).

Looking at two points separated by $\Delta t$, based on the Step 1 solution:

$$y(t+\Delta t) = y(t) e^{-k\Delta t}$$

When we introduce the continuous random shocks of the real world (the noise term $\sigma \eta_t$), this becomes the standard **discrete AR(1) model**:

$$y_{t+1} = C y_t + \sigma \eta_t$$

Comparing these two equations reveals the core relationship: the regression coefficient $C$ is the specific manifestation of the continuous decay equation over interval $\Delta t$:

$$C = e^{-k\Delta t}$$

---

## Step 4: Deriving the Final Formula

We now have the two necessary pieces:
1. Relaxation Time: $\tau = \frac{1}{k}$
2. Discrete Model Coefficient: $C = e^{-k\Delta t}$

We need to convert $C$ and $\Delta t$ (which you can calculate from data) into $\tau$.

First, take the natural logarithm ($\ln$) of both sides of the coefficient equation:
$$\ln(C) = -k\Delta t$$

Next, solve for the unknown decay rate $k$:
$$k = -\frac{\ln(C)}{\Delta t}$$

Finally, substitute $k$ into the definition of $\tau$:
$$\tau = \frac{1}{-\frac{\ln(C)}{\Delta t}}$$

Rearranging gives the final formula:
$$\tau = -\frac{\Delta t}{\ln(C)}$$

---

## Summary & Application Notes

* The regression coefficient $C$ acts as the system's **"retention rate."** * Because $0 < C < 1$, its natural logarithm $\ln(C)$ will always be a negative number. The negative sign in the formula cancels this out, ensuring $\tau$ is positive.
* **Practical shortcut:** If your data is monthly ($\Delta t = 1$), the formula simplifies nicely to:
  
  $$\tau = -\frac{1}{\ln(C)}$$---
marp: true
theme: default
paginate: true
style: |
  section {
    font-size: 24px;
  }
---