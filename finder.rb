require 'set'
require_relative 'graph.rb'

# Addition to the string class to get all permutations of a string
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

# Returns the processed data from each line, ready to be turned into a vertex.
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

# Returns an array of strings representing all permutations of paths in the graph.
def permutations(paths)
  permutations = paths.map(&:downcase).map(&:all_permutations)
  permutations = permutations.flatten.sort_by(&:length).reverse
  permutations
end

# Returns an array representation of the wordlist
def wordlist(filename)
  wordlist = []
  File.foreach(filename) { |x| wordlist << x.delete!("\r\n") }
  wordlist
end

# Returns an array of all words that are in both permutations and wordlist
def real_words(permutations, wordlist)
  realwords = []
  wordlist = wordlist.to_set
  permutations.each { |x| realwords << x if wordlist.include?(x) }
  realwords
end

# Returns all words of the longest length in realwords
def longest_words(realwords, longest)
  longest_words = []
  realwords.each { |word| longest_words << word if word.length == longest }
  longest_words
end

# Returns the length of the longest word in an array
def longest_length(realwords)
  realwords = realwords.sort_by(&:length).reverse
  realwords[0].length
end

# Main function to find the longest valid words in the graph
def find_words(filename)
  graph = Graph.new
  graph = read_file(filename, graph)
  paths = graph.paths
  permutations = permutations(paths)
  wordlist = wordlist('wordlist.txt')
  realwords = real_words(permutations, wordlist)
  puts 'All Strings:'
  print paths
  puts "\nAll Real Strings:"
  print realwords
  puts "\nLongest valid word(s):"
  return longest_words(realwords, longest_length(realwords))
end
