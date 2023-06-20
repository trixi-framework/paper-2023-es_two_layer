# paper-2023-es_two_layer

[![License: MIT](https://img.shields.io/badge/License-MIT-success.svg)](https://opensource.org/licenses/MIT)
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.8059079.svg)](https://doi.org/10.5281/zenodo.8059079)

This repository contains the information and code to reproduce the results of the not yet submitted
article "An entropy stable discontinuous Galerkin method for the two-layer shallow water equations on curvilinear meshes".

# Numerical Experiments
All numerical results in the paper have been obtained using [Trixi.jl](https://github.com/trixi-framework/Trixi.jl).
To run the experiments a [Julia](https://julialang.org/) installation is necessary. The Figures have been created
with [Python](https://www.python.org/) and [Paraview](https://www.paraview.org/).

The subfolders of this repository contain README.md files with instructions to reproduce the numerical experiments, including postprocessing.

The numerical experiments were carried out with Julia v1.9. Visualizations were produced using ParaView 5.10.0 and Python 3.10.6.
