# Load two-layer shallow water equations
include(joinpath(pwd(),"two_layer.jl"))

using Plots
using DelimitedFiles
using LaTeXStrings
using DataFrames
using Printf
using CSV

# Run test case
# ==================================================================================================
# set interval for polydeg
n_start = 6
n_end   = 30

# Loop over polydeg for EC flux
for i=n_start:n_end
    trixi_include("elixir_shallowwater_twolayer_convergence.jl", polydeg=i,
                  output_directory=joinpath("Convergence_Spectral","dt_12000_flux_ec",@sprintf("P%i",i)))
end

# Loop over polydeg for ES flux
for i=n_start:n_end
    trixi_include("elixir_shallowwater_twolayer_convergence.jl", polydeg=i,
                  surface_flux=(flux_es_ersing_etal, flux_nonconservative_ersing_etal),
                  output_directory=joinpath("Convergence_Spectral","dt_12000_flux_es",@sprintf("P%i",i)))
end

# Generate csv data
# ==================================================================================================
# CSV for ES flux
    # Create DataFrame
    Error = Vector{Float64}()
    N     = Vector{Int16}()
    dt    = 0

    cd(joinpath("Convergence_Spectral","dt_12000_flux_es"))
    dir_names = readdir()
    # Iterate over folders
    for name in dir_names
      m = match(r"P(\d+)",name)
      # If Folder "PX" found open analysis.dat file
      if (m !== nothing)
        analysis_file = joinpath(name,"analysis.dat")
        mat,head = readdlm(analysis_file,header=true)
        df = DataFrame(mat,vec(head))
        push!(Error,df.l2_h_v1_upper[end])
        push!(N,parse(Int16,m.captures[1]))
        dt = Int(round(1/df.dt[1]))
      end
    end

    cd(joinpath(pwd(),".."))

    # Read into Dataframe and sort
    df_conv = DataFrame(N_pol=N,L2_Error=Error)
    df_conv = sort(df_conv,:N_pol)

    CSV.write("convergence_data_es.csv",df_conv)

    cd(joinpath(pwd(),".."))

# CSV for EC flux
    cd(joinpath("Convergence_Spectral","dt_12000_flux_ec"))
    dir_names = readdir()
    # Iterate over folders
    for name in dir_names
      m = match(r"P(\d+)",name)
      # If Folder "PX" found open analysis.dat file
      if (m !== nothing)
        analysis_file = joinpath(name,"analysis.dat")
        mat,head = readdlm(analysis_file,header=true)
        df = DataFrame(mat,vec(head))
        push!(Error,df.l2_h_v1_upper[end])
        push!(N,parse(Int16,m.captures[1]))
        dt = Int(round(1/df.dt[1]))
      end
    end

    cd(joinpath(pwd(),".."))

    # Read into Dataframe and sort
    df_conv = DataFrame(N_pol=N,L2_Error=Error)
    df_conv = sort(df_conv,:N_pol)

    CSV.write("convergence_data_ec.csv",df_conv)

    cd(joinpath(pwd(),".."))
