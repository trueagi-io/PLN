# PLN v0.6 — Release Notes

## Overview

PLN v0.6 transitions the Probabilistic Logic Networks (PLN) reasoner to a PeTTa-based foundation, solidifying its role as a core reasoning component within the MeTTa / Hyperon ecosystem. This release does not introduce new reasoning semantics, rather, it emphasizes integration, maintainability, and execution reliability, building directly on the already functional and efficient reasoner introduced in v0.5.

## Key Changes
#### PeTTa-based Architecture
* Reworked the PLN implementation to be used with PeTTa transpiler 
* Improves consistency with MeTTa tooling and surrounding infrastructure
* Establishes a clearer long-term maintainable foundation for future research, extensions and optimizations

#### Stability & Execution Improvements
* More stable and predictable execution behavior
* Reasoning pipeline benefits from tighter coupling with the underlying runtime
* Reduced friction when running PLN examples in modern MeTTa environments

#### Ecosystem Alignment
* Positions PLN as a reasoning engine rather than a standalone prototype
* Aligns internal representations and execution model with the broader MeTTa / Hyperon stack

## What Did Not Change
* Core declarative reasoning capabilities (deductive, inductive, abductive)
* Priority-queue–based, resource-bounded derivation strategies introduced in v0.5
* Focus on truth-value propagation and reasoning under uncertainty
  
PLN 0.6 is an architectural and infrastructural evolution, not a redesign of reasoning semantics.

## Who Should Upgrade
* Users integrating PLN into MeTTa- or PeTTa-based systems
* Developers building larger reasoning pipelines on top of PLN
* Anyone seeking a more stable foundation for extending PLN

If you are already using v0.5 examples and workflows, expect minimal conceptual changes, but improved integration behavior.

## Summary
PLN v0.6 consolidates the reasoner’s architectural foundation through PeTTa-based integration while preserving its established inference mechanisms. The release strengthens interoperability, execution robustness, and maintainability, positioning PLN as a stable component within the MeTTa / Hyperon ecosystem.

## Wiki
Please check out the [PLN Wiki](https://github.com/trueagi-io/PLN/wiki).
