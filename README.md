# hyper-gala-opt

[![Build Status](https://travis-ci.com/a626709452/hyper-gala-opt.jl.svg?branch=master)](https://travis-ci.com/a626709452/hyper-gala-opt.jl)
[![Build Status](https://ci.appveyor.com/api/projects/status/github/a626709452/hyper-gala-opt.jl?svg=true)](https://ci.appveyor.com/project/a626709452/hyper-gala-opt-jl)
[![Coverage](https://codecov.io/gh/a626709452/hyper-gala-opt.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/a626709452/hyper-gala-opt.jl)
[![Coverage](https://coveralls.io/repos/github/a626709452/hyper-gala-opt.jl/badge.svg?branch=master)](https://coveralls.io/github/a626709452/hyper-gala-opt.jl?branch=master)

A package to perform hyperparameter optimization for GalacticOpt https://github.com/SciML/GalacticOptim.jl.

And this work was guilded by Mohamed Tarek https://github.com/mohamed82008

# Usage

This package was designed to facilitate the addition of optimization logic to already existing code. I usually write some code and try a few hyper parameters by hand before I realize I have to take a more structured approach to finding good hyper parameters. I therefore designed this package such that the optimization logic is wrapped around existing code, and the user only has to specify which variables to optimize and candidate values (ranges) for these variables.


## Full example
```julia
using Hyperopt

f(x,a,b=true;c=10) = sum(@. x + (a-3)^2 + (b ? 10 : 20) + (c-100)^2) # Function to minimize

# Main macro. The first argument to the for loop is always interpreted as the number of iterations

function Hyperopll(item,optimize)
    hohb = @hyperopt for i=item, sampler=Hyperband(R=50, η=3, inner=RandomSampler()), a = LinRange(1,5,1800), c = exp10.(LinRange(-1,3,1800))
        if !(state === nothing)
            a,c = state
        end
        res = Optim.optimize(x->f(x[1],c=x[2]), [a,c], optimize, Optim.Options(f_calls_limit=i))
        @show Optim.minimum(res), Optim.minimizer(res)
    end
end



Hyperopll(100,SimulatedAnnealing())



(Optim.minimum(res), Optim.minimizer(res)) = (19508.219519722436, [3.1081357602285173, 2.4899603816109868])
(Optim.minimum(res), Optim.minimizer(res)) = (11841.997757878282, [2.745414118954975, 142.91774625848208])
(Optim.minimum(res), Optim.minimizer(res)) = (19724.31938148781, [4.233006635491073, 1.3957451418822049])
(Optim.minimum(res), Optim.minimizer(res)) = (19819.49910666349, [5.037761502294901, 0.9275687452697414])
(Optim.minimum(res), Optim.minimizer(res)) = (12292.896700088888, [1.951639799888827, 52.127276649644116])
(Optim.minimum(res), Optim.minimizer(res)) = (16456.75384730264, [2.3531049263254906, 180.35132465657486])
(Optim.minimum(res), Optim.minimizer(res)) = (19888.622935955143, [3.161200667037243, 0.5585752802179126])
(Optim.minimum(res), Optim.minimizer(res)) = (19914.536661242768, [3.6281267370761534, 0.4302148337913695])
(Optim.minimum(res), Optim.minimizer(res)) = (57743.21665338569, [0.6565353490103842, 318.48964466723646])
(Optim.minimum(res), Optim.minimizer(res)) = (19536.117784305567, [4.013958881508101, 2.3522162479241064])
(Optim.minimum(res), Optim.minimizer(res)) = (18868.732862493576, [3.359088382434686, 5.8267345897617355])
(Optim.minimum(res), Optim.minimizer(res)) = (15988.601518685293, [4.461923290717065, 22.627754982956898])
(Optim.minimum(res), Optim.minimizer(res)) = (19229.823206380177, [2.7231795441912174, 3.928429924272472])
(Optim.minimum(res), Optim.minimizer(res)) = (19827.390417868868, [4.426888977536429, 0.8770742677827643])
(Optim.minimum(res), Optim.minimizer(res)) = (19183.613739282813, [4.351815079959664, 4.178361862925719])
(Optim.minimum(res), Optim.minimizer(res)) = (19456.890980678025, [3.5360727430966463, 2.754930167683395])
(Optim.minimum(res), Optim.minimizer(res)) = (10198.859426833715, [2.4674819344080046, 114.09169440995414])
(Optim.minimum(res), Optim.minimizer(res)) = (19459.41757879685, [3.493620313281034, 2.7417154285396377])
(Optim.minimum(res), Optim.minimizer(res)) = (19949.90879357347, [4.8866036687048355, 0.26861316430670357])
(Optim.minimum(res), Optim.minimizer(res)) = (17534.35246260517, [1.1823235130628127, 13.218386078651392])
(Optim.minimum(res), Optim.minimizer(res)) = (17169.557217103382, [2.2711481525526622, 15.329899066507227])
(Optim.minimum(res), Optim.minimizer(res)) = (18820.265352838913, [4.82657031684269, 6.101496318010792])
(Optim.minimum(res), Optim.minimizer(res)) = (17679.366754762028, [2.9766517482767503, 12.368006928855198])
(Optim.minimum(res), Optim.minimizer(res)) = (10496.808140802108, [3.3257365202890496, 77.71318693663318])
(Optim.minimum(res), Optim.minimizer(res)) = (14276.008579768983, [3.138966092273485, 34.60895116153756])
(Optim.minimum(res), Optim.minimizer(res)) = (230339.09920587606, [3.114508060033352, 569.4029037977718])
(Optim.minimum(res), Optim.minimizer(res)) = (14595.583697031449, [3.5230106790598406, 32.2112829678785])
(Optim.minimum(res), Optim.minimizer(res)) = (10120.442437288153, [1.8350647145389276, 110.91262402306805])
(Optim.minimum(res), Optim.minimizer(res)) = (10430.518621053505, [3.1975185233708463, 79.25199750611088])
(Optim.minimum(res), Optim.minimizer(res)) = (11841.997757878282, [2.745414118954975, 142.91774625848208])
(Optim.minimum(res), Optim.minimizer(res)) = (12060.640269670277, [1.1243133311843017, 54.64449240510362])
(Optim.minimum(res), Optim.minimizer(res)) = (13935.419462426184, [3.8940709610908986, 37.27344980359022])
(Optim.minimum(res), Optim.minimizer(res)) = (14595.583697031449, [3.5230106790598406, 32.2112829678785])
(Optim.minimum(res), Optim.minimizer(res)) = (15988.601518685293, [4.461923290717065, 22.627754982956898])
(Optim.minimum(res), Optim.minimizer(res)) = (16363.345259665362, [1.1817051143744897, 179.74985306177228])
(Optim.minimum(res), Optim.minimizer(res)) = (16997.81962153971, [3.4767007384277977, 16.34838687780318])
(Optim.minimum(res), Optim.minimizer(res)) = (10034.574482879398, [1.896423776540741, 105.77551750048534])
(Optim.minimum(res), Optim.minimizer(res)) = (10270.366875292417, [2.7645597675012294, 83.55884909170477])
(Optim.minimum(res), Optim.minimizer(res)) = (11349.054945440592, [2.6656069414290493, 136.72796110217627])
(Optim.minimum(res), Optim.minimizer(res)) = (10000.084576759915, [2.963523426848681, 100.28852420960126])
(Optim.minimum(res), Optim.minimizer(res)) = (19219.226832657205, [4.4603346133821145, 3.9943009219027417])
(Optim.minimum(res), Optim.minimizer(res)) = (19689.34112122886, [4.01955299530275, 1.5708293597948337])
(Optim.minimum(res), Optim.minimizer(res)) = (77917.46943477707, [3.9022216103238603, 360.6082412951343])
(Optim.minimum(res), Optim.minimizer(res)) = (19507.547385368598, [1.3962015917207913, 2.506537572849537])
(Optim.minimum(res), Optim.minimizer(res)) = (32480.015597606427, [3.2089374843087155, 249.9332249460875])
(Optim.minimum(res), Optim.minimizer(res)) = (27542.19933976198, [4.146192329071706, 232.44200837689965])
(Optim.minimum(res), Optim.minimizer(res)) = (15902.475807681552, [4.718015371802818, 23.19163957703692])
(Optim.minimum(res), Optim.minimizer(res)) = (18466.2635691901, [1.4370176751824733, 8.000974703845857])
(Optim.minimum(res), Optim.minimizer(res)) = (19035.097392542786, [3.5274413405680867, 4.948334058918004])
(Optim.minimum(res), Optim.minimizer(res)) = (19798.870644648356, [1.894293831792954, 1.016930445060731])
(Optim.minimum(res), Optim.minimizer(res)) = (17927.25971824189, [4.679277569444263, 10.980677686882776])
(Optim.minimum(res), Optim.minimizer(res)) = (15559.638641577618, [4.843862341876381, 25.45981745902531])
(Optim.minimum(res), Optim.minimizer(res)) = (14441.124184147877, [3.0747918634343794, 33.358281907464])
(Optim.minimum(res), Optim.minimizer(res)) = (15016.200748972042, [4.551521136427422, 29.191854062295484])
(Optim.minimum(res), Optim.minimizer(res)) = (16802.637099215644, [4.0199416060795, 17.52820592265602])
(Optim.minimum(res), Optim.minimizer(res)) = (17777.965587277533, [-1.746810856430153, 11.935061608090543])
(Optim.minimum(res), Optim.minimizer(res)) = (12099.046958151672, [-1.5770028406549101, 54.41383978499276])
(Optim.minimum(res), Optim.minimizer(res)) = (18033.538007737425, [0.8490470395442843, 10.39580696697654])
(Optim.minimum(res), Optim.minimizer(res)) = (14015.47017423282, [3.4327275525387537, 36.63373988392487])
(Optim.minimum(res), Optim.minimizer(res)) = (18895.19008289618, [6.413917484323758, 5.747492074181881])
(Optim.minimum(res), Optim.minimizer(res)) = (10000.038249927666, [2.8614170270998507, 99.86199750985273])
(Optim.minimum(res), Optim.minimizer(res)) = (19095.65879890885, [-2.558581973401294, 4.790961745463325])
(Optim.minimum(res), Optim.minimizer(res)) = (19157.228160349438, [6.395026551374893, 4.36683653112329])
(Optim.minimum(res), Optim.minimizer(res)) = (10000.003435279907, [3.044592146255232, 99.96196290760204])
(Optim.minimum(res), Optim.minimizer(res)) = (11886.28597062848, [5.757221180851651, 56.65621495544786])
(Optim.minimum(res), Optim.minimizer(res)) = (16542.52379841476, [-7.178885114358116, 19.757155482601064])
(Optim.minimum(res), Optim.minimizer(res)) = (534099.8813630396, [0.39734603782476574, 823.9427515732116])
(Optim.minimum(res), Optim.minimizer(res)) = (16650.13902520201, [0.7154133816772206, 18.483623184139304])
(Optim.minimum(res), Optim.minimizer(res)) = (398773.8292021539, [10.928511597096684, 723.4668939935854])
Hyperoptimizer{Hyperband, var"#363#370"}(10, (:a, :c), (range(1.0, stop=5.0, length=1800), [0.1, 0.10051328280986045, 0.10102920021214988, 0.10154776572977833, 0.10206899295506665, 0.10259289555010268, 0.10311948724709945, 0.10364878184875503, 0.10418079322861445, 0.1047155353314332  …  954.9681399564245, 959.8698272584649, 964.7966740788197, 969.7488095569717, 974.7263634952538, 979.7294663622529, 984.7582492962279, 989.8128441085481, 994.893383287148, 1000.0]), Any[[3.1081357602285173, 2.4899603816109868], [2.745414118954975, 142.91774625848208], [4.233006635491073, 1.3957451418822049], [5.037761502294901, 0.9275687452697414], [1.951639799888827, 52.127276649644116], [2.3531049263254906, 180.35132465657486], [3.161200667037243, 0.5585752802179126], [3.6281267370761534, 0.4302148337913695], [0.6565353490103842, 318.48964466723646], [4.013958881508101, 2.3522162479241064]  …  [6.413917484323758, 5.747492074181881], [2.8614170270998507, 99.86199750985273], [-2.558581973401294, 4.790961745463325], [6.395026551374893, 4.36683653112329], [3.044592146255232, 99.96196290760204], [5.757221180851651, 56.65621495544786], [-7.178885114358116, 19.757155482601064], [0.39734603782476574, 823.9427515732116], [0.7154133816772206, 18.483623184139304], [10.928511597096684, 723.4668939935854]], Any[19508.219519722436, 11841.997757878282, 19724.31938148781, 19819.49910666349, 12292.896700088888, 16456.75384730264, 19888.622935955143, 19914.536661242768, 57743.21665338569, 19536.117784305567  …  18895.19008289618, 10000.038249927666, 19095.65879890885, 19157.228160349438, 10000.003435279907, 11886.28597062848, 16542.52379841476, 534099.8813630396, 16650.13902520201, 398773.8292021539], Hyperband(50, 3, (10000.003435279907, 50, [3.044592146255232, 99.96196290760204]), RandomSampler()), var"#363#370"())
```


## Hyperband
`Hyperband(R=50, η=3, inner=RandomSampler())` Implements [Hyperband: A Novel Bandit-Based Approach to Hyperparameter Optimization](https://arxiv.org/abs/1603.06560). The maximum amount of resources is given by `R` and the parameter `η` roughly determines the proportion of trials discarded between each round of successive halving. When using `Hyperband` the expression inside the `@hyperopt` macro takes the following form
```julia
ho = @hyperopt for i=18, sampler=Hyperband(R=50, η=3, inner=RandomSampler()), a = LinRange(1,5,1800), c = exp10.(LinRange(-1,3,1800))
    if state === nothing # Query if state is initialized
        res = optimize(resources=i, a, b) # if state is uninitialized, start a new optimization using the selected hyper parameters
    else
        res = optimize(resources=i, state=state) # If state has a value, continue the optimization from the state
    end
    minimum(res), get_state(res) # return the minimum value and a state from which to continue the optimization
end
```
a (simple) working example using `Hyperband` and Optim is
```julia
using Optim
f(a;c=10) = sum(@. 100 + (a-3)^2 + (c-100)^2)
hohb = @hyperopt for i=18, sampler=Hyperband(R=50, η=3, inner=RandomSampler()), a = LinRange(1,5,1800), c = exp10.(LinRange(-1,3,1800))
    if !(state === nothing)
        a,c = state
    end
    res = Optim.optimize(x->f(x[1],c=x[2]), [a,c], SimulatedAnnealing(), Optim.Options(f_calls_limit=i))
    Optim.minimum(res), Optim.minimizer(res)
end
plot(hohb)
```
and a more complicated example that also explores different Optim optimizers as the inner optimizer is
```julia
hohb = @hyperopt for i=18, sampler=Hyperband(R=50, η=3, inner=RandomSampler()),
    algorithm = [SimulatedAnnealing(), ParticleSwarm(), NelderMead(), BFGS(), NewtonTrustRegion()],
    a = LinRange(1,5,1800),
    c = exp10.(LinRange(-1,3,1800))
    if !(state === nothing)
        x0,algorithm = state
    else
        x0 = [a,c]
    end
    println(i, " algorithm: ", typeof(algorithm).name.name)
    res = Optim.optimize(x->f(x[1],c=x[2]), x0, algorithm, Optim.Options(time_limit=i+1, show_trace=false))
    Optim.minimum(res), (Optim.minimizer(res), algorithm)
end
```

# Parallel execution
- The macro `@phyperopt` works in the same way as `@hyperopt` but distributes all computation on available workers. The usual caveats apply, code must be loaded on all workers etc.
- The macro `@thyperopt` uses `ThreadPools.tmap` to evaluate the objective on all available threads. Beware of high memory consumption if your objective allocates a lot of memory.
