module hypergalaopt

export hypergalaop

include("Hyperopt.jl")

using Optim
using Hyperopt
using Base.Threads: threadid, nthreads
using LinearAlgebra, Statistics, Random
using Juno
using MacroTools
using MacroTools: postwalk, prewalk
using RecipesBase
using LatinHypercubeSampling
using Distributed
using ThreadPools
using BayesianOptimization, GaussianProcesses


function hypergalaop(arg_item, arg_optimize, arg_function, arg_label)
    global item = arg_item
    global algorithm = arg_optimize
    global f = arg_function
    global label = arg_label
    if label==1
        hohb = @hyperopt for i=item, sampler=Hyperband(R=50, η=3, inner=RandomSampler()),a = LinRange(1,5,1800), c = exp10.(LinRange(-1,3,1800))
                if !(state === nothing)
                    a,c = state
                end
                res = Optim.optimize(x->f(x[1],c=x[2]), [a,c], algorithm, Optim.Options(f_calls_limit=i))
                @show Optim.minimum(res), Optim.minimizer(res)
        end

    else
        hohb = @hyperopt for i=item, sampler=Hyperband(R=50, η=3, inner=RandomSampler()),
            algorithm = algorithm,
            a = LinRange(1,5,1800),
            c = exp10.(LinRange(-1,3,1800))
            if !(state === nothing)
                x0,algorithm = state
            else
                x0 = [a,c]
            end
            println(i, " algorithm: ", typeof(algorithm).name.name)
            res = Optim.optimize(x->f(x[1],c=x[2]), x0, algorithm, Optim.Options(time_limit=i+1, show_trace=false))
            @show Optim.minimum(res), (Optim.minimizer(res), algorithm)
        end
    end

end

end
