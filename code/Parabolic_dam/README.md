# Parabolic dam break

This folder contains all the code to reproduce the results in Figure 4 and 5, Section 7.4 for the parabolic dam break. 

To run the test and reproduce the results, set your working directory to the `code` folder and execute the following commands in the Julia REPL.
```julia
julia> include(joinpath("Parabolic_dam","run_dam_break_test.jl"))
```
This will execute the following tasks:
- Run the parabolic dam break test for the EC and ES flux
- convert solution data to .vtu format

# Figure 4
You can then generate visualization from Figure 4 in ParaView. To reproduce the ParaView setup for the visualization just start Paraview, load the state from file `Visualization_latex.pvsm` and select the `solution*vtu` from the ES folder as input. This will then produce the visualization shown in Figure 4.

# Figure 5
To create the comparison plot between the ES and EC results, line plot data from ParaView from the ES and EC run must be exported to .csv-format at t=0.25. To do this you can follow the steps from Figure 4 and then apply the `Plot Over Line` filter along y=5, but the resulting files `data_ec.csv` and `data_es.csv` are also provided in this repository.
Then run the python script `python3 Parabolic_dam/es_ec_plot.py` to generate the plot.
