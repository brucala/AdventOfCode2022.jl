module Day25
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

const MAP = Dict(
    k => v
    for (k, v) in zip("012-=", (0, 1, 2, -1, -2))
)
MODMAP = Dict(
    i => v
    for (i, v) in zip(0:4, "012=-")
)

function decimal(s::AbstractString)
    sol = 0
    for (i, x) in enumerate(reverse(s))
        sol += MAP[x] * 5 ^ (i - 1)
    end
    return sol
end

function snafu(x::Int)
    sol = ""
    while x != 0
        x, r = divrem(x, 5)
        r > 2 && (x += 1)
        sol *= MODMAP[r]
    end
    return reverse(sol)
end

solve1(x) = snafu(sum(decimal.(x)))

###
### Part 2
###

function solve2(x)

end

end  # module
