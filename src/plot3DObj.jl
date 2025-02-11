using PlotlyJS
using LinearAlgebra

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

"""
Plot a vector in 3D space

function plotVector(x::Array{Float65,3}, v::Array{Float64,3}, name::String = nothing, colorline::String="blue", colorcone::String="Blues")
"""

function quiver3(x::Array{Float64}, v::Array{Float64}; name::String = "noname", colorline::String = "blue", colorcone::String = "Blues")
        vnorm= sqrt(dot(v,v))
    
        if name == "noname"
            # draw line
            trace1 = scatter3d(
                x=[x[1], x[1] + v[1]/vnorm],
                y=[x[2], x[2] + v[2]/vnorm],
                z=[x[3], x[3] + v[3]/vnorm],
                mode="lines",
                hoverinfo="x+y+z",
                line=attr(color=colorline, width=3),aspect_ratio=1
            )
            # draw cone
            trace2 = cone(
                x=[x[1]+v[1]/vnorm], opacity=0.9, y=[x[2]+v[2]/vnorm], z=[x[3]+v[3]/vnorm],
                u=[v[1]/vnorm], v=[v[2]/vnorm], w=[v[3]/vnorm],
                hoverinfo="x+y+z+u+v+w",
                showscale=false,
                sizemode="absolute",
                sizeref=0.5,
                colorscale=colorcone
                # showscale="false"
            )
        else 
            # draw line
            trace1 = scatter3d(
                x=[x[1], x[1] + v[1]/vnorm],
                y=[x[2], x[2] + v[2]/vnorm],
                z=[x[3], x[3] + v[3]/vnorm],
                mode="lines",
                name=name,
                hoverinfo="name",
                line=attr(color=colorline, width=3),aspect_ratio=1
            )
            # draw cone
            trace2 = cone(
                x=[x[1]+v[1]/vnorm], opacity=0.9, y=[x[2]+v[2]/vnorm], z=[x[3]+v[3]/vnorm],
                u=[v[1]/vnorm], v=[v[2]/vnorm], w=[v[3]/vnorm],
                name=name,
                hoverinfo="name",
                showscale=false,
                sizemode="absolute",
                sizeref=0.5,
                colorscale=colorcone
                # showscale="false"
            )
        end
    
        return trace1, trace2
    
end
    