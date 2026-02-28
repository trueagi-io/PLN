# Probabilistic Logic Networks (PLN)
This repository implements a MeTTa-native Probabilistic Logic Networks (PLN) reasoner intended for practical, resource-aware uncertain inference and designed to work with the MeTTa / Hyperon ecosystem. It incorporates key PLN ideas such as multi-component truth-values, explicit evidence tracking, and rule-based inference, while supporting deductive, inductive, and abductive inference under uncertainty. The system is designed for seamless embedding into MeTTa programs and emphasizes inference control for scalable reasoning.

## Key features
* Multi-component probabilistic truth-values: the implementation uses Simple Truth Value (STV) as `(strength, confidence)` and propagates these values through inference and revision rules. 
* Evidence tracking: Each statement includes an EvidenceID allowing the system to use these IDs to detect when evidence overlaps to avoid double-counting or to make a choice. 
* Resource-bounded inference control: Inference is limited by a horizon and queue size, using a priority queue (confidence-based) to focus on the most important tasks and reduce unnecessary computation.
* Compact API (PLN.Derive, PLN.Query): these functions support embedding PLN inference into MeTTa code, returning either the full derived knowledge state or the best-supported answer to a query term. 
* Executable examples tests: examples (e.g., Smokes, FlyingRaven) illustrate multi-step inference; the test harness runs .metta artifacts via the PeTTa runner to provide regression coverage. 

## Theoretical foundations
Probabilistic Logic Networks (PLN) provide a pragmatic framework for uncertain logical inference, developed in the context of AGI research and grounded in the Assumption of Insufficient Knowledge and Resources (AIKR). PLN integrates deductive, inductive, and abductive reasoning with mechanisms for uncertainty quantification and resource-bounded inference control.

Uncertainty is modeled using multi-component truth values rather than a single probability. The foundational Simple Truth Value (STV) is represented as a pair _⟨strength, confidence⟩_, where _strength_ serves as a probability-like measure of belief, and _confidence_ reflects the evidential support underlying that belief.

The framework emphasizes three essential properties for real-world reasoning under uncertainty:
* Explicit truth-value formulas for inference rules (Deduction, Abduction, Induction, Modus Ponens, etc.)
* Evidence revision mechanisms that combine and track support from multiple sources
* Inference control strategies to mitigate combinatorial explosion during forward reasoning

These elements enable PLN to operate effectively in domains where information is incomplete, uncertain, or evolving, while maintaining semantic rigor and computational feasibility.


## Installation

To use PLN, start by setting up the PeTTa/MeTTa environment:

1. PeTTa: `git clone https://github.com/trueagi-io/PeTTa`

2. Add the PLN repository under a `repos` directory in the PeTTa workspace:
```
cd PeTTa
mkdir repos
cd repos
git clone https://github.com/trueagi-io/PLN
```
3. Your workspace should now contain both PeTTa and PLN code.

## Usage
From the PeTTa root folder, example reasoning scripts can be executed using:
```
sh ./run.sh ./repos/PLN/examples/<ExampleFile>.metta
```

For instance the famous Tuffy Smokes example:
```
sh ./run.sh ./repos/PLN/examples/Smokes.metta
```

## Running Tests:

```
cd ./repos/PLN
sh test.sh
```

## Integration in MeTTa Code
To import and use PLN within a MeTTa program use import mechanism as:
```
!(import! &self (library lib_import))
!(git-import! "https://github.com/trueagi-io/PLN.git")
!(import! &self (library PLN lib_pln))
```
Once imported, you can perform inference tasks via the provided interface.

## Examples
The `examples/` folder includes .metta scripts demonstrating:
* Reasoning under uncertainty
* Handling conflicting evidence
* Multi-step inference chains
* Planning or procedural resoning tasks
Use these as starting points to learn before building your own reasoning scenarios.

## Documentation
Please check out the [PLN Wiki](https://github.com/trueagi-io/PLN/wiki)

## License
MIT License — see the LICENSE file in the repository for details.
