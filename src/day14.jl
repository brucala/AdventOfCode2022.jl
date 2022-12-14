module Day14
include("utils.jl")
using .Utils
import .Utils: parse_input

export solve1, solve2, parse_input

###
### Parse
###

const Point = NTuple{2, Int}

struct Cave
    source::Point
    horizontal::Dict{Int, Vector{UnitRange{Int}}}
    vertical::Dict{Int, Vector{UnitRange{Int}}}
    sand::Vector{Point}
end
Cave() = Cave((500, 0), Dict(), Dict(), [])
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
    return false
end

maxy(c::Cave) = maximum(keys(c.horizontal))

fall!(c::Cave, floor::Bool = false) = fall!(c, c.source, floor)
function fall!(c::Cave, p::Point, floor::Bool)
    x, y = p
    !floor && y > maxy(c) && return false
    if floor && y == maxy(c) + 1
        push!(c.sand, p)
        return true
    end
    (x, y + 1) in c || return fall!(c, (x, y + 1), floor)
    (x - 1, y + 1) in c || return fall!(c, (x - 1, y + 1), floor)
    (x + 1, y + 1) in c || return fall!(c, (x + 1, y + 1), floor)
    floor && y == maxy(c) + 1 && return false
    push!(c.sand, p)
    return p != c.source
end

function solve(x, floor = false)
    for i in 0:100_000
        fall!(x, floor) || return i
    end
    return -5  # didn't reach solution
end

#solve1(x) = solve(deepcopy(x))  # 32 ms

function solve1(x, floor = false)
    c = deepcopy(x)
    ymax = maxy(c)
    queue = [c.source]
    while !isempty(queue)
        x, y = pop!(queue)
        while true
            !floor && y > ymax && return length(c.sand)
            if floor && y == ymax + 1
                push!(c.sand, (x, y))
                break
            elseif (x, y + 1) ∉ c
                push!(queue, (x, y))
                y = y +1
                continue
            elseif (x - 1, y + 1) ∉ c
                push!(queue, (x, y))
                x, y = x - 1, y +1
                continue
            elseif (x + 1, y + 1) ∉ c
                push!(queue, (x, y))
                x, y = x + 1, y +1
                continue
            else
                push!(c.sand, (x, y))
                (x, y) == c.source && return length(c.sand)
                break
            end
        end
    end
end

###
### Part 2
###

#function solve2(x)
#    c = deepcopy(x)
#    return solve(c, true) + 1
#end

solve2(x) = solve1(x, true)

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
