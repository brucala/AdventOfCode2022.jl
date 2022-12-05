module Day4
include("utils.jl")
using .Utils
import .Utils: parse_input

export solve1, solve2, parse_input

###
### Parse
###

struct Assignment
    a::UnitRange{Int}
    b::UnitRange{Int}
end
function Assignment(s::AbstractString)
    a, b = map(
        p -> toint.(split(p, "-")),
        split(s, ",")
    )
    Assignment(range(a...), range(b...))
end

parse_input(x::AbstractString) = Assignment.(splitlines(x))

###
### Part 1
###

fully_contains(x::Assignment) = x.a ⊆ x.b || x.b ⊆ x.a
solve1(x) = sum(fully_contains, x)

###
### Part 2
###

overlaps(x::Assignment) = !isdisjoint(x.a, x.b)
solve2(x) = sum(overlaps, x)

end  # module
