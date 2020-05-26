using Test, Base.CoreLogging
import Base.CoreLogging: Info

using GPUCompiler

import LLVM

include("util.jl")

@testset "GPUCompiler" begin

GPUCompiler.reset_runtime()

GPUCompiler.enable_timings()

include("native.jl")
include("ptx.jl")
include("spirv.jl")
if !parse(Bool, get(ENV, "CI_ASSERTS", "false")) && VERSION < v"1.4"
  include("gcn.jl")
end

haskey(ENV, "CI") && GPUCompiler.timings()

end
