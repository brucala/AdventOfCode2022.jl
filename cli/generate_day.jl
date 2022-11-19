using ArgParse, Formatting

const day_template = FormatExpr(
"""
module Day{}
include("utils.jl")
using .Utils
import .Utils: parse_input

export solve1, solve2, parse_input

###
### Parse
###

function parse_input(x::AbstractString)
    for line in splitlines(x)
    end
end

###
### Part 1
###

function solve1(x)

end

###
### Part 2
###

function solve2(x)

end

end  # module
"""
)

const test_template = FormatExpr(
"""
module test_day{1}

using Test
using AdventOfCode2022.Day{1}

nday = {1}

data = parse_input(nday)

test = parse_input(
\"\"\"
\"\"\"
)

@testset "Day\$nday tests" begin
    @test solve1(test) == ?
    #@test solve2(test) == ?
end

@testset "Day\$nday solutions" begin
    @test solve1(data) == ?
    #@test solve2(data) == ?
end

end  # module
"""
)

function write_file(filename, template, nday)
    if isfile(filename)
        println("file $filename exists, skipping generation...")
        return
    end
    file = open(filename, "w")
    printfmt(file, template, nday)
    close(file)
    @info "file $filename generated"
end

function generate_files(nday)
    day_filename = "src/day$nday.jl"
    write_file(day_filename, day_template, nday)

    test_filename = "test/test_day$nday.jl"
    write_file(test_filename, test_template, nday)
end

function parse_commandline()
    s = ArgParseSettings()

    @add_arg_table! s begin
        "nday"
            help = "day number for files to be generated"
            required = true
    end

    return parse_args(s)
end

function main()
    parsed_args = parse_commandline()
    nday = parsed_args["nday"]

    generate_files(nday)
end

main()
