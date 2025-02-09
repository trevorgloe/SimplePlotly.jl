using PlotlyJS

"""
Abstract type definition for plotting objects

    Will always have 
    - list of traces
"""

abstract type plotObj end

# Methods ==================================================

"""
function makePlot(obj::plotObj)
"""
function makePlot(obj::plotObj)
    fig = make_subplots(rows=1, cols=1, specs=fill(Spec(kind="scene"), 1, 1))
    relayout!(
        fig,
        scene_aspectmode="data",
    )
    for i in 1:length(obj.traces)
        add_trace!(fig, obj.traces[i])
    end

    fig
end

