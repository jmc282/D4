# Needs documentation
class Vertex
  attr_accessor :id, :neighbors, :data

  def initialize(id, data, neighbors)
    @id = id
    @data = data
    @neighbors = neighbors
  end
end

# Needs documentation
class Graph
  attr_accessor :vertices

  def initialize
    @vertices = []
  end

  def add_vertex(id, data, neighbors)
    @vertices << Vertex.new(id, data, neighbors)
  end

  def find_vertex_by_id(id)
    vertices.each do |v|
      return v if v.id == id
    end
    nil
  end

  def find_vertex_by_data(data)
    vertices.each do |v|
      return v if v.data == data
    end
    nil
  end

  def count
    vertices.length
  end

  def add_edge(from, to)
    vertices[from - 1].neighbors[to - 1] = true
  end

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

  def vertex_edges(vertex_id)
    vertex_edges = []
    all_edges = edges
    all_edges.each { |e| vertex_edges << [vertex_id, e[1]] if e[0] == vertex_id }
    vertex_edges
  end

  # returns a list of vertices that are terminating (dead ends)
  def ends
    ends = []
    vertices.each { |x| ends << x if x.neighbors.empty? }
    ends
  end

  def path?(from_id, to_id)
    from = find_vertex_by_id(from_id)
    to = find_vertex_by_id(to_id)
    visted = []
    letters = ''
    return dfs_search(from, to, visted, letters)
  end

  def dfs_search(source, destination, visted, letters)
    return false if visted.include? source.id

    visted << source.id
    if source == destination
      return true
    end

    source.neighbors.each do |id|
      neighbor = find_vertex_by_id(id)
      if dfs_search(neighbor, destination, visted, letters)
        letters << neighbor.data
        return true, letters
      end
    end
    false
  end

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
