# This code runs the perturbation test for the ES and EC flux, samples min/mean/max-values of the
# entropy over all timesteps from the analysis file and displays the result.

# load two-layer shallow water equations
include(joinpath(pwd(),"two_layer.jl"))

using Trixi2Vtk
using DataFrames
using Statistics
using DelimitedFiles
using Printf

# Run perturbation test for ES and EC flux
trixi_include("elixir_shallowwater_twolayer_perturbation.jl",
              output_directory=joinpath("Well_balancedness_perturbation","P8_ec"),
              surface_flux=(flux_wintermeyer_etal, flux_nonconservative_ersing_etal)) 
trixi_include("elixir_shallowwater_twolayer_perturbation.jl",
              output_directory=joinpath("Well_balancedness_perturbation","P8_es"),
              surface_flux=(flux_es_ersing_etal, flux_nonconservative_ersing_etal)) 


# (Optional) Convert both to vtk
Trixi2Vtk.trixi2vtk(joinpath("Well_balancedness_perturbation","P8_es","solution*h5"),
                    output_directory=joinpath("Well_balancedness_perturbation","P8_es"))
Trixi2Vtk.trixi2vtk(joinpath("Well_balancedness_perturbation","P8_ec","solution*h5"),
                    output_directory=joinpath("Well_balancedness_perturbation","P8_ec"))


# Sample min/mean/max values
mat,head = readdlm(joinpath("Well_balancedness_perturbation","P8_ec","analysis.dat"),header=true)
df = DataFrame(mat,vec(head))

min_ec = minimum(df.dsdu_ut)
max_ec = maximum(df.dsdu_ut)
avg_ec = mean(df.dsdu_ut)

mat,head = readdlm(joinpath("Well_balancedness_perturbation","P8_es","analysis.dat"),header=true)
df = DataFrame(mat,vec(head))

min_es = minimum(df.dsdu_ut)
max_es = maximum(df.dsdu_ut)
avg_es = mean(df.dsdu_ut)

# Display the results
@printf("EC_flux | min: %.3e; mean: %.3e; max %.3e\n", min_ec, avg_ec, max_ec)
@printf("ES_flux | min: %.3e; mean: %.3e; max %.3e"  , min_es, avg_es, max_es)
