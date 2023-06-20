# Well-balanced

This folder contains all the code to reproduce the results in Figure 3, Section 7.2 for the well-balanced test.

To run the test and reproduce the results, set your working directory to the `code` folder and execute the following commands in the Julia REPL.
```julia
julia> include(joinpath("Well_balancedness","run_well_balanced_test.jl"))
```
This will execute the following tasks:
- Run the well-balanced test for the EC flux
- convert solution data to .vtu format

You can then generate visualization from Figure 3 in ParaView. To reproduce the ParaView setup for the visualization just start Paraview, load the state from file `Well_balanced_latex.pvsm` and select the `solution*vtu` as input. This will then produce the visualization shown in Figure 3.