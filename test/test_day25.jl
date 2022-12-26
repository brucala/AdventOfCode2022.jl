module test_day25

using Test
using AdventOfCode2022.Day25

nday = 25

data = parse_input(nday)

test = parse_input(
"""
1=-0-2
12111
2=0=
21
2=01
111
20012
112
1=-1=
1-12
12
1=
122
""" |> rstrip
)

@testset "Day$nday tests" begin
    @test solve1(test) == "2=-1=0"
end

@testset "Day$nday solutions" begin
    @test solve1(data) == "2=2-1-010==-0-1-=--2"
end

end  # module
