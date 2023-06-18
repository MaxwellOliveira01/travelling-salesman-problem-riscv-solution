# Travelling Salesman Problem RiscV Solution

This project is an implementation of the Traveling Salesman Problem (TSP) solver using RISC-V assembly language.

## Main ideia

- Random generation of N points on a map
- Drawing lines connecting all pairs of points
- Solving the TSP using a route with the minimum total distance
- Highlighting the optimal route in red

## Complexity

The complexity of this project code is O(N!), where N is the number of points. This means that as the number of points increases, the execution time of the program will grow exponentially.

## How to use

- To run it you will need [RARS](https://github.com/TheThirdOne/rars)
- Open the file "tsp.asm"
- On Rars, select tools, open bitmap display and connect it to program
- Run code and visualize the execution
- To change the numbe of points, change variable "N" on top of "tsp.asm" file.
