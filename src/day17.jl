module Day17
include("utils.jl")
using .Utils
import .Utils: parse_input

export solve1, solve2, parse_input

###
### Parse
###

abstract type Shape end

struct HLine <: Shape end
struct Cross <: Shape end
struct Elle <: Shape end
struct VLine <: Shape end
struct Square <: Shape end

pieces(::Type{VLine}) = [(0, 0), (0, 1), (0, 2), (0, 3)]
pieces(::Type{HLine}) = [(0, 0), (1, 0), (2, 0), (3, 0)]
pieces(::Type{Cross}) = [(0, 1), (1, 0), (1, 1), (1, 2), (2, 1)]
pieces(::Type{Square}) = [(0, 0), (1, 0), (0,1), (1,1)]
pieces(::Type{Elle}) = [(0, 0), (1, 0), (2, 0), (2, 1), (2, 2)]

Base.size(::Type{VLine}) = (1, 4)
Base.size(::Type{HLine}) = (4, 1)
Base.size(::Type{Cross}) = (3, 3)
Base.size(::Type{Square}) = (2, 2)
Base.size(::Type{Elle}) = (3, 3)

const shape_order = [HLine, Cross, Elle, VLine, Square]

mutable struct Rock{T <: Shape}
    left::Int
    bottom::Int
end
pos(r::Rock) = (r.left, r.bottom)
shape(r::Rock{T}) where T = T
Base.size(r::Rock{T}) where T = size(T)
pieces(r::Rock{T}) where T = map(x -> pos(r) .+ x, pieces(T))
left(r::Rock) = r.left
right(r::Rock{T}) where T = left(r) + size(T)[1] - 1
bottom(r::Rock) = r.bottom
top(r::Rock{T}) where T = bottom(r) + size(T)[2] - 1

shift(r::Rock{T}, d::NTuple{2,Int}) where T = Rock{T}(r.left + d[1], r.bottom + d[2])

mutable struct Chamber
    wind::Vector{Char}
    time::Int
    falling::Rock
    resting::Dict{Int, Rock} # time -> rock
    rest_index::Vector{Int} # nrock -> time
    top::Int
end
Chamber(wind) = Chamber(wind, 0, Rock{HLine}(3, 4), Dict(), [], 0)
top(c::Chamber) = c.top
resting(c::Chamber) = values(c.resting)
resting_pieces(c::Chamber) = length(c) > 0 ? Set(union(pieces.(resting(c))...)) : Set()
falling_pieces(c::Chamber) = Set(pieces(c.falling))

parse_input(x::AbstractString) = collect(x)

###
### Part 1
###

Base.length(c::Chamber) = length(c.resting)
function Base.isdisjoint(r1::Rock, r2::Rock)
    return (
        right(r1) < left(r2)
        || left(r1) > right(r2)
        || top(r1) < bottom(r2)
        || bottom(r1) > top(r1)
    )
end
function overlaps(r1::Rock, r2::Rock)
    isdisjoint(r1, r2) && return false
    for p1 in pieces(r1), p2 in pieces(r2)
        p1 == p2 && return true
    end
    # length(set(p1) ∩ set(p2)) > 0
    return false
end

function canmoveleft(c::Chamber)
    left(c.falling) == 1 && return false
    rock = shift(c.falling, (-1, 0))
    any(r -> overlaps(r, rock), resting(c)) && return false
    return true
end
function canmoveright(c::Chamber)
    right(c.falling) == 7 && return false
    rock = shift(c.falling, (1, 0))
    any(r -> overlaps(r, rock), resting(c)) && return false
    return true
end
function canmovedown(c::Chamber)
    bottom(c.falling) == 1 && return false
    rock = shift(c.falling, (0, -1))
    any(r -> overlaps(r, rock), resting(c)) && return false
    return true
end
function gas!(c::Chamber)
    wind = c.wind[mod1(c.time, length(c.wind))]
    if wind === '<' && canmoveleft(c)
        c.falling.left -= 1
        return true
    elseif wind === '>' && canmoveright(c)
        c.falling.left += 1
        return true
    end
    return false
end
function fall!(c::Chamber)
    if canmovedown(c)
        c.falling.bottom -= 1
        return true
    end
    return false
end
function newrock!(c::Chamber)
    newshape = shape_order[mod1(length(c) + 1, 5)]
    c.falling = Rock{newshape}(3, c.top + 4)
end
function step!(c::Chamber)
    c.time += 1
    gas!(c)
    fallen = fall!(c)
    if !fallen
        c.resting[c.time] = c.falling
        push!(c.rest_index, c.time)
        c.top = max(c.top, top(c.falling))
        newrock!(c)
    end
    return fallen
end
rockfall!(c::Chamber) = while step!(c) end

function solve1(x, n=2022)
    c = Chamber(x)
    foreach(i -> rockfall!(c), 1:n)
    return top(c)
end

###
### Part 2
###

function find_repetition(c::Chamber, nchecks = 40)
    n = length(c)
    t = c.time
    r = c.resting[t]
    nwind = length(c.wind)
    t0 = t
    while true
        t0 -= nwind
        t0 - nwind < 1 && break
        !haskey(c.resting, t0) && continue
        r0 = c.resting[t0]
        (shape(r0) == shape(r) && left(r0) == left(r)) || continue
        n0 = findfirst(==(t0), c.rest_index)
        dt = t - t0
        n1 = n
        checkpass = true
        for i in 1:nchecks
            n0 -= 1
            t0 = c.rest_index[n0]
            r0 = c.resting[t0]
            n1 -= 1
            t1 = c.rest_index[n1]
            r1 = c.resting[t1]
            t1 - t0 == dt && shape(r0) == shape(r1) && left(r0) == left(r1) && continue
            checkpass = false
            break
        end
        checkpass && return t - dt
    end
    return -1
end

heightat(c::Chamber, n::Int) = maximum(i -> top(c.resting[c.rest_index[i]]), n-5:n)

function height!(c::Chamber, t::Int, N::Int)
    n = findfirst(==(t), c.rest_index)
    Δn = length(c) - n
    needed_for_mult = (N - n) % Δn
    n += needed_for_mult

    foreach(i -> rockfall!(c), 1:needed_for_mult)

    h = heightat(c::Chamber, n::Int)
    Δh = top(c) - h
    return h + Δh * (N-n) ÷ Δn
end

function solve2(x, N=1_000_000_000_000)
    c = Chamber(x)
    max_iter = 10_000
    for _ in 1:max_iter
        rockfall!(c)
        t = find_repetition(c, 50)
        t < 1 && continue
        return height!(c, t, N)
    end
end

###
### Extra
###

function Base.show(io::IO, c::Chamber)
    height = top(c.falling)
    height > 500 && return print(io, "chamber with $(length(c)) rocks forming a $height tall tower")
    resting = resting_pieces(c)
    falling = falling_pieces(c)
    for y in height:-1:1
        print(io, "|")
        for x in 1:7
            if (x, y) in falling
                print(io, "@")
            elseif (x,y) in resting
                print(io, "#")
            else
                print(io, ".")
            end
        end
        println(io, "|")
    end
    print("+-------+")
end

end  # module
