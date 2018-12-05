# Vertex class
class Vertex
  attr_accessor :id, :neighbors, :data

  def initialize(id, data, neighbors)
    @id = id
    @data = data
    @neighbors = neighbors
  end
end

# Graph class
class Graph
  attr_accessor :vertices

  def initialize
    @vertices = []
  end

  # Creates a new vertex from id, data, and neighbors and adds the vertex to the graph.
  def add_vertex(id, data, neighbors)
    @vertices << Vertex.new(id, data, neighbors) unless find_vertex_by_id(id)
  end

  # Returns the vertex object given an id. Returns nil if nonexistent.
  def find_vertex_by_id(id)
    vertices.each do |v|
      return v if v.id == id
    end
    nil
  end

  # Returns a list of all edges in the graph.
  def edges
    edges = []
    vertices.each do |x|
      if x.neighbors
        neighbors = x.neighbors
        neighbors.each do |id|
          n = find_vertex_by_id(id)
          edges << [x.id, n.id]
        end
      end
    end
    edges
  end

  # Returns a list of edges originating from the given vertex.
  def vertex_edges(vertex_id)
    vertex_edges = []
    all_edges = edges
    all_edges.each { |e| vertex_edges << [vertex_id, e[1]] if e[0] == vertex_id }
    vertex_edges
  end

  # Returns a list of vertices that are terminating (dead ends).
  def ends
    ends = []
    vertices.each { |x| ends << x if x.neighbors.empty? }
    ends
  end

  # Calls dfs_search to return a string representing the path from one vertex to another.
  def path?(from_id, to_id)
    from = find_vertex_by_id(from_id)
    to = find_vertex_by_id(to_id)
    visted = []
    letters = ''
    return dfs_search(from, to, visted, letters)
  end

  # A recursive depth first search that returns whether there is a path between source and destination.
  # If there is a path, returns a string, letters, representing that path
  def dfs_search(source, destination, visted, letters)
    return false if visted.include? source.id

    visted << source.id
    return true if source == destination

    source.neighbors.each do |id|
      neighbor = find_vertex_by_id(id)
      if dfs_search(neighbor, destination, visted, letters)
        letters << neighbor.data
        return true, letters
      end
    end
    false
  end

  # Returns all paths in the graph as an array of strings.
  def paths
    end_verts = ends
    paths = []
    vertices.each do |v|
      end_verts.each do |e|
        x = path?(v.id, e.id)
        if x.is_a?(Array)
          x[1] << v.data
          paths << x[1]
        end
      end
    end
    end_verts.each { |e| paths << e.data }
    paths
  end
end
