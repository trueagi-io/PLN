

## Wiki

Please check out the Wiki:

https://github.com/trueagi-io/PLN/wiki


# PLN v0.6 — Release Notes

## Overview

PLN v0.6 transitions the Probabilistic Logic Networks (PLN) reasoner to a PeTTa-based foundation, solidifying its role as a core reasoning component within the MeTTa / Hyperon ecosystem. This release does not introduce new reasoning semantics, rather, it emphasizes integration, maintainability, and execution reliability, building directly on the already functional and efficient reasoner introduced in v0.5.

## Key Changes
#### PeTTa-based Architecture
* Reworked the PLN implementation to be used with PeTTa transpiler 
* Improves consistency with MeTTa tooling and surrounding infrastructure
* Establishes a clearer long-term foundation for future extensions and optimizations

#### Stability & Execution Improvements
* More stable and predictable execution behavior
* Reasoning pipeline benefits from tighter coupling with the underlying runtime
* Reduced friction when running PLN examples in modern MeTTa environments

#### Ecosystem Alignment
* Positions PLN as a reasoning engine rather than a standalone prototype
* Aligns internal representations and execution model with the broader MeTTa / Hyperon stack

## What Did Not Change

* Core reasoning capabilities (deductive, inductive, abductive)
* Priority-queue–based, resource-bounded derivation strategy introduced in v0.5
* Focus on truth-value propagation and reasoning under uncertainty
PLN 0.6 is an architectural and infrastructural evolution, not a redesign of reasoning semantics.
