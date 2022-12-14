module test_day10

using Test
using AdventOfCode2022.Day10

nday = 10

data = parse_input(nday)

test = parse_example(nday)

expected_test = """
##..##..##..##..##..##..##..##..##..##..
###...###...###...###...###...###...###.
####....####....####....####....####....
#####.....#####.....#####.....#####.....
######......######......######......####
#######.......#######.......#######.....
"""

expected = """
####.###...##..###..####.###...##....##.
#....#..#.#..#.#..#.#....#..#.#..#....#.
###..#..#.#....#..#.###..#..#.#.......#.
#....###..#....###..#....###..#.......#.
#....#.#..#..#.#.#..#....#....#..#.#..#.
####.#..#..##..#..#.####.#.....##...##..
"""


@testset "Day$nday tests" begin
    @test solve1(test) == 13140
    @test solve2(test) == expected_test
end

@testset "Day$nday solutions" begin
    @test solve1(data) == 11720
    @test solve2(data) == expected
end

end  # module
