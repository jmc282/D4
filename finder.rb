require_relative 'graph.rb'

# Needs documentation
class String
  def all_permutations
    chars.to_a.permutation.map(&:join)
  end
end

# Returns a directed graph for the specified file
def read_file(filename, graph)
  File.foreach(filename) do |x|
    id, data, neighbors = process_line(x)
    graph.add_vertex(id, data, neighbors)
  end
  graph
end

def process_line(line)
  x = line.chomp("\n").split(';')
  id = x[0].to_i
  data = x[1]
  if x[2]
    neighbors = x[2].split(',')
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

def longest_words(realwords, longest)
  longest_words = []
  realwords.each { |word| longest_words << word if word.length == longest }
  longest_words
end

def longest_length(realwords)
  realwords = realwords.sort_by(&:length).reverse
  realwords[0].length
end

def find_words(filename)
  puts 'Longest valid word(s):'
  graph = Graph.new
  graph = read_file(filename, graph)
  paths = graph.paths
  permutations = permutations(paths)
  wordlist = wordlist('wordlist.txt')
  realwords = real_words(permutations, wordlist)
  puts longest_words(realwords, longest_length(realwords))
end
