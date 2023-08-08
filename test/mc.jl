
@testset "Classical MC" begin
    @test isapprox(direct_pi(100000), π, atol = 0.01)
    @test isapprox(markov_pi(400000, 0.3), π, atol = 0.01)
end
