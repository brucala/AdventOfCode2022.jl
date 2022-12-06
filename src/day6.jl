module Day6
include("utils.jl")
using .Utils
import .Utils: parse_input

export solve1, solve2, parse_input

###
### Parse
###

parse_input(x::AbstractString) = x

###
### Part 1
###

# naive
#function solve1(x, n=4)
#    for i in n:length(x)
#        length(Set(x[i-n+1:i])) == n && return i
#    end
#end

# optimized
struct Counter
    counter::Dict{Char, Int}
    values::Set{Char}
end
Counter() = Counter(Dict(), Set())
function Counter(s::AbstractString)
    c = Counter()
    foreach(i -> add!(c, i), s)
    return c
end
function add!(c::Counter, x::Char)
    setindex!(c.counter, get(c.counter, x, 0) + 1, x)
    push!(c.values, x)
    return
end
function remove!(c::Counter, x::Char)
    c.counter[x] -= 1
    c.counter[x] == 0 && pop!(c.values, x)
    return
end
Base.length(c::Counter) = length(c.values)

function solve1(x, n=4)
    c = Counter(x[1:n])
    length(c) == n && return n
    for i in n+1:length(x)
        remove!(c, x[i-n])
        add!(c, x[i])
        length(c) == n && return i
    end
end

###
### Part 2
###

solve2(x) = solve1(x, 14)

end  # module
