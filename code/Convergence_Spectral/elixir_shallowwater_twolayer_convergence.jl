using OrdinaryDiffEq
using Trixi

###############################################################################
# Semidiscretization of the shallow water equations with a periodic
# bottom topography function (set in the initial conditions)

equations = ShallowWaterTwoLayerEquations2D(gravity_constant=10.0,rho_upper=0.9,rho_lower=1.0)

initial_condition = initial_condition_convergence_test

###############################################################################
# Get the DG approximation space

volume_flux = (flux_wintermeyer_etal, flux_nonconservative_ersing_etal)
surface_flux = (flux_wintermeyer_etal, flux_nonconservative_ersing_etal)
solver = DGSEM(polydeg=6, surface_flux=surface_flux,
               volume_integral=VolumeIntegralFluxDifferencing(volume_flux))

###############################################################################
# Get the unstructured quad mesh from a file
mesh_file = joinpath(@__DIR__, "mesh_alfven_wave_with_twist_and_flip.mesh")

mesh = UnstructuredMesh2D(mesh_file, periodicity=true)

# Create the semi discretization object
semi = SemidiscretizationHyperbolic(mesh, equations, initial_condition, solver,
                                    source_terms=source_terms_convergence_test)

###############################################################################
# ODE solvers, callbacks etc.

tspan = (0.0, 1.0)
ode = semidiscretize(semi, tspan)

summary_callback = SummaryCallback()

analysis_interval = 10000
analysis_callback = AnalysisCallback(semi, interval=analysis_interval,save_analysis=true,output_directory="out")

alive_callback = AliveCallback(analysis_interval=analysis_interval)

save_solution = SaveSolutionCallback(interval=10000,
                                     save_initial_solution=true,
                                     save_final_solution=true,output_directory="out")

callbacks = CallbackSet(summary_callback, analysis_callback, alive_callback, save_solution)

###############################################################################
# run the simulation

sol = solve(ode, CarpenterKennedy2N54(williamson_condition=false),
            dt=1/12000, # solve needs some value here but it will be overwritten by the stepsize_callback
            save_everystep=false, callback=callbacks);
summary_callback() # print the timer summary
