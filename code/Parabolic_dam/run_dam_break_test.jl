# This code runs the parabolic dam break test for EC and ES scheme

# load two-layer shallow water equations
include(joinpath(pwd(),"two_layer.jl"))

using Trixi2Vtk

# Run with ES flux
trixi_include("elixir_shallowwater_twolayer_dam_break.jl",
              output_directory=joinpath("Parabolic_dam","P3_es"),
              tspan=(0.0,3.0))
# convert to .vtu
Trixi2Vtk.trixi2vtk(joinpath("Parabolic_dam","P3_es","solution*h5"),
                             output_directory=joinpath("Parabolic_dam","P3_es"))


# Run with EC flux
trixi_include("elixir_shallowwater_twolayer_dam_break.jl",
              output_directory=joinpath("Parabolic_dam","P3_ec"),
              volume_flux=(flux_wintermeyer_etal, flux_nonconservative_ersing_etal),
              tspan=(0.0,0.25))
# convert to .vtu
Trixi2Vtk.trixi2vtk(joinpath("Parabolic_dam","P3_ec","solution*h5"),
                    output_directory=joinpath("Parabolic_dam","P3_ec"))        
