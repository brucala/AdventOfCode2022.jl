module test_day9

using Test
using AdventOfCode2022.Day9

nday = 9

data = parse_input(nday)

test = parse_input(
"""
R 4
U 4
L 3
D 1
R 4
D 1
L 5
R 2
""" |> strip
)

test2 = parse_input(
"""
R 5
U 8
L 8
D 3
R 17
D 10
L 25
U 20
""" |> strip
)

@testset "Day$nday tests" begin
    @test solve1(test) == 13
    @test solve2(test) == 1
    @test solve2(test2) == 36
end

@testset "Day$nday solutions" begin
    @test solve1(data) == 6314
    @test solve2(data) == 2504
end

end  # module
