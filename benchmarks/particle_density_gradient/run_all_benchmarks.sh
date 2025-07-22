#!/bin/bash

# Run all models in this directory. Modify the loops below for running only a
# subset of models
# > >> are used to append, cat concatenates


processes=4
ASPECT_EXEC="../../build/aspect"

# Constant velocity
echo "subsection Prescribed Stokes solution" > current.prm
echo "set Model name = function" >> current.prm
echo "subsection Velocity function" >> current.prm
echo "  set Variable names      = x,y" >> current.prm
echo "  set Function constants  = velSlow=-0.1" >> current.prm
echo "  set Function expression = 0; velSlow" >> current.prm
echo " end" >> current.prm
echo "end" >> current.prm
echo "set Output directory = output-constant-velocity" >> current.prm
cat particle_density_gradient.prm current.prm | mpirun -np $processes $ASPECT_EXEC --

# Oscillating velocity
echo "subsection Prescribed Stokes solution" > current.prm
echo "set Model name = function" >> current.prm
echo "subsection Velocity function" >> current.prm
echo "  set Variable names      = x,y,t" >> current.prm
echo "  set Function constants  = velConstant=-0" >> current.prm
echo "  set Function expression = 0; (-0.5*sin(pi*t)) +velConstant" >> current.prm
echo " end" >> current.prm
echo "end" >> current.prm
echo "set Output directory = output-oscillating-velocity" >> current.prm
cat particle_density_gradient.prm current.prm | mpirun -np $processes $ASPECT_EXEC --


# for stokes_degree in 2 3; do # 2 3
#   for discontinuous_pressure in false; do # true
#     for refinement in 2 3 4 5 6 7 8; do # 2 3 4 5 6 7 8
#         echo "subsection Discretization" > current.prm
#         echo "  set Stokes velocity polynomial degree = $stokes_degree" >> current.prm
#         echo "  set Use locally conservative discretization = $discontinuous_pressure" >> current.prm
#         echo "end" >> current.prm

#         echo "subsection Mesh refinement" >> current.prm
#         echo "  set Initial global refinement = $refinement" >> current.prm
#         echo "end" >> current.prm

#         echo "set Output directory = Q${stokes_degree}_P${discontinuous_pressure}_refinement${refinement}" >> current.prm
#         echo "Starting Q${stokes_degree}_P${discontinuous_pressure}_refinement${refinement}"
#         cat rigid_shear.prm current.prm | mpirun -np $processes $ASPECT_EXEC --
#     done
#   done
# done
