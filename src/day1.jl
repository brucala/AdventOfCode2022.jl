module Day1
include("utils.jl")
using .Utils
import .Utils: parse_input

export solve1, solve2, parse_input

###
### Parse
###

function parse_input(x::AbstractString)
    calories = Int[]
    for block in split(strip(x), "\n\n")
        push!(calories, splitlines(block) .|> toint |> sum)
    end
    return calories
end

###
### Part 1
###

solve1(x) = maximum(x)

###
### Part 2
###

solve2(x) = sort(x, rev=true)[1:3] |> sum

end  # module
