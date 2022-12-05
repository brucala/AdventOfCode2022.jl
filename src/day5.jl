module Day5
include("utils.jl")
using .Utils
import .Utils: parse_input

export solve1, solve2, parse_input

###
### Parse
###

function parse_crates(x)
    crates = Dict{Int, Vector{Char}}()
    for line in splitlines(x)[1:end-1]
        for (i, j) in enumerate(2:4:length(line))
            crate = line[j]
            crate == ' ' || pushfirst!(get!(crates, i, Char[]), crate)
        end
    end
    crates
end

function parse_instructions(x)
    ins = NTuple{3, Int}[]
    for line in splitlines(strip(x))
        sl = split(line)
        push!(ins, toint.((sl[2], sl[4], sl[6])))
    end
    return ins
end

function parse_input(x::AbstractString)
    crates, ins = split(x, "\n\n")
    return parse_crates(crates), parse_instructions(ins)
end

###
### Part 1
###

function solve1(x)
    crates, ins = x
    crates = deepcopy(crates)
    for (n, from, to) in ins
        foreach(i -> push!(crates[to], pop!(crates[from])), 1:n)
    end
    return [last(crates[i]) for i in 1:length(crates)] |> String
end

###
### Part 2
###

function solve2(x)
    crates, ins = x
    crates = deepcopy(crates)
    for (n, from, to) in ins
        x = crates[from]
        stay, go = x[1:length(x) - n], x[length(x) - n + 1:end]
        crates[from] = stay
        append!(crates[to], go)
    end
    return [last(crates[i]) for i in 1:length(crates)] |> String
end

end  # module
