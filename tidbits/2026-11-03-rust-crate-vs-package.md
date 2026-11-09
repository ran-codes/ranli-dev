---
title: "Rust package vs crate vs modules"
date: "2026-11-03"
topics: [rust]
categories: [rust, cargo]
---
# Rambling

- conceptutal crate vs package and then the epxressino of it in filestrees and organizaotn ruesl are not clear to me
- need to clearly undrestnad thsi arhcetrue  to start being able to sniff test rust codebases



# Understanding

- Work space
  - Are composed of  1+ packages
  - Get cargo.toml files
    - includes metadata about the workspace/repo
    - includes the comopsition/orchestration information about its comopenent packages
- Packages
  - Are composed of 1+ crates
  - get cargo.toml files
    - this includes metadata about the package
    - includes the composition/orchestration information of its component crates
  - Must have at least one of either a library (max 1) or binary (no limit) crate (or both)
    - both is common. library holds the logic (`src/lib.rs`)  and the binary (`main.rs` - wraps it into a binary)
- Crates 
  - Crate is AKA as target
  - Are composted of  crate root file  and optionally additional modules/sub-modules
  - Don't get cargo.toml files
  - There are a few kinds of crates/target each with crate root file  (which signals what type of crate this is)
    - **Shipped Crates** that are Shipped to users
      - **Library** (`src/lib.rs`) -  a package can only  have **at most one library crate** - produces `.rlib` for other crates
        - contains syntax for organizing its modules and sub modules
      - **Binary**
        - A package can have 0+ binaries
        - contains syntax for organizing its modules and sub modules
        - They can be declared two ways
          - `src/main.rs` produces `{packagename}.exe`
          - `src/bin/*.rs` produces `*.exe`
            - note that multiple packages potentially may produce the same exe e.g. package A and Package B may produce `x.exe` this will be flagged ad build time and cargo will warn you to resolve these duplicated binary names as one .exe silently overwrites the other
    - **Helper** **Crates** (not shipped, cargo builds for dev tasks only) 
      - Crate types
        - **Tests**
        - **Examples**
        - **benches**
        - **Build scripts**
      - We will not detail into them here as its outside the scope of the tid-bit
  - **Modules**
    - Module names should be `snake_case` (no hyphens  or leading digits or uppercase) 
    - There several ways modules can be expressed
      - in-line block within the crate file
        - `// src/[lib.rs](http://lib.rs)`
        
          `mod util {                // module util, no [util.rs](http://util.rs) needed`
        
          `pub fn add(a: i32, b: i32) -> i32 { a + b }`
        
          `}`
        - common for small helpers and `mod tests { }` 
      - own file
        - these must site beside the crate root that declares it  so for the `/src/crate_dbt.rs` crate that declares  `module_dbt_engine` then the modules file will sit at `src/module_dbt_engine.rs`
        - this module must then be linked to the binary or library that declares it in that upstream file
      - Submodules
        - modules can have submodules to help organize and modularize the logic
        - Submodules as expressed in a subfolder with the module name
        - Modern syntax is (e.g. for example for the `module_dbt` module)
          - a subfolder `/src/module_dbt/{sub_module_name}.rs`
        - older syntax is `{parent}/{child}/mod.rs`
      - have its own sub-modules



&nbsp;

---

# References



## Reference A - Crate types


| Kind                 | Crate Root                               | Builds                                  |
| -------------------- | ---------------------------------------- | --------------------------------------- |
| Library              | `src/lib.rs` (max one)                   | `.rlib` for other crates                |
| Binary               | `src/main.rs`, `src/bin/*.rs`            | an `.exe`                               |
| Test, example, bench | `tests/`, `examples/`, `benches/` `*.rs` | an `.exe`, run by its own cargo command |
| Build script         | `build.rs`                               | runs before the package compiles        |


