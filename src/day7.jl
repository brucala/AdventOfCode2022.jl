module Day7
include("utils.jl")
using .Utils
import .Utils: parse_input

export solve1, solve2, parse_input

###
### Parse
###

struct File
    name::String
    size::Int
end
mutable struct Dir
    name::String
    size::Union{Int, Nothing}
    parent::Union{Dir, Nothing}
    dirs::Dict{String, Dir}
    files::Dict{String, File}
end
Dir(name::AbstractString, parent::Union{Dir, Nothing}) = Dir(name, nothing, parent, Dict(), Dict())
Dir() = Dir("", nothing)

name(d::Dir) = d.name == "" ? "/" : d.name
function path(d::Dir)
    s = d.name == "" ? "/" : ""
    while !isnothing(d.parent)
        s = "/" * d.name * s
        d = d.parent
    end
    return s
end

add!(d::Dir, f::File) = d.files[f.name] = f
add!(d::Dir, child::Dir) = d.dirs[child.name] = child
function add!(d::Dir, s::AbstractString)
    x, name = split(s)
    x == "dir" && return add!(d, Dir(name, d))
    return add!(d, File(name, toint(x)))
end

size(x::Union{File, Dir}) = x.size
function size!(d::Dir)
    isnothing(d.size) || return d.size
    d.size = sum(size!.(values(d.dirs)), init=0) + sum(size.(values(d.files)), init=0)
    return d.size
end

Base.show(io::IO, d::Dir) = print(io, name(d), ": ", keys(d.dirs), " ", keys((d.files)))

function root(d::Dir)
    while true
        isnothing(d.parent) && return d
        d = d.parent
    end
end

function runcommand(d::Dir, command::Vector{T}) where T <: AbstractString
    command, results... = command
    if startswith(command, "cd")
        to = split(command)[2]
        to == ".." && return d.parent
        return d.dirs[to]
    end

    @assert startswith(command, "ls")
    for thing in results
        add!(d, thing)
    end
    return d
end

function parse_input(x::AbstractString)
    commands = splitlines.(strip.((split(x, "\$ ")[2:end])))
    d = Dir()
    for command in commands[2:end]
        d = runcommand(d, command)
    end
    d = root(d)
    size!(d)
    return root(d)
end

###
### Part 1
###

function dirsizes!(d::Dir, sizes=Dict{String, Int}())
    sizes[path(d)] = size(d)
    for child in values(d.dirs)
        dirsizes!(child, sizes)
    end
    return sizes
end

function solve1(x)
    sizes = dirsizes!(x)
    sum(size for size in values(sizes) if size <= 100000)
end

###
### Part 2
###

function solve2(x)
    total = 70000000
    required = 30000000
    unused = total - size(x)
    needed = required - unused
    sizes = dirsizes!(x)
    minimum(size for size in values(sizes) if size >= needed)
end

end  # module
