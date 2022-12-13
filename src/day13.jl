module Day13
include("utils.jl")
using .Utils
import .Utils: parse_input

export solve1, solve2, parse_input

###
### Parse
###

parse_packet(s::AbstractString) = eval(Meta.parse(s))  # very slow
parse_pair(s::AbstractString) = parse_packet.(split(s, "\n"))
parse_input(x::AbstractString) = parse_pair.(split(x, "\n\n"))

###
### Part 1
###

compare(l::Int, r::Int) = l < r ? :l : l > r ? :r : :same
compare(l::Int, r::Vector) = compare([l], r)
compare(l::Vector, r::Int) = compare(l, [r])
function compare(l::Vector, r::Vector)
    nl, nr = length.((l, r))
    for i in 1:min(nl, nr)
        res = compare(l[i], r[i])
        res == :same || return res
    end
    return nl < nr ? :l : nl > nr ? :r : :same
end

lt(l, r) = compare(l, r) === :l

function solve1(x)
    res = 0
    for (i, (l, r)) in enumerate(x)
        lt(l, r) && (res += i)
    end
    res
end

###
### Part 2
###

function solve2(x)
    divider = ([[2]], [[6]])
    packets = Iterators.flatten(x)
    ordered = sort(divider ∪ packets, lt=lt)
    return findfirst(==([[2]]), ordered) * findfirst(==([[6]]), ordered)
end

end  # module
