# Advent of Code 2022

Solutions to [Advent of Code 2022 edition](https://adventofcode.com/2022) in Julia.

## Benchmarks

To run the benchmarks:

    $ julia cli/benchmark.jl

```
┌─────┬──────┬────────────┬─────────────┬────────┐
│ day │ part │       time │      memory │ allocs │
├─────┼──────┼────────────┼─────────────┼────────┤
│   1 │    0 │ 559.639 μs │  392.55 KiB │   2909 │
│   1 │    1 │  59.671 ns │     0 bytes │      0 │
│   1 │    2 │   2.450 μs │    2.14 KiB │      2 │
├─────┼──────┼────────────┼─────────────┼────────┤
│   2 │    0 │   1.056 ms │ 1022.08 KiB │   7535 │
│   2 │    1 │ 132.550 μs │   19.61 KiB │      2 │
│   2 │    2 │ 134.750 μs │   19.61 KiB │      2 │
├─────┼──────┼────────────┼─────────────┼────────┤
│   3 │    0 │  23.567 μs │   42.69 KiB │     30 │
│   3 │    1 │ 475.238 μs │  508.44 KiB │   5088 │
│   3 │    2 │ 391.418 μs │  299.97 KiB │   3106 │
├─────┼──────┼────────────┼─────────────┼────────┤
│   4 │    0 │   1.519 ms │    1.41 MiB │  16034 │
│   4 │    1 │   1.849 μs │     0 bytes │      0 │
│   4 │    2 │   3.434 μs │     0 bytes │      0 │
├─────┼──────┼────────────┼─────────────┼────────┤
│   5 │    0 │ 479.840 μs │  205.23 KiB │   1119 │
│   5 │    1 │ 208.411 μs │    4.44 KiB │     39 │
│   5 │    2 │ 206.667 μs │  148.31 KiB │   2405 │
├─────┼──────┼────────────┼─────────────┼────────┤
│   6 │    0 │   7.765 μs │    9.69 KiB │     25 │
│   6 │    1 │ 117.421 μs │   17.96 KiB │    203 │
│   6 │    2 │ 167.006 μs │   12.61 KiB │    101 │
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
