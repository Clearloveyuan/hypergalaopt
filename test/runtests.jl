using hypergalaopt,Optim
using Test

@testset "hyper-gala-opt.jl" begin
        arg_item = 10
        arg_optimize = Optim.SimulatedAnnealing()
        #arg_optimize = [Optim.SimulatedAnnealing(), Optim.BFGS()]
        arg_function = f(a;c=10) = sum(@. 100 + (a-3)^2 + (c-100)^2)
        arg_label=1
        hypergalaop(arg_item,arg_optimize,arg_function,arg_label)
end
