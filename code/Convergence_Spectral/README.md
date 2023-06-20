# Spectral Convergence

This folder contains all the code to reproduce the results in Figure 2, Section 7.1 for the spectral convergence test. 

To run the test and reproduce the results, set your working directory to the `code` folder and execute the following commands in the Julia REPL.
```julia
julia> include(joinpath("Convergence_Spectral","run_spectral_convergence_test.jl"))
```
This will execute the following tasks:
- Run the spectral convergence test for the EC and ES flux for polynomial degree 6 up to 30.
- Generate csv-files for EC and ES results with polynomial degree and L2-Error from the analysis files.

The resulting .csv-files can then be used to create the spectral-convergence plot by calling the python script `python Convergence_Spectral/Spectral_convergence_plot.py`
