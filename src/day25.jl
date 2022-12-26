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
    d, r = divrem(x, 5)
    sol = [r]
    while d != 0
        d, r = divrem(d, 5)
        push!(sol, r)
    end
    d = 0
    for i in 1:length(sol)
        s = sol[i] + d
        d, r = divrem(s, 5)
        r in (3, 4) && (d += 1)
        sol[i] = r
    end
    d != 0 && push!(sol, d)
    return map(i -> MODMAP[i], reverse(sol)) |> join
end

solve1(x) = snafu(sum(decimal.(x)))

###
### Part 2
###

function solve2(x)

end

end  # module
