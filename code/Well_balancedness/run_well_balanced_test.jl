# load two-layer shallow water equations
include(joinpath(pwd(),"two_layer.jl"))

using Trixi2Vtk

# run test case
include("elixir_shallowwater_twolayer_well_balanced.jl")

# convert to .vtu
Trixi2Vtk.trixi2vtk(joinpath("Well_balancedness","out","solution*h5"),
                    output_directory=joinpath("Well_balancedness","out"))