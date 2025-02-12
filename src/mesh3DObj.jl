using PlotlyJS
using LinearAlgebra

"""
Objects to creating mesh plots in 3D, specially useful for plotting parametric surfaces
"""

struct mesh3DObj
    points::Array{Float64, 2} # List of points for vertices of triangles (will be 3xN)
    tri::Array{Int64, 2} # List of triangle vertices (will be 3xM with M generally > N)

    # constructor
    function mesh3DObj(points::Array{<:Real, 2}, tri::Array{Int64, 2})
        # convert points to float64s
        points = convert(Array{Float64, 2}, points)
        new(points, tri)
    end

end

"""
Create trace from a mesh object

createMeshTrace(mesh::mesh3DObj, colorscale::String = "Viridis")
"""

function createMeshTrace(mesh::mesh3DObj, colorscale::String = "Viridis")
    trace = mesh3d(
        # vertices for triangles
        x = mesh.points[1,:],
        y = mesh.points[2,:],
        z = mesh.points[3,:],

        # triangles
        i = mesh.tri[1,:],
        j = mesh.tri[2,:],
        k = mesh.tri[3,:],

        colorscale = colorscale,
        intensity = LinRange(0, 1, length(mesh.points[1,:]))
    )

    return trace
end