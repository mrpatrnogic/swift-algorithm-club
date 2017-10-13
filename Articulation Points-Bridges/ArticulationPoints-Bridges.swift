//
//  ArticulationPoints.swift
//  
//
//  Created by Marcio Romero Patrnogic - Avantica on 31/07/17.
//
//

var dfs_num = [Int]()
var dfs_low = [Int]()
var bridges = [(point: Node, neighbor: Node)]()
var dfsCounter = 0
var dfsRoot = 0
var rootChildren = 0

func initialize_search(_ graph: Graph) {
    dfsCounter = 0
    dfs_num = Array(repeating:Int.max, count: graph.nodes.count)
    dfs_low = Array(repeating:Int.max, count: graph.nodes.count)
    bridges = [(point: Node, neighbor: Node)]()
}

func dfs_articulation_point_visit (point: Node) {
    point.visited = true
    dfsCounter += 1
    dfs_num[point.graphId] = dfsCounter
    dfs_low[point.graphId] = dfsCounter
    for edge in point.neighbors {
        let neighbor = edge.neighbor
        if(!neighbor.visited) { //not visited
            neighbor.parent = point
            if(point.graphId == dfsRoot) {
                rootChildren += 1
            }
            dfs_articulation_point_visit(point: neighbor)
            if(dfs_low[neighbor.graphId] >= dfs_num[point.graphId]) {//articulation point
                point.articulationPoint = true
            }
            if(dfs_low[neighbor.graphId] > dfs_num[point.graphId]) {//bridge
                bridges.append((point,neighbor))
            }
            dfs_low[point.graphId] = min(dfs_low[neighbor.graphId],dfs_low[point.graphId])
        }else if(neighbor != point.parent){
            dfs_low[point.graphId] = min(dfs_num[neighbor.graphId],dfs_low[point.graphId])
        }
    }
}

func dfs_articulation_point(graph: Graph)
{
    initialize_search(graph)
    for point in graph.nodes {
        if(!point.visited) { //not visited
            dfsRoot = point.graphId
            rootChildren = 0
            dfs_articulation_point_visit(point: point)
            point.articulationPoint = rootChildren > 1
        }
    }
}
