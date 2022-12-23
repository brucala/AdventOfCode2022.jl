module test_day22

using Test
using AdventOfCode2022.Day22

nday = 22

data = parse_input(nday)

test = parse_input(
"""
        ...#
        .#..
        #...
        ....
...#.......#
........#...
..#....#....
..........#.
        ...#....
        .....#..
        .#......
        ......#.

10R5L5R10L4R5L5
""" |> rstrip
)

@testset "Day$nday tests" begin
    @test solve1(test) == 6032
    @test solve2(test, 4) == 5031
end

@testset "Day$nday solutions" begin
    @test solve1(data) == 43466
    @test solve2(data) == 162155
end

end  # module
