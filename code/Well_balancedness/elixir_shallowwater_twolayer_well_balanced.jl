using OrdinaryDiffEq
using Trixi

###############################################################################
equations = ShallowWaterTwoLayerEquations2D(gravity_constant=10.0, H0=0.6, rho_upper=0.9, rho_lower=1.0)

# Set a dummy initial condition that is later overwritten with discontinuous initial data
initial_condition = initial_condition_convergence_test

###############################################################################
# Get the DG approximation space

volume_flux = (flux_wintermeyer_etal, flux_nonconservative_ersing_etal)
surface_flux=(flux_wintermeyer_etal, flux_nonconservative_ersing_etal)
solver = DGSEM(polydeg=8, surface_flux=surface_flux,
               volume_integral=VolumeIntegralFluxDifferencing(volume_flux))

###############################################################################
# Get the unstructured quad mesh from a file
mesh_file = joinpath(@__DIR__, "mesh_alfven_wave_with_twist_and_flip.mesh")

mesh = UnstructuredMesh2D(mesh_file, periodicity=true)

# Create the semi discretization object
semi = SemidiscretizationHyperbolic(mesh, equations, initial_condition, solver)

###############################################################################
# ODE solver

tspan = (0.0, 100.0)
ode = semidiscretize(semi, tspan)

###############################################################################
# Workaround to set a discontinuous bottom topography and initial condition for debugging and testing.

function initial_condition_ec_discontinuous_bottom(x, t, element_id,equations::ShallowWaterTwoLayerEquations2D)
  # Add perturbation to h2
  add_perturbation = false
  if add_perturbation == true
    h_upper = (sqrt(2)/2-0.1<=x[1]<=sqrt(2)/2+0.1 && sqrt(2)/2-0.1<=x[2]<=sqrt(2)/2+0.1) ? 0.15 : 0.1 # circle
  else 
    h_upper = 0.1
  end

  H_lower = 0.5
  H_upper = H_lower + h_upper
  v1_upper = 0.0
  v2_upper = 0.0
  v1_lower = 0.0
  v2_lower = 0.0
  b  = 0.0

  # Setup a discontinuous bottom topography using the element id number
  if element_id == 7
    b = 0.25 + 0.1 * sin(2.0 * pi * x[1]) + 0.1 * cos(2.0 * pi * x[2])
  end
  
  return prim2cons(SVector(H_upper, v1_upper, v2_upper, H_lower, v1_lower, v2_lower, b), equations)
end

# point to the data we want to augment
u = Trixi.wrap_array(ode.u0, semi)
# reset the initial condition
for element in eachelement(semi.solver, semi.cache)
  for j in eachnode(semi.solver), i in eachnode(semi.solver)
    x_node = Trixi.get_node_coords(semi.cache.elements.node_coordinates, equations, semi.solver, i, j, element)
    u_node = initial_condition_ec_discontinuous_bottom(x_node, first(tspan), element, equations)
    Trixi.set_node_vars!(u, u_node, equations, semi.solver, i, j, element)
  end
end


###############################################################################
# Callbacks
output_dir = joinpath("Well_balancedness","out")

summary_callback = SummaryCallback()

analysis_interval = 10000
analysis_callback = AnalysisCallback(semi, interval=analysis_interval,save_analysis=true,
                                     extra_analysis_integrals=(lake_at_rest_error,energy_total,),
                                     output_directory=output_dir)

alive_callback = AliveCallback(analysis_interval=analysis_interval)

save_solution = SaveSolutionCallback(interval=10000,
                                     save_initial_solution=true,
                                     save_final_solution=true,
                                     output_directory=output_dir)

stepsize_callback = StepsizeCallback(cfl=0.7)

callbacks = CallbackSet(summary_callback, analysis_callback, alive_callback, save_solution,
                        stepsize_callback)

###############################################################################
# run the simulation

sol = solve(ode, CarpenterKennedy2N54(williamson_condition=false),
            dt=1.0, # solve needs some value here but it will be overwritten by the stepsize_callback
            save_everystep=false, callback=callbacks);
summary_callback() # print the timer summary
