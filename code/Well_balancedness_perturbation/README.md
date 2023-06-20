# Well-balanced Perturbation

This folder contains all the code to reproduce the results in Table 1, Section 7.3 for the perturbed lake-at-rest condition. 

To run the test and reproduce the results, set your working directory to the `code` folder and execute the following commands in the Julia REPL.
```julia
julia> include(joinpath("Well_balancedness_perturbation","run_perturbation_test.jl"))
```
This will execute the following tasks:
- Run the perturbation test for the EC and ES flux and generate an analysis.dat file at each timestep
- convert solution data to .vtu format
- Evaluate minimum / mean / maximum values of the entropy over all time steps from the analysis-files
- Display the results from Table 1 