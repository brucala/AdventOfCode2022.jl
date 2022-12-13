module test_day12

using Test
using AdventOfCode2022.Day12

nday = 12

data = parse_input(nday)

test = parse_input(
"""
Sabqponm
abcryxxl
accszExk
acctuvwj
abdefghi
""" |> strip
)

@testset "Day$nday tests" begin
    @test solve1(test) == 31
    @test solve2(test) == 29
end

@testset "Day$nday solutions" begin
    @test solve1(data) == 339
    @test solve2(data) == 332
end

end  # module
