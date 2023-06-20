# An entropy stable discontinuous Galerkin method for the two-layer shallow water equations on curvilinear meshes

[![License: MIT](https://img.shields.io/badge/License-MIT-success.svg)](https://opensource.org/licenses/MIT)
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.8059079.svg)](https://doi.org/10.5281/zenodo.8059079)

This repository contains the information and code to reproduce the results of the not yet submitted
article TODO: add arXiv bibtex.

If you find these results useful, please cite the article mentioned above. If you
use the implementations provided here, please **also** cite this repository as
```bibtex
@misc{ersing2023twolayerRepro,
  title={Reproducibility repository for
         "{A}n entropy stable discontinuous {G}alerkin method for the two-layer 
         shallow water equations on curvilinear meshes"},
  author={Ersing, Patrick and Winters, Andrew R},
  year={2023},
  howpublished={\url{https://github.com/trixi-framework/paper-2023-es_two_layer}},
  doi={10.5281/zenodo.8059079}
}
```

## Abstract

TODO: put abstract text here

## Numerical Experiments

All numerical results in the paper have been obtained using [Trixi.jl](https://github.com/trixi-framework/Trixi.jl).
To run the experiments a [Julia](https://julialang.org/) installation is necessary. The Figures have been created
with [Python](https://www.python.org/) and [Paraview](https://www.paraview.org/).

The subfolders of this repository contain README.md files with instructions to reproduce the numerical experiments, including postprocessing.

The numerical experiments were carried out with Julia v1.9. Visualizations were produced using ParaView 5.10.0 and Python 3.10.6.

## Authors

- [Patrick Ersing](https://liu.se/en/employee/pater53) (Linköping University, Sweden)
- [Andrew R. Winters](https://liu.se/en/employee/andwi94) (Linköping University, Sweden)

## Disclaimer

Everything is provided as is and without warranty. Use at your own risk!
