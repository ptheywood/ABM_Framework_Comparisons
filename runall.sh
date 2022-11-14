#!/bin/bash

echo "Benchmarking Julia is Disabled"
julia --project=@. Agents/benchmark.jl

echo "Benchmarking NetLogo"
# Don't run above 8 threads otherwise errors will spit once the JVMs try
# to share the Backing Store and lock it
# ws=$(parallel -j1 ::: $(printf './netlogo_ws.sh %.0s' {1..10}) | sort | head -n1)
# echo "NetLogo WolfSheep (ms): "$ws
ws=$(parallel -j1 ::: $(printf './netlogo_flock.sh %.0s' {1..10}) | sort | head -n1)
echo "NetLogo Flocking (ms): "$ws
ws=$(parallel -j1 ::: $(printf './netlogo_s.sh %.0s' {1..10}) | sort | head -n1)
echo "NetLogo Schelling (ms): "$ws
# ws=$(parallel -j1 ::: $(printf './netlogo_forest.sh %.0s' {1..10}) | sort | head -n1)
# echo "NetLogo ForestFire (ms): "$ws

echo "Benchmarking Mesa"
# python3 Mesa/WolfSheep/benchmark.py
python3 Mesa/Flocking/benchmark.py
python3 Mesa/Schelling/benchmark.py
# python3 Mesa/ForestFire/benchmark.py

echo "Mason Benchmarks are disabled"

echo "Benchmarking FLAMEGPU2"
python3 FLAMEGPU2/benchmark.py