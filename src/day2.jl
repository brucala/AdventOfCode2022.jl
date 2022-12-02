module Day2
include("utils.jl")
using .Utils
import .Utils: parse_input

export solve1, solve2, parse_input

###
### Parse
###

parseline(x::AbstractString) = Symbol.(split(x))
parse_input(x::AbstractString) = parseline.(splitlines(x))

###
### Part 1
###

score(x) = score(x...)
score(x, y) = win_score(x, y) + choice_score(y)
choice_score(x) = x === :X ? 1 : x === :Y ? 2 : 3
function win_score(x, y)
    y === :X && return x === :A ? 3 : x === :B ? 0 : 6
    y === :Y && return x === :A ? 6 : x === :B ? 3 : 0
    return x === :A ? 0 : x === :B ? 6 : 3
end

solve1(x) = score.(x) |> sum

###
### Part 2
###

score2(x) = score2(x...)
score2(x, y) = win_score2(y) + choice_score2(x, y)
function choice_score2(x, y)
    y === :X && return x === :A ? 3 : x === :B ? 1 : 2
    y === :Y && return x === :A ? 1 : x === :B ? 2 : 3
    return x === :A ? 2 : x === :B ? 3 : 1
end
win_score2(x) = x === :X ? 0 : x === :Y ? 3 : 6

solve2(x) = score2.(x) |> sum

end  # module
