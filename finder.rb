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
    graph.add_vertex(id, data, neighbors)
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

def permutations(paths)
  permutations = paths.map(&:downcase).map(&:all_permutations)
  permutations = permutations.flatten.sort_by(&:length).reverse
  permutations
end

def wordlist(filename)
  wordlist = []
  File.foreach(filename) { |x| wordlist << x.delete!("\r\n") }
  wordlist
end

def real_words(permutations, wordlist)
  realwords = []
  permutations.each { |x| realwords << x if wordlist.include?(x) }
  realwords
end

def longest_words(realwords)
  longest_words = []
  longest = realwords[0].length
  realwords.each { |word| longest_words << word if word.length == longest }
  longest_words
end

def find_words(filename)
  puts 'Longest valid word(s):'
  graph = read_file(filename)
  edges = graph.edges
  ends = graph.ends
  # print edges
  paths = graph.paths
  # puts paths
  vertices = graph.vertices
  permutations = permutations(paths)
  wordlist = wordlist('wordlist.txt')
  realwords = real_words(permutations, wordlist)
  puts longest_words(realwords)
end
