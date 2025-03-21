module SimplePlotly

# Dependancies 
using PlotlyJS

# Write your package code here.
export plotObj, plot3DObj, mesh3DObj
export makePlot, quiver3, createMeshTrace, simpleParaSurfaceMesh

# Module content ===============================================================
# ORDER MATTERS
include("plotObj.jl") # abstract plotting type def

include("plot3DObj.jl") # 3D plotting object

include("mesh3DObj.jl") # mesh plotting object

end
