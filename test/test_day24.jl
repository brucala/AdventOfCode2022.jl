module test_day24

using Test
using AdventOfCode2022.Day24

nday = 24

data = parse_input(nday)

test = parse_input(
"""
#.######
#>>.<^<#
#.<..<<#
#>v.><>#
#<^v^^>#
######.#
""" |> rstrip
)

@testset "Day$nday tests" begin
    @test solve1(test) == 18
    @test solve2(test) == 54
end

@testset "Day$nday solutions" begin
    @test solve1(data) == 269
    @test solve2(data) == 825
end

end  # module
