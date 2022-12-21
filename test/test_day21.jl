module test_day21

using Test
using AdventOfCode2022.Day21

nday = 21

data = parse_input(nday)

test = parse_input(
"""
root: pppw + sjmn
dbpl: 5
cczh: sllz + lgvd
zczc: 2
ptdq: humn - dvpt
dvpt: 3
lfqf: 4
humn: 5
ljgn: 2
sjmn: drzm * dbpl
sllz: 4
pppw: cczh / lfqf
lgvd: ljgn * ptdq
drzm: hmdt - zczc
hmdt: 32
""" |> strip
)

@testset "Day$nday tests" begin
    @test solve1(test) == 152
    @test solve2(test) == 301
end

@testset "Day$nday solutions" begin
    @test solve1(data) == 169525884255464
    @test solve2(data) == 3247317268284
end

end  # module
