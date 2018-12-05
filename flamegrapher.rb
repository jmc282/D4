require 'flamegraph'
require_relative 'graph.rb'
require_relative 'finder.rb'

Flamegraph.generate('flamegrapher.html') do
  find_words('small_graph.txt')
end
