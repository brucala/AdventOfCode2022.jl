using Test
using AdventOfCode2022

@testset "AdventOfCode2022 tests" begin
     for day in solved_days
        @testset "Day $day" begin include("test_day$day.jl") end
     end
end
