module test_day23

using Test
using AdventOfCode2022.Day23

nday = 23

data = parse_input(nday)

test = parse_input(
"""
....#..
..###.#
#...#.#
.#...##
#.###..
##.#.##
.#..#..
""" |> rstrip
)

@testset "Day$nday tests" begin
    @test solve1(test) == 110
    @test solve2(test) == 20
end

@testset "Day$nday solutions" begin
    @test solve1(data) == 4288
    @test solve2(data) == 940
end

end  # module
