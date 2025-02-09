using PlotlyJS

"""
3D plotting objects
"""

struct plot3DObj <: plotObj
    traces::Array{PlotlyJS.AbstractTrace} # List of traces

    # constructor 
    function plot3DObj(traces::Array{PlotlyJS.GenericTrace{Dict{Symbol,Any}}})
        new(traces)
    end

end