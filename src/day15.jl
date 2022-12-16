module Day15
include("utils.jl")
using .Utils
import .Utils: parse_input

export solve1, solve2, parse_input

###
### Parse
###

const Range = UnitRange{Int}
const Point = NTuple{2, Int}
struct Diamond
    center::Point
    beacon::Point
    radius::Int
end
Diamond(x1, y1, x2, y2) = Diamond((x1, y1), (x2, y2))
Diamond(s::Point, b::Point) = Diamond(s, b, distance(s, b))
distance(p1::Point, p2::Point) = sum(abs.(p1 .- p2))

capture_numbers(x) = map(m -> toint(m.match), eachmatch(r"-?\d+", x))
parse_line(x) = Diamond(capture_numbers(x)...)

parse_input(x::AbstractString) = parse_line.(splitlines(x))

###
### Part 1
###

myrange(c::Int, d::Int) = (c-d):(c+d)

function yslice(d::Diamond, y::Int)
    y ∉ myrange(d.center[2], d.radius) && return 0:-1  # empty Range
    dy = abs(y - d.center[2])
    # d.radius >= dy || return 0:-1
    dx = d.radius - dy
    return myrange(d.center[1], dx)
end


join(r1::Range, r2::Range) = min(r1.start, r2.start):max(r1.stop, r2.stop)  # assumes not disjoint
Base.isdisjoint(r1::Range, r2::Range) = r1.stop < r2.start || r2.stop < r1.start
function Base.union(r::Range, v::Vector{Range})
    res = Range[]
    for x in v
        if isdisjoint(r, x)
            push!(res, x)
        else
            r = join(r, x)
        end
    end
    return push!(res, r)
end

function beacons(v::Vector{Diamond})
    beacons = Set{Point}()
    foreach(d -> push!(beacons, d.beacon), v)
    return beacons
end

function slices(diamonds, y)
    slices = Range[]
    for d in diamonds
        r = yslice(d, y)
        isempty(r) && continue
        slices = r ∪ slices
    end
    return slices
end

function solve1(x, y=2_000_000)
    v = slices(x, y)
    b = beacons(x)
    n = sum(i -> any(r -> i[2] == y && i[1] in r, v), b)
    return sum(length, v) - n
end

###
### Part 2
###


tuning_frequency(x, y) = x * 4000000 + y

Base.setdiff(x::Range, y::Range) = min(x.start, y.start):min(x.stop, y.start)
function notwithinedge(diamonds, y, edge)
    slices = Range[]
    for d in diamonds
        r = yslice(d, y)
        r = max(r.start, 0):min(r.stop, edge)
        isempty(r) && continue
        slices = r ∪ slices
        slices[1] == 0:edge && return 1:0
    end
    @assert length(slices) == 2
    x = minimum(maximum.(slices))+1:maximum(minimum.(slices))-1
    @assert length(x) == 1
    return x[1]
end

function solve2(diamonds, edge=4000000)
    for y in 0:edge
        x = notwithinedge(diamonds, y, edge)
        !isempty(x) && return tuning_frequency(x, y)
    end
end

end  # module
