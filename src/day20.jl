module Day20
include("utils.jl")
using .Utils
import .Utils: parse_input

export solve1, solve2, parse_input

###
### Parse
###

function modvalue(val::Int, mod::Int)
    modvalue = abs(val) % (mod - 1)
    modvalue = modvalue < ((mod -1) ÷ 2) ? modvalue : modvalue - mod + 1
    return sign(val) * modvalue
end

mutable struct CircularList{N}
    value::Int
    modvalue::Int
    next::CircularList{N}
    prev::CircularList{N}
    CircularList(value::Int, n::Int) = (x = new{n}(value, modvalue(value, n)); x.next = x; x.prev = x)
end
function CircularList(v::Vector{Int})
    n = length(v)
    x = CircularList(v[1], n)
    for val in v[2:n]
        x = push!(x, val)
    end
    return x.next
end
Base.length(::CircularList{N}) where N = N
function Base.push!(c::CircularList, val::Int)
    x = CircularList(val, length(c))
    x.prev, x.next = c, c.next
    c.next = x
    x.next.prev = x
    return x
end
value(c::CircularList) = c.value

parse_input(x::AbstractString) = toint.(splitlines(x))

###
### Part 1
###


Base.eltype(::CircularList) = Int
Base.iterate(c::CircularList) = (c.value, (2, c.next))
function Base.iterate(c::CircularList, state)
    n, x = state
    n > length(c) && return nothing
    nextstate = (n+1, x.next)
    return (x.value, nextstate)
end
function vector(c::CircularList)
    v = CircularList[]
    for _ in 1:length(c)
        push!(v, c)
        c = c.next
    end
    return v
end

function next(c::CircularList, n::Int)
    n < 0 && return prev(c, -n)
    x = c.next
    for _ in 2:n
        x = x.next
    end
    return x
end
function prev(c::CircularList, n::Int)
    n < 0 && return next(c, -n)
    x = c.prev
    for _ in 1:n
        x = x.prev
    end
    return x
end
function mixing(c::CircularList)
    c.modvalue == 0 && return c
    left, right = c.prev, c.next
    newleft = next(c, c.modvalue)
    newright = newleft.next
    left.next, right.prev = right, left
    c.next, c.prev = newright, newleft
    newleft.next, newright.prev = c, c
    return c
end

coordinates(c::CircularList) = sum(i -> next(c, i % length(c)).value, [1000, 2000, 3000])

function solve1(x)
    c = CircularList(x)
    original = vector(c)
    i0 = findfirst(i -> i.value == 0, original)
    for v in original
        mixing(v)
    end
    return coordinates(original[i0])
end

###
### Part 2
###

function solve2(x)
    key = 811589153
    c = CircularList(x .* key)
    original = vector(c)
    i0 = findfirst(i -> i.value == 0, original)
    for _ in 1:10, v in original
        mixing(v)
    end
    return coordinates(original[i0])
end

###
### Extra
###

Base.show(io::IO, c::CircularList) = print(io, "$(length(c))-element circular list: ", collect(c))

end  # module
