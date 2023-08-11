using MPSKitModels
using Graphs
using GraphPlot

function C60Graph()
    # I will create a graph representing the topology of C60
    g = SimpleGraph(60, 0)

    # Define the neighbors for each vertex according to the C60 topology
    neighbors = [
        [2, 3, 37],
        [6, 44],
        [11, 4],
        [7, 5],
        [6, 8],
        [16],
        [9, 12],
        [10, 15],
        [10, 13],
        [14],
        [12, 22],
        [17],
        [18, 19],
        [19, 20],
        [16, 21],
        [34],
        [18, 24],
        [26],
        [28],
        [21, 30],
        [32],
        [23, 38],
        [24, 46],
        [25],
        [26,39],
        [27],
        [28, 35],
        [29],
        [30, 36],
        [31],
        [32, 42],
        [33],
        [34, 53],
        [43],
        [36, 40],
        [41],
        [38, 60],
        [45],
        [40, 47],
        [49],
        [42, 50],
        [52],
        [58,44],
        [60],
        [54,46],
        [47],
        [48],
        [55, 49],
        [50],
        [51],
        [56, 52],
        [53],
        [58],
        [59, 55],
        [56],
        [57],
        [59, 58],
        [],
        [60],
        []
    ]

    # add edges to the graph for each pair of neighbors
    @inbounds for i = 1:length(neighbors)
        for nbidx in neighbors[i]
            add_edge!(g, i, nbidx)
        end
    end

    return g
end





function DualC60Graph(g)
    res = SimpleGraph(ne(g))  # creates the graph for dual lattice
    ve_dict = Dict{Tuple{Int,Int},Int}()  # stores the vertex type for each edge
    num_edg = 1
    for edg in collect(edges(g))
        ve_dict[(min(edg.src,edg.dst),max(edg.src,edg.dst))] = num_edg
        num_edg += 1
    end

    for vtx in vertices(g)
        edg_list = Int[]
        for v_nb in neighbors(g,vtx)
            v_tp = (min(vtx,v_nb),max(vtx,v_nb))
            push!(edg_list, ve_dict[v_tp])
        end
        for i = 1:length(edg_list)
            for j = i+1:length(edg_list)
                add_edge!(res, edg_list[i], edg_list[j])
            end
        end
    end
    return res
end

function make_nnham(g,J::Real)
    ham = @mpoham sum(J*S_zz(){min(edg.src,edg.dst),max(edg.src,edg.dst)} for edg in collect(edges(g)))
end

c60g = C60Graph()
gplot(c60g)
dualc60g = DualC60Graph(c60g)
gplot(dualc60g)

make_nnham(dualc60g,1.0)