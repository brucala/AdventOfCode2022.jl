module Day16
include("utils.jl")
using .Utils
import .Utils: parse_input

export solve1, solve2, parse_input

###
### Parse
###

function parse_line(line)
    sline = split(line)
    valve = sline[2]
    flowrate = toint(sline[5][6:end-1])
    conections = strip.(sline[10:end], ',')
    return valve, flowrate, conections
end

function parse_input(x::AbstractString)
    flowrate = Dict{String, Int}()
    conections = Set{Set{String}}()
    for line in splitlines(x)
        valve, rate, leadsto = parse_line(line)
        flowrate[valve] = rate
        #foreach(c -> push!(conections, tuple(sort([valve, c])...)), leadsto)
        foreach(c -> push!(conections, Set([valve, c])), leadsto)
    end
    return flowrate, conections
end

###
### Part 1
###

struct Distances
    d::Dict{Set{String}, Int}
end
function Base.get(d::Distances, key::String)
    Dict(
        first(setdiff(k, Set([key]))) => v
        for (k, v) in d.d
        if key in k
    )
end

function combinations(valves)
    s = Set{Set{String}}()
    for i in 1:length(valves)-1, j in i+1:length(valves)
        push!(s, Set([valves[i], valves[j]]))
    end
    return s
end

function distances(valves, conections)
    left = setdiff(combinations(valves), conections)
    distances = Dict(1 => conections)
    d = Distances(Dict(c => 1 for c in conections))
    for i in 1:100
        isempty(left) && break
        for pair1 in distances[i], pair2 in conections
            u = pair1 ∪ pair2
            length(u) != 3 && continue
            newpair = setdiff(u, pair1 ∩ pair2)
            newpair in left || continue
            #(newpair in conections || newpair in distances[i]) && continue
            push!(get!(distances, i + 1, Set()), newpair)
            d.d[newpair] = i + 1
            pop!(left, newpair)
        end
    end
    return d
end

function pressure(p, t, pos, open, flowrate, distances, best=nothing)
    isnothing(best) && (best = Dict{Set{String}, Int}())
    haskey(best, open) && p <= best[open] && return -1
    best[open] = p
    maxp = p
    #t > 15 && @show t, p, pos, open, setdiff(Set(keys(flowrate)), open)
    #t > 15 && return p
    for valve in setdiff(Set(keys(flowrate)), open)
        dist = get(distances, pos)[valve]
        newt = t + dist + 1
        newt > 30 && continue
        newp = p + flowrate[valve] * (30 - newt)
        newopen = open ∪ Set([valve])
        #@show newt, newp, valve, newopen
        maxp = max(maxp, pressure(newp, newt, valve, newopen, flowrate, distances, best))
    end
    return maxp
end

function solve1(x)
    flowrate, conections = x
    valves = sort(collect(keys(flowrate)))
    d = distances(valves, conections)
    flowrate = Dict(k => v for (k, v) in flowrate if v !=0)
    #return d, flowrate
    p, t, pos, open = 0, 0, "AA", Set{String}()
    return pressure(p, t, pos, open, flowrate, d)
end

###
### Part 2
###

function pressure2(p, t1, t2, pos1, pos2, open, flowrate, distances, best=nothing)
    isnothing(best) && (best = Dict{Set{String}, Int}())
    haskey(best, open) && p <= best[open] && return -1
    best[open] = p
    maxp = p
    #t > 15 && @show t, p, pos, open, setdiff(Set(keys(flowrate)), open)
    #t > 15 && return p
    for valve in setdiff(Set(keys(flowrate)), open)
        dist = get(distances, pos1)[valve]
        newt = t1 + dist + 1
        newt > 30 && continue
        newp = p + flowrate[valve] * (30 - newt)
        newopen = open ∪ Set([valve])
        #@show newt, newp, valve, newopen
        if newt < t2
            maxp = max(maxp, pressure2(newp, newt, t2, valve, pos2, newopen, flowrate, distances, best))
        else
            maxp = max(maxp, pressure2(newp, t2, newt, pos2, valve, newopen, flowrate, distances, best))
        end
    end
    return maxp
end

function solve2(x)
    flowrate, conections = x
    valves = sort(collect(keys(flowrate)))
    d = distances(valves, conections)
    flowrate = Dict(k => v for (k, v) in flowrate if v !=0)
    #return d, flowrate
    p, t, pos, open = 0, 4, "AA", Set{String}()
    return pressure2(p, t, t, pos, pos, open, flowrate, d)
end

end  # module
