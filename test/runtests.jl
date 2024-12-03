using Preprocessing_Pipeline_JuML
using Test

@testset "Preprocessing_Pipeline_JuML.jl" begin

    @testset "timesx" begin
        @test timesx(2, 3) == 6
        @test timesx(3, 4) == 12
        @test timesx(0, 9) == 0
    end

end
