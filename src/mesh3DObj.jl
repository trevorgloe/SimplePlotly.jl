using PlotlyJS
using LinearAlgebra
# using Delaunay
using MiniQhull
using Printf

"""
Objects to creating mesh plots in 3D, specially useful for plotting parametric surfaces
"""

struct mesh3DObj
    points::Array{Float64,2} # List of points for vertices of triangles (will be 3xN)
    tri::Array{Int64,2} # List of triangle vertices (will be 3xM with M generally > N)

    # constructor
    function mesh3DObj(points::Array{<:Real,2}, tri::Array{<:Integer,2})
        # convert points to float64s
        points = convert(Array{Float64,2}, points)
        new(points, tri)
    end

end

"""
Create trace from a mesh object

createMeshTrace(mesh::mesh3DObj, colorscale::String = "Viridis")
"""

function createMeshTrace(mesh::mesh3DObj, colorscale::String="Viridis")
    trace = mesh3d(
        # vertices for triangles
        x=mesh.points[1, :],
        y=mesh.points[2, :],
        z=mesh.points[3, :],

        # triangles
        i=mesh.tri[1, :],
        j=mesh.tri[2, :],
        k=mesh.tri[3, :], colorscale=colorscale,
        intensity=LinRange(0, 1, length(mesh.points[1, :]))
    )

    return trace
end

"""
Use the stupidest discretization possible to find the vertices of a surface defined by 
the level set of f(x,y,z) = 0

function simpleParaSurfaceMesh(f::Function, x::Vector, y::Vector, z::Vector)
"""

function simpleParaSurfaceMesh(f::Function, x::AbstractVector, y::AbstractVector, z::AbstractVector; eps::Float64=0.1)
    # create a 3D array of bools for if the point is close to satisfying the level set conditions
    close = zeros(Bool, length(x), length(y), length(z))
    x_vec = zeros(0)
    y_vec = zeros(0)
    z_vec = zeros(0)

    # loop through all the points
    for i in 1:length(x)
        for j in 1:length(y)
            for k in 1:length(z)
                if abs(f(x[i], y[j], z[k])) < eps
                    close[i, j, k] = true
                    append!(x_vec, x[i])
                    append!(y_vec, y[j])
                    append!(z_vec, z[k])
                end
            end
        end
    end

    # # now that we got the points, we do Delaunay triangulation to get the simplices
    # dim          = 3
    # numpoints    = count(close)
    # coordinates  = [x_vec; y_vec; z_vec]
    # # display(size(coordinates))
    # # display(numpoints*dim)
    # connectivity = delaunay(dim, numpoints, coordinates)

    # now that we have the points, lets do something stupid to figure out the connectivity. We're just gonna connect two points that are within 1.1*h of each other
    h = sqrt((x[2] - x[1])^2 + (y[2] - y[1])^2 + (z[2] - z[1])^2)
    numpoints = count(close)
    display(numpoints)
    triangles = zeros(Int, 0, 3)
    for i in 1:length(x_vec)
        # for each point, we look through the vector to find all the points close
        neighbors = zeros(Int, 0)
        for j in 1:length(x_vec)
            # find if the point is within h
            dist = sqrt((x_vec[i] - x_vec[j])^2 + (y_vec[i] - y_vec[j])^2 + (z_vec[i] - z_vec[j])^2)
            if dist < h
                append!(neighbors, j)
            end
        end
        # now we've found all the neighbors, construct all posible triangles with verticie at i and other vertices in neighbors
        for k in 1:length(neighbors)-1
            # add triangles
            triangles = cat(triangles, [i, neighbors[k], neighbors[k+1]]', dims=(1, 1))
        end
        # display(i)
        @printf("point %i \r", i)
    end
    return x_vec, y_vec, z_vec, triangles

end
