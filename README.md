# Advent of Code 2022

Solutions to [Advent of Code 2022 edition](https://adventofcode.com/2022) in Julia.

## Benchmarks

To run the benchmarks:

    $ julia cli/benchmark.jl

```
┌─────┬──────┬────────────┬────────────┬────────┐
│ day │ part │       time │     memory │ allocs │
├─────┼──────┼────────────┼────────────┼────────┤
│   1 │    0 │ 576.897 μs │ 392.55 KiB │   2909 │
│   1 │    1 │  59.620 ns │    0 bytes │      0 │
│   1 │    2 │   2.395 μs │   2.14 KiB │      2 │
└─────┴──────┴────────────┴────────────┴────────┘

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
