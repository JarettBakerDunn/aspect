#!/bin/bash

# Run all models in this directory. Modify the loops below for running only a
# subset of models
# > >> are used to append, cat concatenates


processes=4
ASPECT_EXEC="../../build/aspect"

# For now, using oscillating velocity for all these benchmarks

# cutoff_w1 (the default kernel function)
echo "subsection Prescribed Stokes solution" > current.prm
echo "set Model name = function" >> current.prm
echo "subsection Velocity function" >> current.prm
echo "  set Variable names      = x,y,t" >> current.prm
echo "  set Function constants  = velConstant=-0" >> current.prm
echo "  set Function expression = 0; (-0.5*sin(pi*t)) +velConstant" >> current.prm
echo " end" >> current.prm
echo "end" >> current.prm

echo "set Output directory = output-cutoff-w1" >> current.prm
cat particle_density_gradient.prm current.prm | mpirun -np $processes $ASPECT_EXEC --

# Run with uniform kernel function
echo "subsection Prescribed Stokes solution" > current.prm
echo "set Model name = function" >> current.prm
echo "subsection Velocity function" >> current.prm
echo "  set Variable names      = x,y,t" >> current.prm
echo "  set Function constants  = velConstant=-0" >> current.prm
echo "  set Function expression = 0; (-0.5*sin(pi*t)) +velConstant" >> current.prm
echo " end" >> current.prm
echo "end" >> current.prm

echo "subsection Particles" >> current.prm
echo "  set Point density kernel function = uniform" >> current.prm
echo "end" >> current.prm

echo "set Output directory = output-uniform" >> current.prm
cat particle_density_gradient.prm current.prm | mpirun -np $processes $ASPECT_EXEC --


# Run with gaussian kernel function
echo "subsection Prescribed Stokes solution" > current.prm
echo "set Model name = function" >> current.prm
echo "subsection Velocity function" >> current.prm
echo "  set Variable names      = x,y,t" >> current.prm
echo "  set Function constants  = velConstant=-0" >> current.prm
echo "  set Function expression = 0; (-0.5*sin(pi*t)) +velConstant" >> current.prm
echo " end" >> current.prm
echo "end" >> current.prm

echo "subsection Particles" >> current.prm
echo "  set Point density kernel function = gaussian" >> current.prm
echo "end" >> current.prm

echo "set Output directory = output-gaussian" >> current.prm
cat particle_density_gradient.prm current.prm | mpirun -np $processes $ASPECT_EXEC --

# Run with triangular kernel function
echo "subsection Prescribed Stokes solution" > current.prm
echo "set Model name = function" >> current.prm
echo "subsection Velocity function" >> current.prm
echo "  set Variable names      = x,y,t" >> current.prm
echo "  set Function constants  = velConstant=-0" >> current.prm
echo "  set Function expression = 0; (-0.5*sin(pi*t)) +velConstant" >> current.prm
echo " end" >> current.prm
echo "end" >> current.prm

echo "subsection Particles" >> current.prm
echo "  set Point density kernel function = triangular" >> current.prm
echo "end" >> current.prm

echo "set Output directory = output-triangular" >> current.prm
cat particle_density_gradient.prm current.prm | mpirun -np $processes $ASPECT_EXEC --
