using SimplePlotly
using Test
using PlotlyJS

@testset "SimplePlotly.jl" begin
    # First just do a little fake test to make sure the tests can run correctly
    @test 1 == 1

    # test that the objects are instantiated correctly
    trace1 = scatter3d(x=[0,1], y=[0,1], z=[0,1])
    trace2 = scatter3d(x=[1,3], y=[2,-1], z=[2,-1])
    traces = [trace1, trace2]
    plot3Dtest = plot3DObj(traces)
    @test typeof(plot3Dtest) == plot3DObj # make sure the type is correct
    @test isa(plot3Dtest, plotObj) # make sure it is also a subtype of plotObj
end

# @testset "myLS.jl" begin
#     # Generate example data
#     n_i = 1000
#     X = 2 * randn((n_i, 2))
#     y = X * [1, -2] + randn((n_i, 1))

#     # Estimate the least square regression
#     ls_fit = myLS(y, X)

#     # Check the methods
#     β_hat = coef(ls_fit)
#     y_hat = predict(ls_fit)
#     se_hat = inference(ls_fit, print_df = false)
#     se_hc_hat = inference(ls_fit, heteroskedastic = true, print_df = false)

#     # Let's check that everything is of correct type.
#     @test typeof(ls_fit) == myLS
#     @test typeof(β_hat) == Array{Float64,2}
#     @test typeof(y_hat) == Array{Float64,2}
#     @test typeof(se_hat) == NamedTuple{(:coef, :se, :t, :p),
#                                        Tuple{Array{Float64,2},
#                                              Array{Float64,1},
#                                              Array{Float64,2},
#                                              Array{Float64,2}}}
#     @test typeof(se_hc_hat) == NamedTuple{(:coef, :se, :t, :p),
#                                           Tuple{Array{Float64,2},
#                                                 Array{Float64,1},
#                                                 Array{Float64,2},
#                                                 Array{Float64,2}}}
# end