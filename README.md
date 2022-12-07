# Advent of Code 2022

Solutions to [Advent of Code 2022 edition](https://adventofcode.com/2022) in Julia.

## Benchmarks

To run the benchmarks:

    $ julia cli/benchmark.jl

```
┌─────┬──────┬────────────┬─────────────┬────────┐
│ day │ part │       time │      memory │ allocs │
├─────┼──────┼────────────┼─────────────┼────────┤
│   1 │    0 │ 586.577 μs │  392.55 KiB │   2909 │
│   1 │    1 │  65.260 ns │     0 bytes │      0 │
│   1 │    2 │   2.536 μs │    2.14 KiB │      2 │
├─────┼──────┼────────────┼─────────────┼────────┤
│   2 │    0 │   1.057 ms │ 1022.08 KiB │   7535 │
│   2 │    1 │ 132.743 μs │   19.61 KiB │      2 │
│   2 │    2 │ 134.335 μs │   19.61 KiB │      2 │
├─────┼──────┼────────────┼─────────────┼────────┤
│   3 │    0 │  23.924 μs │   42.69 KiB │     30 │
│   3 │    1 │ 480.107 μs │  508.44 KiB │   5088 │
│   3 │    2 │ 394.707 μs │  299.97 KiB │   3106 │
├─────┼──────┼────────────┼─────────────┼────────┤
│   4 │    0 │   1.539 ms │    1.41 MiB │  16034 │
│   4 │    1 │   1.864 μs │     0 bytes │      0 │
│   4 │    2 │   3.460 μs │     0 bytes │      0 │
├─────┼──────┼────────────┼─────────────┼────────┤
│   5 │    0 │ 510.536 μs │  205.23 KiB │   1119 │
│   5 │    1 │ 203.947 μs │    4.44 KiB │     39 │
│   5 │    2 │ 211.339 μs │  148.31 KiB │   2405 │
├─────┼──────┼────────────┼─────────────┼────────┤
│   6 │    0 │   8.192 μs │    9.69 KiB │     25 │
│   6 │    1 │ 118.952 μs │   17.96 KiB │    203 │
│   6 │    2 │ 167.379 μs │   12.61 KiB │    101 │
├─────┼──────┼────────────┼─────────────┼────────┤
│   7 │    0 │ 800.101 μs │    1.02 MiB │   9174 │
│   7 │    1 │  62.351 μs │   61.26 KiB │    954 │
│   7 │    2 │  62.187 μs │   61.26 KiB │    954 │
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
