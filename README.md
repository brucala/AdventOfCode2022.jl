# Advent of Code 2022

Solutions to [Advent of Code 2022 edition](https://adventofcode.com/2022) in Julia.

## Benchmarks

To run the benchmarks:

    $ julia cli/benchmark.jl

```
┌─────┬──────┬────────────┬─────────────┬────────┐
│ day │ part │       time │      memory │ allocs │
├─────┼──────┼────────────┼─────────────┼────────┤
│   1 │    0 │ 560.359 μs │  392.55 KiB │   2909 │
│   1 │    1 │  61.536 ns │     0 bytes │      0 │
│   1 │    2 │   2.312 μs │    2.14 KiB │      2 │
├─────┼──────┼────────────┼─────────────┼────────┤
│   2 │    0 │   1.070 ms │ 1022.08 KiB │   7535 │
│   2 │    1 │ 131.567 μs │   19.61 KiB │      2 │
│   2 │    2 │ 133.721 μs │   19.61 KiB │      2 │
├─────┼──────┼────────────┼─────────────┼────────┤
│   3 │    0 │  24.438 μs │   42.69 KiB │     30 │
│   3 │    1 │ 477.944 μs │  508.44 KiB │   5088 │
│   3 │    2 │ 394.157 μs │  299.97 KiB │   3106 │
├─────┼──────┼────────────┼─────────────┼────────┤
│   4 │    0 │   1.526 ms │    1.41 MiB │  16034 │
│   4 │    1 │   2.925 μs │     0 bytes │      0 │
│   4 │    2 │   3.618 μs │     0 bytes │      0 │
├─────┼──────┼────────────┼─────────────┼────────┤
│   5 │    0 │ 478.967 μs │  205.23 KiB │   1119 │
│   5 │    1 │ 214.288 μs │    4.44 KiB │     39 │
│   5 │    2 │ 205.353 μs │  148.31 KiB │   2405 │
├─────┼──────┼────────────┼─────────────┼────────┤
│   6 │    0 │   7.992 μs │    9.69 KiB │     25 │
│   6 │    1 │ 123.698 μs │   17.96 KiB │    203 │
│   6 │    2 │ 173.140 μs │   12.61 KiB │    101 │
├─────┼──────┼────────────┼─────────────┼────────┤
│   7 │    0 │ 763.691 μs │  989.86 KiB │   8429 │
│   7 │    1 │   2.293 ms │    1.76 MiB │  24334 │
│   7 │    2 │   2.667 ms │    2.04 MiB │  28274 │
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
