# An entropy stable discontinuous Galerkin method for the two-layer shallow water equations on curvilinear meshes

[![License: MIT](https://img.shields.io/badge/License-MIT-success.svg)](https://opensource.org/licenses/MIT)
[![DOI](https://zenodo.org/badge/655647824.svg)](https://zenodo.org/doi/10.5281/zenodo.8059078)

This repository contains the information and code to reproduce the results of the not yet submitted
article
```bibtex
@online{ersing2023two,
  title={An entropy stable discontinuous {G}alerkin method for the two-layer 
         shallow water equations on curvilinear meshes},
  author={Ersing, Patrick and Winters, Andrew R},
  journal={Journal of Scientific Computing},
  year={2023},
  month={06},
  eprint={2306.12699},
  eprinttype={arxiv},
  eprintclass={math.NA}
}
```

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

We present an entropy stable nodal discontinuous Galerkin spectral element method (DGSEM) for the two-layer shallow water equations on two dimensional curvilinear meshes. We mimic the continuous entropy analysis on the semi-discrete level with the DGSEM constructed on Legendre-Gauss-Lobatto (LGL) nodes. The use of LGL nodes endows the collocated nodal DGSEM with the summation-by-parts property that is key in the discrete analysis. The approximation exploits an equivalent flux differencing formulation for the volume contributions, which generate an entropy conservative split-form of the governing equations. A specific combination of an entropy conservative numerical surface flux and discretization of the nonconservative terms is then applied to obtain a high-order path-conservative scheme that is entropy conservative and has the well-balanced property for discontinuous bathymetry. Dissipation is added at the interfaces to create an entropy stable approximation that satisfies the second law of thermodynamics in the discrete case. We conclude with verification of the theoretical findings through numerical tests and demonstrate results about convergence, entropy stability and well-balancedness of the scheme.

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
