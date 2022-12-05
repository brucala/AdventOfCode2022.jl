module test_day5

using Test
using AdventOfCode2022.Day5

nday = 5

data = parse_input(nday)

test = parse_input(
"""
    [D]
[N] [C]
[Z] [M] [P]
 1   2   3

move 1 from 2 to 1
move 3 from 1 to 3
move 2 from 2 to 1
move 1 from 1 to 2
"""
)

@testset "Day$nday tests" begin
    @test solve1(test) == "CMZ"
    @test solve2(test) == "MCD"
end

@testset "Day$nday solutions" begin
    @test solve1(data) == "JCMHLVGMG"
    @test solve2(data) == "LVMRWSSPZ"
end

end  # module
