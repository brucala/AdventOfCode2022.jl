module Day14
include("utils.jl")
using .Utils
import .Utils: parse_input

export solve1, solve2, parse_input

###
### Parse
###

const Point = NTuple{2, Int}

mutable struct Cave
    source::Point
    horizontal::Dict{Int, Vector{UnitRange{Int}}}
    vertical::Dict{Int, Vector{UnitRange{Int}}}
    sand::Vector{Point}
    floor::Bool
end
Cave(floor = false) = Cave((500, 0), Dict(), Dict(), [], floor)
addvertical!(c::Cave, x::Int, y::UnitRange{Int}) = push!(get!(c.vertical, x, []), y)
addhorizontal!(c::Cave, x::Int, y::UnitRange{Int}) = push!(get!(c.horizontal, x, []), y)

function addrocks!(c::Cave, s::AbstractString)
    pairs = getpair.(split(s, " -> "))
    for i in 1:length(pairs)-1
        x1, y1 = pairs[i]
        x2, y2 = pairs[i+1]
        if x1 == x2
            addvertical!(c, x1, y1 < y2 ? (y1:y2) : (y2:y1))
        else
            @assert y1 == y2
            addhorizontal!(c, y1, x1 < x2 ? (x1:x2) : (x2:x1))
        end
    end
end

getpair(s::AbstractString) = toint.(split(s, ","))

function parse_input(x::AbstractString)
    c = Cave()
    foreach(i -> addrocks!(c, i), splitlines(x))
    return c
end

###
### Part 1
###

function Base.in(p::Point, c::Cave)
    p in c.sand && return true
    x, y = p
    haskey(c.vertical, x) && any(r -> y in r, c.vertical[x]) && return true
    haskey(c.horizontal, y) && any(r -> x in r, c.horizontal[y]) && return true
    c.floor && y == maxy(c)&& return true
    return false
end

maxy(c::Cave) = maximum(keys(c.horizontal)) + (c.floor ? 2 : 0)

fall!(c::Cave) = fall!(c, c.source)
function fall!(c::Cave, p::Point)
    x, y = p
    y > maxy(c) && return false
    (x, y + 1) in c || return fall!(c, (x, y + 1))
    (x - 1, y + 1) in c || return fall!(c, (x - 1, y + 1))
    (x + 1, y + 1) in c || return fall!(c, (x + 1, y + 1))
    push!(c.sand, p)
    return p != c.source
end

function solve(x)
    for i in 0:100_000
        fall!(x) || return i
    end
    return -5  # didn't reach solution
end

solve1(x) = solve(deepcopy(x))

###
### Part 2
###

#maxx(c::Cave) = maximum(maximum.(map(i -> maximum.(i), values(c.horizontal))))
#minx(c::Cave) = minimum(minimum.(map(i -> minimum.(i), values(c.horizontal))))
#addfloor!(c::Cave) = addhorizontal!(c, maxy(c) + 2, minx(c)-10:maxx(c)+10)
#addfloor!(c::Cave) = addhorizontal!(c, maxy(c) + 2, typemin(Int):typemax(Int))

function solve2(x)
    c = deepcopy(x)
    #addfloor!(c)
    c.floor = true
    return solve(c) + 1
    solve(c)
    return c
end

###
### Extra
###

rocks(c::Cave) = hrocks(c) ∪ vrocks(c)
function vrocks(c::Cave)
    rocks = Point[]
    for (x, v) in c.vertical
        for r in v
            foreach(y -> push!(rocks, (x, y)), r)
        end
    end
    return rocks
end
function hrocks(c::Cave)
    rocks = Point[]
    for (y, h) in c.horizontal
        for r in h
            foreach(x -> push!(rocks, (x, y)), r)
        end
    end
    return rocks
end

function Base.show(io::IO, c::Cave)
    rock = rocks(c)
    sand = c.sand
    xmin = minimum(i -> i[1], rock ∪ sand)
    xmax = maximum(i -> i[1], rock ∪ sand)
    ymax = maxy(c)
    cave = Char[]
    for y in 0:ymax
        for x in xmin:xmax
            if (x, y) in sand
                push!(cave, 'o')
            elseif (x, y) in rock
                push!(cave, '#')
            else
                push!(cave, '.')
            end
        end
        push!(cave, '\n')
    end
    print(io, join(cave))
end

end  # module
