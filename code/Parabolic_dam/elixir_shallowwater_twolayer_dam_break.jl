using OrdinaryDiffEq
using Trixi

###############################################################################
equations = ShallowWaterTwoLayerEquations2D(gravity_constant=1.0, rho_upper = 0.25, rho_lower = 1.0)

function initial_condition_dam_break(x, t, equations::ShallowWaterTwoLayerEquations2D)
  if x[1] <= 1/25*x[2]^2 - 2/5*x[2] + 6 + 1e-4 # small shift to get a better representation of the initial disconitnuity
    H2 = 1.0
    H1 = 2.0
  else
    H2 = 0.75
    H1 = 1.5
  end

  v1 = 0.0
  w1 = 0.0
  v2 = 0.0
  w2 = 0.0
  b  = 0.0
  return prim2cons(SVector(H1, v1, w1, H2, v2, w2, b), equations)
end

initial_condition = initial_condition_dam_break

boundary_condition_constant = BoundaryConditionDirichlet(initial_condition_dam_break)

###############################################################################
# Get the DG approximation space

volume_flux = (flux_wintermeyer_etal, flux_nonconservative_ersing_etal)
solver = DGSEM(polydeg=3, surface_flux=(flux_es_ersing_etal, flux_nonconservative_ersing_etal),
               volume_integral=VolumeIntegralFluxDifferencing(volume_flux))

###############################################################################

# Get the unstructured quad mesh from a file
default_mesh_file = joinpath("Parabolic_dam","parabolic_dam.mesh")
mesh_file = default_mesh_file

mesh = UnstructuredMesh2D(mesh_file)

# Boundary conditions
boundary_condition = Dict(:top => boundary_condition_constant,
                          :left => boundary_condition_constant,
                          :right => boundary_condition_constant,
                          :bottom => boundary_condition_constant,
                          :dam => boundary_condition_slip_wall)

# Create the semi discretization object
semi = SemidiscretizationHyperbolic(mesh, equations, initial_condition, solver,boundary_conditions=boundary_condition)

###############################################################################
# ODE solvers, callbacks, etc.

tspan = (0.0, 3.0)
ode = semidiscretize(semi, tspan)

summary_callback = SummaryCallback()

analysis_interval = 200
analysis_callback = AnalysisCallback(semi, interval=analysis_interval,
                                     save_analysis=true,
                                     output_directory="out")

alive_callback = AliveCallback(analysis_interval=analysis_interval)

save_solution = SaveSolutionCallback(interval=2500,
                                     save_initial_solution=true,
                                     save_final_solution=true,
                                     output_directory="out")

callbacks = CallbackSet(summary_callback, analysis_callback, alive_callback, save_solution)

###############################################################################
# run the simulation
sol = solve(ode, CarpenterKennedy2N54(williamson_condition=false),
            dt=1e-4, # solve needs some value here but it will be overwritten by the stepsize_callback
            save_everystep=false, callback=callbacks);
summary_callback() # print the timer summary
