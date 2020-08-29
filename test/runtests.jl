using GMAT
using Test

@testset "GMAT" begin
	@testset "Run Script" begin
		test_script = joinpath(@__DIR__, "test.script")
		output = run_script(test_script; output=tempname())
		@test length(output) == 2
	end
end
