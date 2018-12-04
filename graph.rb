# Needs documentation
class Vertex
  attr_accessor :id, :neighbors, :data

  def initialize(id, data)
    @id = id
    @data = data
    @neighbors = []
  end
end

# Needs documentation
class Graph
  attr_accessor :vertices

  def initialize
    @vertices = []
  end

  def add_vertex(id, data)
    @vertices << Vertex.new(id, data)
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

    vertices.each { |x|
      puts "#{x.id}, #{x.neighbors}"
      # if x.neighbors
      # 	neighbors = x.neighbors
      # 	neighbors.each { |id|
      		
      # 		n = find_vertex_by_id(id)
      # 		edges << [x.id, n.id]
      		
      # 	}

        x.neighbors.each_with_index { |vertex, index|
          if vertex
            n = find_vertex_by_id(index + 1)
              puts "n.id: #{n.id}"
              edges << [x.id, n.id]
          end
        }
      # end
    }
    edges

  end

  def vertex_edges(vertex_id)
    toReturn = []
    edges = edges()

    start = find_vertex_by_id(vertex_id)


    edges.each { |e|
      if e[0] == vertex_id
        toReturn << [vertex_id, e[1]]
      end
    }
    toReturn


  end

  # returns a list of vertices that are terminating (dead ends)
  def ends
  	ends = []
  	vertices.each { |x|
  		if x.neighbors.empty?
  			ends << x
  		end
  	}
  	ends
  end

  def has_path(from_id, to_id, letters)
  	from = find_vertex_by_id(from_id)
    to = find_vertex_by_id(to_id)
    visted = []
    return dfs_search(from, to, visted, letters)
  end

  def dfs_search(source, destination, visted, letters)
  	if visted.include? source.id
  		return false
  	end

  	visted << source.id
  	if source == destination
  		return true
  	end

  	source.neighbors.each_with_index { |item, index|
      if item
      	neighbor = find_vertex_by_id(index + 1)
      	if dfs_search(neighbor, destination, visted, letters)
      		letters << neighbor.data
      		return true, letters
      	end
      end
  	}

  	return false
  end
















end
