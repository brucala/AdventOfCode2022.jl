module test_day16

using Test
using AdventOfCode2022.Day16

nday = 16

data = parse_input(nday)

test = parse_input(
"""
Valve AA has flow rate=0; tunnels lead to valves DD, II, BB
Valve BB has flow rate=13; tunnels lead to valves CC, AA
Valve CC has flow rate=2; tunnels lead to valves DD, BB
Valve DD has flow rate=20; tunnels lead to valves CC, AA, EE
Valve EE has flow rate=3; tunnels lead to valves FF, DD
Valve FF has flow rate=0; tunnels lead to valves EE, GG
Valve GG has flow rate=0; tunnels lead to valves FF, HH
Valve HH has flow rate=22; tunnel leads to valve GG
Valve II has flow rate=0; tunnels lead to valves AA, JJ
Valve JJ has flow rate=21; tunnel leads to valve II
""" |> rstrip
)

@testset "Day$nday tests" begin
    @test solve1(test) == 1651
    @test solve2(test) == 1707
end

@testset "Day$nday solutions" begin
    @test solve1(data) == 1724
    @test solve2(data) == 2283
end

end  # module
