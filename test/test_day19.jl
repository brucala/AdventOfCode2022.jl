module test_day19

using Test
using AdventOfCode2022.Day19

nday = 19

data = parse_input(nday)

test = parse_input(
"""
Blueprint 1: Each ore robot costs 4 ore. Each clay robot costs 2 ore. Each obsidian robot costs 3 ore and 14 clay. Each geode robot costs 2 ore and 7 obsidian.
Blueprint 2: Each ore robot costs 2 ore. Each clay robot costs 3 ore. Each obsidian robot costs 3 ore and 8 clay. Each geode robot costs 3 ore and 12 obsidian.
""" |> rstrip
)

@testset "Day$nday tests" begin
    @test solve1(test) == 33
    @test solve2(test) == 56 * 62
end

@testset "Day$nday solutions" begin
    @test solve1(data) == 1659
    #@test solve2(data) == ?
end

end  # module
