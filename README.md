# Travelling Salesman Problem RiscV Solution

This project uses RISC-V assembly language to implement the Traveling Salesman Problem (TSP) solver.

## Main idea

- Random generation of N points on a map
- Drawing lines connecting all pairs of points
- Solving the TSP using a route with the minimum total distance
- Highlighting the optimal route in red

## Complexity

The complexity of this project code is O(NumberOfPoints!). This means that as the number of points increases, the execution time of the program will grow exponentially.

## How to use

- To run it you will need [RARS](https://github.com/TheThirdOne/rars)
- Open the file "tsp.asm"
- On Rars, select tools, open bitmap display, and connect it to the program
- Run code and visualize the execution
- To change the number of points, change variable "N" on top of "tsp.asm" file.

## Example of execution

<p float="left" align="middle">
  <img src="/img/5-points.png" width="300" />
  <img src="/img/6-points.png" width="300" />
</p>
