# Advent of Code 2022

Solutions to [Advent of Code 2022 edition](https://adventofcode.com/2022) in Julia.

## Benchmarks

To run the benchmarks:

    $ julia cli/benchmark.jl

```
┌─────┬──────┬────────────┬─────────────┬─────────┐
│ day │ part │       time │      memory │  allocs │
├─────┼──────┼────────────┼─────────────┼─────────┤
│   1 │    0 │ 566.480 μs │  392.55 KiB │    2909 │
│   1 │    1 │  61.695 ns │     0 bytes │       0 │
│   1 │    2 │   2.411 μs │    2.14 KiB │       2 │
├─────┼──────┼────────────┼─────────────┼─────────┤
│   2 │    0 │   1.063 ms │ 1022.08 KiB │    7535 │
│   2 │    1 │ 132.265 μs │   19.61 KiB │       2 │
│   2 │    2 │ 130.224 μs │   19.61 KiB │       2 │
├─────┼──────┼────────────┼─────────────┼─────────┤
│   3 │    0 │  24.360 μs │   42.69 KiB │      30 │
│   3 │    1 │ 478.238 μs │  508.44 KiB │    5088 │
│   3 │    2 │ 392.424 μs │  299.97 KiB │    3106 │
├─────┼──────┼────────────┼─────────────┼─────────┤
│   4 │    0 │   1.513 ms │    1.41 MiB │   16034 │
│   4 │    1 │   1.882 μs │     0 bytes │       0 │
│   4 │    2 │   3.573 μs │     0 bytes │       0 │
├─────┼──────┼────────────┼─────────────┼─────────┤
│   5 │    0 │ 476.278 μs │  205.23 KiB │    1119 │
│   5 │    1 │ 204.505 μs │    4.44 KiB │      39 │
│   5 │    2 │ 212.272 μs │  148.31 KiB │    2405 │
├─────┼──────┼────────────┼─────────────┼─────────┤
│   6 │    0 │   8.268 μs │    9.69 KiB │      25 │
│   6 │    1 │ 118.981 μs │   17.96 KiB │     203 │
│   6 │    2 │ 167.389 μs │   12.61 KiB │     101 │
├─────┼──────┼────────────┼─────────────┼─────────┤
│   7 │    0 │ 798.485 μs │    1.02 MiB │    9174 │
│   7 │    1 │  62.630 μs │   61.26 KiB │     954 │
│   7 │    2 │  62.138 μs │   61.26 KiB │     954 │
├─────┼──────┼────────────┼─────────────┼─────────┤
│   8 │    0 │ 259.900 μs │  238.20 KiB │      47 │
│   8 │    1 │ 327.031 μs │  602.62 KiB │    8936 │
│   8 │    2 │   1.003 ms │  588.06 KiB │    9409 │
├─────┼──────┼────────────┼─────────────┼─────────┤
│   9 │    0 │ 743.526 μs │  741.55 KiB │    4034 │
│   9 │    1 │ 366.655 μs │  364.11 KiB │      24 │
│   9 │    2 │ 969.863 μs │   92.11 KiB │      20 │
├─────┼──────┼────────────┼─────────────┼─────────┤
│  10 │    0 │  14.029 μs │    8.85 KiB │      29 │
│  10 │    1 │  41.620 μs │   35.59 KiB │     268 │
│  10 │    2 │  46.276 μs │   43.78 KiB │     303 │
├─────┼──────┼────────────┼─────────────┼─────────┤
│  11 │    0 │  66.953 μs │   29.18 KiB │     264 │
│  11 │    1 │ 194.640 μs │   11.20 KiB │     298 │
│  11 │    2 │  98.351 ms │   37.00 MiB │ 2424303 │
├─────┼──────┼────────────┼─────────────┼─────────┤
│  12 │    0 │  72.764 μs │   67.65 KiB │      44 │
│  12 │    1 │  12.829 ms │  667.38 KiB │    5308 │
│  12 │    2 │    1.094 s │   79.08 MiB │  629086 │
├─────┼──────┼────────────┼─────────────┼─────────┤
│  13 │    0 │ 196.212 ms │    2.48 MiB │   45643 │
│  13 │    1 │  51.833 μs │    6.44 KiB │     103 │
│  13 │    2 │   1.739 ms │  460.86 KiB │   20442 │
├─────┼──────┼────────────┼─────────────┼─────────┤
│  14 │    0 │   2.134 ms │    1.56 MiB │   23096 │
│  14 │    1 │ 916.382 μs │   59.20 KiB │      92 │
│  14 │    2 │    1.310 s │    1.63 MiB │      97 │
└─────┴──────┴────────────┴─────────────┴─────────┘

```

> **Part 0** refers to the **parsing of the input data**.

## Other CLI tools

To generate (src and test) templates for a given day:
```
$ julia cli/generate_day.jl -h
usage: generate_day.jl [-h] nday

positional arguments:
  nday        day number for files to be generated

optional arguments:
  -h, --help  show this help message and exit
```

To download the input data of a given day:
```
$ julia cli/get_input.jl -h
usage: get_input.jl [-d DAY] [-h]

optional arguments:
  -d, --day DAY  day number for the input to be downloaded. If not
                 given take today's input (type: Int64)
  -h, --help     show this help message and exit
```
