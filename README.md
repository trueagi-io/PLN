# PLN
Modern PLN implementation for Hyperon


## Theoretical foundations
Probabilistic Logic Networks (PLN) provide a pragmatic framework for uncertain logical inference, developed in the context of AGI research and grounded in the Assumption of Insufficient Knowledge and Resources (AIKR). PLN integrates deductive, inductive, and abductive reasoning with mechanisms for uncertainty quantification and resource-bounded inference control.

Uncertainty is modeled using multi-component truth values rather than a single probability. The foundational Simple Truth Value (STV) is represented as a pair _⟨strength, confidence⟩_, where _strength_ serves as a probability-like measure of belief, and _confidence_ reflects the evidential support underlying that belief.

The framework emphasizes three essential properties for real-world reasoning under uncertainty:
* Explicit truth-value formulas for inference rules (Deduction, Abduction, Induction, Modus Ponens, etc.)
* Evidence revision mechanisms that combine and track support from multiple sources
* Inference control strategies to mitigate combinatorial explosion during forward reasoning

These elements enable PLN to operate effectively in domains where information is incomplete, uncertain, or evolving, while maintaining semantic rigor and computational feasibility.

## Wiki
Please check out the [PLN Wiki](https://github.com/trueagi-io/PLN/wiki)
