# Advent of Code 2022

Solutions to [Advent of Code 2022 edition](https://adventofcode.com/2022) in Julia.

## Benchmarks

To run the benchmarks:

    $ julia cli/benchmark.jl

```
┌─────┬──────┬────────────┬─────────────┬────────┐
│ day │ part │       time │      memory │ allocs │
├─────┼──────┼────────────┼─────────────┼────────┤
│   1 │    0 │ 560.717 μs │  392.55 KiB │   2909 │
│   1 │    1 │  67.810 ns │     0 bytes │      0 │
│   1 │    2 │   2.323 μs │    2.14 KiB │      2 │
├─────┼──────┼────────────┼─────────────┼────────┤
│   2 │    0 │   1.060 ms │ 1022.08 KiB │   7535 │
│   2 │    1 │ 132.083 μs │   19.61 KiB │      2 │
│   2 │    2 │ 134.453 μs │   19.61 KiB │      2 │
├─────┼──────┼────────────┼─────────────┼────────┤
│   3 │    0 │  24.183 μs │   42.69 KiB │     30 │
│   3 │    1 │ 479.904 μs │  508.44 KiB │   5088 │
│   3 │    2 │ 393.161 μs │  299.97 KiB │   3106 │
├─────┼──────┼────────────┼─────────────┼────────┤
│   4 │    0 │   1.701 ms │    1.41 MiB │  16034 │
│   4 │    1 │   1.865 μs │     0 bytes │      0 │
│   4 │    2 │   3.456 μs │     0 bytes │      0 │
├─────┼──────┼────────────┼─────────────┼────────┤
│   5 │    0 │ 477.064 μs │  205.23 KiB │   1119 │
│   5 │    1 │ 205.551 μs │    4.44 KiB │     39 │
│   5 │    2 │ 207.838 μs │  148.31 KiB │   2405 │
├─────┼──────┼────────────┼─────────────┼────────┤
│   6 │    0 │   8.315 μs │    9.69 KiB │     25 │
│   6 │    1 │ 120.418 μs │   17.96 KiB │    203 │
│   6 │    2 │ 169.984 μs │   12.61 KiB │    101 │
├─────┼──────┼────────────┼─────────────┼────────┤
│   7 │    0 │ 806.299 μs │    1.02 MiB │   9174 │
│   7 │    1 │  61.991 μs │   61.26 KiB │    954 │
│   7 │    2 │  61.723 μs │   61.26 KiB │    954 │
├─────┼──────┼────────────┼─────────────┼────────┤
│   8 │    0 │ 259.202 μs │  238.20 KiB │     47 │
│   8 │    1 │ 324.697 μs │  602.62 KiB │   8936 │
│   8 │    2 │ 988.565 μs │  588.06 KiB │   9409 │
└─────┴──────┴────────────┴─────────────┴────────┘

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
