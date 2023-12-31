# Instructions

This directory contains code and instructions to reproduce the numerical experiments. To obtain the correct paths all scripts must be run with this folder as the working directory. 

The folder has the follwing contents:
- Directory `Convergence_Spectral` with code and instructions to reproduce the results in Section 7.1.
- Directory `Well_balancedness` with code and instructions to reproduce the results in Section 7.2.
- Directory `Well_balancedness_perturbation` with code and instructions to reproduce the results in Section 7.3.
- Directory `Parabolic_dam` with code and instructions to reproduce the results in Section 7.4.
- The file `two_layer.jl` contains the additional Trixi equation folder for the two-layer shallow water equations.
- The files `Manifest.toml` and `Project.toml` are used to recreate the Julia environment.

The packages are installed automatically within the `two_layer.jl` file, which is called by each of run scripts. 

If you want to run any of the other julia files individually start julia with the project directory set to the `code/` folder. Additionally, before first execution install the packages by executing

`julia --project=code/ -e 'using Pkg; Pkg.instantiate()'`
