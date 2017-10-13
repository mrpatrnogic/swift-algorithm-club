//: Playground - noun: a place where people can play

import UIKit

var dfsNum = [Int]()
var dfsLowest = [Int]()
var criticalLinks = [(point: Node, neighbor: Node)]()
var dfsCounter = 0
var dfsRoot = 0
var rootChildren = 0

func initialize_search(_ graph: Graph) {
    dfsCounter = 0
    dfsNum = Array(repeating:Int.max, count: graph.nodes.count)
    dfsLowest = Array(repeating:Int.max, count: graph.nodes.count)
    criticalLinks = [(point: Node, neighbor: Node)]()
}

func dfs_articulation_point_visit (point: Node) {
    point.visited = true
    dfsCounter += 1
    dfsNum[point.graphId] = dfsCounter
    dfsLowest[point.graphId] = dfsCounter
    for edge in point.neighbors {
        let neighbor = edge.neighbor
        if(!neighbor.visited) { //not visited
            neighbor.parent = point
            if(point.graphId == dfsRoot) {
                rootChildren += 1
            }
            dfs_articulation_point_visit(point: neighbor)
            if(dfsLowest[neighbor.graphId] >= dfsNum[point.graphId]) {//articulation point
                point.articulationPoint = true
            }
            if(dfsLowest[neighbor.graphId] > dfsNum[point.graphId]) {//bridge
                criticalLinks.append((point,neighbor))
            }
            dfsLowest[point.graphId] = min(dfsLowest[neighbor.graphId],dfsLowest[point.graphId])
        }else if(neighbor != point.parent){
            dfsLowest[point.graphId] = min(dfsNum[neighbor.graphId],dfsLowest[point.graphId])
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
//ARTICULATION POINTS
print("ARTICULATION POINTS")

//Example 1
var g = Graph()
// Nodes
var sugarloaf = g.addNode("sugarloaf")
var maracana = g.addNode("maracana")
var copacabana = g.addNode("copacabana")
var ipanema = g.addNode("ipanema")
var corcovado = g.addNode("corcovado")
var lapa = g.addNode("lapa")

//Edges
g.addEdge(ipanema, neighbor: copacabana, bidirectional: true)
g.addEdge(copacabana, neighbor: sugarloaf, bidirectional: true)
g.addEdge(ipanema, neighbor: sugarloaf, bidirectional: true)
g.addEdge(maracana, neighbor: lapa, bidirectional: true)
g.addEdge(sugarloaf, neighbor: maracana, bidirectional: true)
g.addEdge(corcovado, neighbor: sugarloaf, bidirectional: true)
g.addEdge(lapa, neighbor: corcovado, bidirectional: true)

//Algorithm
dfs_articulation_point(graph: g)

//Print
var articulationPoints = g.nodes.filter({$0.articulationPoint == true})
print("Example #1: \(articulationPoints.count) articulation point(s) found.")
for point in g.nodes {
    if(point.articulationPoint) {
        print(point.label)
    }
}
print()

//Example 2
g = Graph()
// Nodes
var guanabarabay = g.addNode("guanabarabay")
var downtown = g.addNode("downtown")
var botanicgarden = g.addNode("botanicgarden")
var colombo = g.addNode("colombo")
var sambodromo = g.addNode("sambodromo")

//Edges
g.addEdge(guanabarabay, neighbor: sambodromo, bidirectional: true)
g.addEdge(downtown, neighbor: sambodromo, bidirectional: true)
g.addEdge(sambodromo, neighbor: botanicgarden, bidirectional: true)
g.addEdge(colombo, neighbor: sambodromo, bidirectional: true)

//Algorithm
dfs_articulation_point(graph: g)

//Print
articulationPoints = g.nodes.filter({$0.articulationPoint == true})
print("Example #2: \(articulationPoints.count) articulation point(s) found.")
for point in g.nodes {
    if(point.articulationPoint) {
        print(point.label)
    }
}
print()
print()

//ARTICULATION POINTS
print("BRIDGES")

//Example 1
g = Graph()
// Nodes
var v0 = g.addNode("0")
var v1 = g.addNode("1")
var v2 = g.addNode("2")
var v3 = g.addNode("3")
var v4 = g.addNode("4")
var v5 = g.addNode("5")
var v6 = g.addNode("6")
var v7 = g.addNode("7")

//Edges
g.addEdge(v0, neighbor: v1, bidirectional: true)
g.addEdge(v1, neighbor: v2, bidirectional: true)
g.addEdge(v1, neighbor: v3, bidirectional: true)
g.addEdge(v1, neighbor: v0, bidirectional: true)
g.addEdge(v2, neighbor: v1, bidirectional: true)
g.addEdge(v2, neighbor: v3, bidirectional: true)
g.addEdge(v3, neighbor: v1, bidirectional: true)
g.addEdge(v3, neighbor: v2, bidirectional: true)
g.addEdge(v3, neighbor: v4, bidirectional: true)
g.addEdge(v4, neighbor: v3, bidirectional: true)
g.addEdge(v7, neighbor: v6, bidirectional: true)
g.addEdge(v6, neighbor: v7, bidirectional: true)

//Algorithm
dfs_articulation_point(graph: g)

//Print
print("Example #1: \(criticalLinks.count) bridge(s) found.")
criticalLinks = criticalLinks.sorted(by:{$0.point.label < $1.point.label})
for bridge in criticalLinks {
    print("Bridge: \(bridge.point.label) - \(bridge.neighbor.label)")
}
print()

