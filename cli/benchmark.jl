using AdventOfCode2022
using BenchmarkTools
using PrettyTables
using ArgParse, Formatting

const VERY_SLOW, SLOW, FAST = 1e8, 2e6, 2e5

const readme_template = FormatExpr(
"""
# Advent of Code 2022

Solutions to [Advent of Code 2022 edition](https://adventofcode.com/2022) in Julia.

## Benchmarks

To run the benchmarks:

    \$ julia cli/benchmark.jl

{}

> **Part 0** refers to the **parsing of the input data**.

## Other CLI tools

To generate (src and test) templates for a given day:
```
\$ julia cli/generate_day.jl -h
usage: generate_day.jl [-h] nday

positional arguments:
  nday        day number for files to be generated

optional arguments:
  -h, --help  show this help message and exit
```

To download the input data of a given day:
```
\$ julia cli/get_input.jl -h
usage: get_input.jl [-d DAY] [-h]

optional arguments:
  -d, --day DAY  day number for the input to be downloaded. If not
                 given take today's input (type: Int64)
  -h, --help     show this help message and exit
```
"""
)

parse_function(day_module::Module) =
    :parse_input in names(day_module) ? getfield(day_module, :parse_input) : read_input

function available_solvers(day_module::Module)
    solve_methods = [:solve1, :solve2]
    sols = [getfield(day_module, sol) for sol in solve_methods if sol in names(day_module)]
    isempty(sols) && error("No solve method found in module $day_module")
    return sols
end

getpart(sol::Function) = "part$(string(sol)[end])"
getday(day_module::Module) = split(string(day_module), '.')[end] |> String

getN(s::String) = parse(Int, match(r"\d+$", s).match)

struct AOCBenchmark
    day::Int
    part::Int
    benchmark::BenchmarkTools.Trial
end
AOCBenchmark(d::String, p::String, b::BenchmarkTools.Trial) = AOCBenchmark(getN(d), getN(p), b)
AOCBenchmark(d::Int, p::String, b::BenchmarkTools.Trial) = AOCBenchmark(d, getN(p), b)

day(b::AOCBenchmark) = b.day
part(b::AOCBenchmark) = b.part
btime(b::AOCBenchmark) = time(b.benchmark)
bmemory(b::AOCBenchmark) = memory(b.benchmark)
ballocs(b::AOCBenchmark) = allocs(b.benchmark)

function benchmark(day_module::Module, data)
    nday = getday(day_module) |> getN
    benchmarks = AOCBenchmark[]

    # benchmark input parsing
    fparse = parse_function(day_module)
    data = fparse(nday)
    b = @benchmark $fparse($nday) seconds=0.5 samples=1000
    push!(benchmarks, AOCBenchmark(nday, 0, b))

    # benchmark available solution
    sols = available_solvers(day_module)
    for sol in sols
        d, p = getday(day_module), getpart(sol)
        b = @benchmark $sol($data) seconds=0.5 samples=1000
        nsamples = length(b.times)
        nsamples <= 100 && @warn "low number of samples ($nsamples) run for benchmarking $d $p"
        push!(benchmarks, AOCBenchmark(d, p, b))
    end
    return benchmarks
end

function benchmark(days=solved_days)
    benchmarks = AOCBenchmark[]
    for nday in days
        day = getproperty(AdventOfCode2022, Symbol("Day$nday"))
        append!(benchmarks, benchmark(day, nday))
    end
    return benchmarks
end

function benchmark_table(benchmarks, html_format=false)
    isempty(benchmarks) && return ""
    # TODO: do something nicer
    # e.g. show benchmark params, nsamples, ...
    headers = [:day, :part, :time, :memory, :allocs]
    matrix = Union{Int, Float64}[day.(benchmarks) part.(benchmarks) btime.(benchmarks) bmemory.(benchmarks) ballocs.(benchmarks)]
    h = highlighters(html_format)
    f = (v,i,j) -> j == 3 ? BenchmarkTools.prettytime(v) : j==4 ? BenchmarkTools.prettymemory(v) : v
    backend = html_format ? :html : :text
    hlines = 3:3:length(benchmarks) |> collect

    common_kwargs = (crop=:none, formatters=f, body_hlines=hlines)

    # print in screen in text format
    pretty_table(matrix, headers; highlighters=highlighters(false), common_kwargs...)

    return pretty_table(String, matrix, headers; highlighters=h, common_kwargs...)
end

function highlighters(html_format=false)
    very_slow_f = (data,i,j)->j==3 && data[i,j] > VERY_SLOW
    slow_f = (data,i,j)->j==3 && SLOW < data[i,j] < VERY_SLOW
    fast_f = (data,i,j)->j==3 && data[i,j] < FAST

    if html_format
        h_very_slow = HTMLHighlighter(very_slow_f, HTMLDecoration(color = "red", font_weight = "bold"))
        h_slow = HTMLHighlighter(slow_f, HTMLDecoration(color = "yellow", font_weight = "bold"))
        h_fast = HTMLHighlighter(fast_f, HTMLDecoration(color = "green", font_weight = "bold"))
        return h_very_solw, h_slow, h_fast
    end
    h_very_slow = Highlighter(very_slow_f, bold = true, foreground = :red)
    h_slow = Highlighter(slow_f, bold = true, foreground = :yellow)
    h_fast = Highlighter(fast_f, bold = true, foreground = :green)
    return h_very_slow, h_slow, h_fast
end

function generate_readme(table, html_format=false)
    filename = "README.md"
    file = open(filename, "w")
    if !html_format
        table = "```\n$table\n```"
    end
    printfmt(file, readme_template, table)
    close(file)
    @info "file $filename generated"
end

function ArgParse.parse_item(::Type{Union{Int, UnitRange}}, x::AbstractString)
    return ':' in x ? UnitRange(parse.(Int, split(x, ':'))...) : parse(Int, x)
end

function parse_commandline()
    s = ArgParseSettings()

    @add_arg_table! s begin
        "--generate-readme", "-g"
            help = "use to generate README with benchmarking results"
            action = :store_true
        "--format", "-f"
            help = "table format for generated README (available: text/html)"
            arg_type = String
            range_tester = x -> x ∈ ("text", "html")
            default = "text"
        "--days", "-d"
            help = "days to benchmark (e.g. 15 or 1:5)"
            arg_type = Union{Int, UnitRange}
            default = solved_days
    end

    return parse_args(s)
end

function main()
    parsed_args = parse_commandline()
    generate_flag = parsed_args["generate-readme"]
    html_format = parsed_args["format"] == "html"
    days = parsed_args["days"]

    benchmarks = benchmark(days)
    table = benchmark_table(benchmarks, html_format)
    generate_flag && generate_readme(table)
end

main()
