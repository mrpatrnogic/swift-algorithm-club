# Articulation Points & Bridges

An articulation point is ..

## Example

Here's how the algorithm finds articulation points and bridges:

![Image goes here](Images/Example.jpeg)


## The code

Simple implementation of breadth-first search using a queue:

```swift
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

```

While there are nodes in the queue, we visit the first one and then enqueue its immediate neighbors if they haven't been visited yet.

Put this code in a playground and test it like so:

```swift
var g = Graph()
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
print("Example #1: \(articulationPoints.count) articulation point(s) found.")
for point in g.nodes {
if(point.articulationPoint) {
print(point.label)
}
}

```

This will output: `Example #1: 1 articulation point(s) found.
sambodromo`

## How can I use this?

Example:

* Articulation points and bridges can be used to design reliable networks as it identifies points whose failure would split the network into 2 or more disconnected components.

*Written by [Marcio Romero](https://github.com/mrpatrnogic)*
