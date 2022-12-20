module test_day17

using Test
using AdventOfCode2022.Day17

nday = 17

data = parse_input(nday)

test = parse_input(
"""
>>><<><>><<<>><>>><<<>>><<<><<<>><>><<>>
""" |> strip
)

@testset "Day$nday tests" begin
    @test solve1(test) == 3068
    @test solve2(test) == 1514285714288
end

@testset "Day$nday solutions" begin
    @test solve1(data) == 3098
    @test solve2(data) == 1525364431487
end

end  # module
