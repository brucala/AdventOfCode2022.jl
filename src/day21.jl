module Day21
include("utils.jl")
using .Utils
import .Utils: parse_input

export solve1, solve2, parse_input

###
### Parse
###

struct Operation
    left::String
    operator::Function
    right::String
end
Operation(
    left::AbstractString, op::AbstractString, right::AbstractString
) = Operation(left, operator(op), right)
function operator(op::AbstractString)
    op = eval(Symbol(op))
    return (op) === (/) ? (÷) : (op)
end
#operator(op::AbstractString) = op == "+" ? (+) : op == "-" ? (-) : op == "*" ? (*) : (÷)

struct Monkeys
    operations::Dict{String, Operation}
    numbers::Dict{String, Int}
end
function Monkeys(x::AbstractString)
    m = Monkeys(Dict(), Dict())
    for line in splitlines(x)
        name, job = split(line, ": ")
        job = split(job)
        if length(job) == 1
            m.numbers[name] = toint(job[1])
        else
            m.operations[name] = Operation(job...)
        end
    end
    return m
end

parse_input(x::AbstractString) = Monkeys(x)

###
### Part 1
###

function find!(m::Monkeys, name::String)
    haskey(m.numbers, name) && return m.numbers[name]
    op = m.operations[name]
    left = find!(m, op.left)
    right = find!(m, op.right)
    value = op.operator(left, right)
    #m.numbers[name] = value
    return value
end

solve1(x) = find!(x, "root")

###
### Part 2
###

function find2!(m::Monkeys, name::String)
    name == "humn" && return nothing
    haskey(m.numbers, name) && return m.numbers[name]
    op = m.operations[name]
    left = find2!(m, op.left)
    right = find2!(m, op.right)
    (isnothing(left) || isnothing(right)) && return nothing
    value = op.operator(left, right)
    #m.numbers[name] = value
    return value
end

function inverse(op, left, right, res)
    if op == +
        isnothing(left) && return res - right
        return res - left
    elseif op == -
        isnothing(left) && return res + right
        return left - res
    elseif op == *
        isnothing(left) && return res ÷ right
        return res ÷ left
    else
        isnothing(left) && return res * right
        return left / res
    end
end

function propagate(m::Monkeys, name::String, val::Int)
    name == "humn" && return val
    op = m.operations[name]
    left = find2!(m, op.left)
    right = find2!(m, op.right)
    operator = op.operator
    val = inverse(operator, left, right, val)
    isnothing(left) && return propagate(m, op.left, val)
    return propagate(m, op.right, val)
end

function solve2(x)
    root = x.operations["root"]
    left = find2!(x, root.left)
    right = find2!(x, root.right)
    isnothing(left) && return propagate(x, root.left, right)
    return propagate(x, root.right, left)
end

end  # module
