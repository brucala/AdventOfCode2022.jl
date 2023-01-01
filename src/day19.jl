module Day19
include("utils.jl")
using .Utils
import .Utils: parse_input

export solve1, solve2, parse_input

###
### Parse
###

struct Blueprint
    matrix::Matrix{Int}
end
Blueprint(v::Vector{Int}) = Blueprint([
    v[1] v[2] v[3] v[5]
    0 0 v[4] 0
    0 0 0 v[6]
    0 0 0 0
])
Blueprint(line::AbstractString) = Blueprint(capture_numbers(line)[2:end])

capture_numbers(x) = map(m -> toint(m.match), eachmatch(r"\d+", x))

parse_input(x::AbstractString) = Blueprint.(splitlines(x))

###
### Part 1
###

struct Factory
    time::Int
    robots::Vector{Int}  # ore, clay, obsidian, geode
    resources::Vector{Int}  # ore, clay, obsidian, geode
    blueprint::Blueprint
end
Factory(blueprint::Blueprint) = Factory(0, [1, 0, 0, 0], [0, 0, 0, 0], blueprint)

ore(f::Factory) = f.resources[1]
clay(f::Factory) = f.resources[2]
obsidian(f::Factory) = f.resources[3]
geode(f::Factory) = f.resources[4]

function next_ore(f::Factory)
    f.robots[1] == 0 && return 100
    return max(0, cld(f.blueprint.matrix[1, 1] - ore(f), f.robots[1])) + 1
end
function next_clay(f::Factory)
    f.robots[1] == 0 && return 100
    return max(0, cld(f.blueprint.matrix[1, 2] - ore(f), f.robots[1])) + 1
end
function next_obsidian(f::Factory)
    (f.robots[1] == 0 || f.robots[2] == 0) && return 100
    return max(
        0,
        cld(f.blueprint.matrix[1, 3] - ore(f), f.robots[1]),
        cld(f.blueprint.matrix[2, 3] - clay(f), f.robots[2]),
    ) + 1
end
function next_geode(f::Factory)
    (f.robots[1] == 0 || f.robots[3] == 0) && return 100
    return max(
        0,
        cld(f.blueprint.matrix[1, 4] - ore(f), f.robots[1]),
        cld(f.blueprint.matrix[3, 4] - obsidian(f), f.robots[3]),
    ) + 1
end

build(f::Factory, Δt, v) = Factory(
    f.time + Δt,
    f.robots .+ v,
    f.resources .+ f.robots .* Δt .- f.blueprint.matrix * v,
    f.blueprint,
)
build_ore(f::Factory) = build(f, next_ore(f), [1, 0, 0, 0])
build_clay(f::Factory) = build(f, next_clay(f), [0, 1, 0, 0])
build_obsidian(f::Factory) = build(f, next_obsidian(f), [0, 0, 1, 0])
build_geode(f::Factory) = build(f, next_geode(f), [0, 0, 0, 1])

tria(n) = n * (n + 1) ÷ 2
potential_clay(f::Factory, tmax=24) = clay(f) + f.robots[2] * (tmax - f.time)  + tria(tmax - f.time)#sum(i -> f.robots[2] + i, 1:(tmax - f.time))
function potential_obsidian(f::Factory, tmax=24)
    n, r = obsidian(f), f.robots[3]
    Δn = potential_clay(f, tmax) ÷ f.blueprint.matrix[2,3]
    Δt = tmax - f.time
    Δn >= Δt && return n + r * Δt + tria(Δt)
    n += (n + Δn) * (Δt - Δn)
    Δn == 0 && return n
    return n + r * Δn + tria(Δn)
end
function potential_geode(f::Factory, tmax=24)
    n, r = geode(f), f.robots[4]
    Δn = potential_obsidian(f, tmax) ÷ f.blueprint.matrix[3,4]
    Δt = tmax - f.time
    Δn >= Δt && return n + r * Δt + tria(Δt)
    n += (n+Δn)*(Δt - Δn)
    Δn == 0 && return n
    return n + r * Δn + tria(Δn)
end

function maxgeodes(f::Factory; tmax=24, nmax=0)
    f.time >= tmax && return 0
    potential_geode(f, tmax) < nmax && return 0
    n = geode(f) + (tmax - f.time) * f.robots[4]  # do nothing
    n = max(n, maxgeodes(build_geode(f), tmax=tmax, nmax=max(n, nmax)))
    if f.robots[3] < maximum(f.blueprint.matrix[3,:])
        n = max(n, maxgeodes(build_obsidian(f), tmax=tmax, nmax=max(n, nmax)))
    end
    if f.robots[2] < maximum(f.blueprint.matrix[2,:])
        n = max(n, maxgeodes(build_clay(f), tmax=tmax, nmax=max(n, nmax)))
    end
    if f.robots[1] < maximum(f.blueprint.matrix[1,:])
        n = max(n, maxgeodes(build_ore(f), tmax=tmax, nmax=max(n, nmax)))
    end
    return n
end

solve1(x) = sum(i -> i * maxgeodes(Factory(x[i])), 1:length(x))

###
### Part 2
###

solve2(x) = prod(i -> maxgeodes(Factory(x[i]); tmax=32), 1:min(3, length(x)))

end  # module
