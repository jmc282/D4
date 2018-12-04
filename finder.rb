require_relative 'graph.rb'

# Needs documentation
class String
  def all_permutations
    chars.to_a.permutation.map(&:join)
  end
end

# Returns a directed graph for the specified file
def read_file(filename)
  graph = Graph.new
  File.foreach(filename) do |x|
    id, data, neighbors = process_line(x.chomp("\n").split(';'))
    graph.add_vertex(id, data)
    unless neighbors.empty?
      neighbors.each { |n| graph.add_edge(id, n) }
    end
  end
  graph
end

def process_line(line)
  id = line[0].to_i
  data = line[1]
  if line[2]
    neighbors = line[2].split(',')
    neighbors = neighbors.map(&:to_i)
  else
    neighbors = []
  end
  [id, data, neighbors]
end

def paths(graph)
  paths = []
  graph.vertices.each do |v|
    letters = v.data
    paths << letters(v, letters, graph)
  end
  paths
end

def letters(vertex, letters, graph)
  return letters if vertex.neighbors.empty?

  vertex.neighbors.each_with_index do |item, index|
    if item
      found = graph.find_vertex_by_id(index + 1)
      letters << found.data
      letters(found, letters, graph)
    end
  end
  letters
end

def path_from(start_vertex, end_vertex, graph, letters)
  if start_vertex == end_vertex
    letters << end_vertex.data
    letters
  end

  start_vertex.neighbors.each_with_index do |item, index|
    if item
      n_vertex = graph.find_vertex_by_id(index + 1)
      letters << n_vertex.data
      print n_vertex.data
      path_from(n_vertex, end_vertex, graph, letters)
    end
  end
end

def permutations(paths)
  permutations = paths.map(&:downcase).map(&:all_permutations)
  permutations = permutations.flatten.sort_by(&:length).reverse
  permutations
end

def wordlist
  wordlist = []
  File.foreach('wordlist.txt') { |x| wordlist << x.delete!("\r\n") }
  wordlist
end

def real_words(permutations, wordlist)
  realwords = []
  permutations.each do |x| 
    if wordlist.include?(x)
      realwords << x
    end
  end
  realwords
end

def longest_words(realwords)
	longest_words = []
	longest = realwords[0].length
	realwords.each {|word|
		if word.length == longest
			longest_words << word
		end
	}
	longest_words
end

def under_development(filename)
	
  puts "under"
  graph = read_file(filename)

  # paths = ['cat','cab','cake','cke','ke','at','ab','ake','t','b','e']


  edges = graph.edges
  print edges

  ends = graph.ends
  ends.each { |e|
  	puts e.data
  }

  # edges = [[1, 2], [1, 3], [2, 3], [2, 4], [2, 6], [3, 5]]

  vertices = graph.vertices

  paths = []


  vertices.each { |v|
  	ends.each { |e|

  		x = graph.has_path(v.id, e.id, "")

  		if x.kind_of?(Array)
  			x[1] << v.data
  			paths << x[1]
  		end
  	}
  }

  ends.each { |e|
  	paths << e.data
  }



  permutations =  permutations(paths)
  wordlist = wordlist()
  realwords =  real_words(permutations, wordlist)

  print realwords

  print longest_words(realwords)

end
