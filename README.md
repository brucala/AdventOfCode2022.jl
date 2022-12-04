# Advent of Code 2022

Solutions to [Advent of Code 2022 edition](https://adventofcode.com/2022) in Julia.

## Benchmarks

To run the benchmarks:

    $ julia cli/benchmark.jl

```
┌─────┬──────┬────────────┬─────────────┬────────┐
│ day │ part │       time │      memory │ allocs │
├─────┼──────┼────────────┼─────────────┼────────┤
│   1 │    0 │ 576.454 μs │  392.55 KiB │   2909 │
│   1 │    1 │  60.206 ns │     0 bytes │      0 │
│   1 │    2 │   2.330 μs │    2.14 KiB │      2 │
├─────┼──────┼────────────┼─────────────┼────────┤
│   2 │    0 │   1.145 ms │ 1022.08 KiB │   7535 │
│   2 │    1 │ 133.402 μs │   19.61 KiB │      2 │
│   2 │    2 │ 131.541 μs │   19.61 KiB │      2 │
├─────┼──────┼────────────┼─────────────┼────────┤
│   3 │    0 │ 109.040 μs │   42.69 KiB │     30 │
│   3 │    1 │ 475.855 μs │  508.44 KiB │   5088 │
│   3 │    2 │ 392.826 μs │  299.97 KiB │   3106 │
├─────┼──────┼────────────┼─────────────┼────────┤
│   4 │    0 │   1.639 ms │    1.41 MiB │  16034 │
│   4 │    1 │   1.780 μs │     0 bytes │      0 │
│   4 │    2 │   3.602 μs │     0 bytes │      0 │
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
