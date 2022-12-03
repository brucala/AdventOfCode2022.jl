module Day3
include("utils.jl")
using .Utils
import .Utils: parse_input

export solve1, solve2, parse_input

###
### Parse
###

parse_input(x::AbstractString) = splitlines(x)

###
### Part 1
###

priority(c) = islowercase(c) ? c + 1 - 'a' : c + 27 - 'A'

function solve1(x)
    s = 0
    for elf in x
        n = length(elf)
        s += priority(first(Set(elf[1:n÷2]) ∩ Set(elf[n÷2+1:end])))
    end
    return s
end

###
### Part 2
###

function solve2(x)
    sum(
        i -> priority(first(∩(Set.(x[3*i+1:3*i+3])...))),
        0:length(x) ÷ 3 - 1
    )
end

end  # module
