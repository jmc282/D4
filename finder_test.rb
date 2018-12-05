require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require_relative 'finder.rb'

# Test Suite for finder
class FinderTest < Minitest::Test
  # Needs documentation
  class Graph
    attr_accessor :vertices

    def initialize
      @vertices = []
    end

    def add_vertex(id, data, neighbors)
      @vertices << [id, data, neighbors]
    end
  end

  def mock_file(filename, text)
    File.open filename, 'w' do |file|
      file.write(text)
    end
  end

  def test_permutations
    paths = %w[ab cd]
    expected = %w[ab ba cd dc]
    assert_equal(permutations(paths).sort, expected.sort)
  end

  def test_word_list
    permutations = %w[act atc cat cta tac tca]
    wordlist = %w[cat act bat]
    expected = %w[cat act]
    assert_equal(real_words(permutations, wordlist).sort, expected.sort)
  end

  def test_process_line
    line = '0;G;1, 3, 4'
    expected = [0, 'G', [1, 3, 4]]
    assert_equal(expected, process_line(line), expected)
  end

  def test_process_line_no_neighbors
    line = '12;W;'
    expected = [12, 'W', []]
    assert_equal(expected, process_line(line), expected)
  end

  def test_longest_words
    realwords = %w[cake bake lake ake ok a]
    expected = %w[cake bake lake]
    assert_equal(expected.sort, longest_words(realwords, 4).sort)
  end

  def test_longest_length
    realwords = %w[flake bake make great at e]
    assert_equal(5, longest_length(realwords))
  end

  def test_wordlist
    filename = 'testfile.txt'
    mock_file(filename, "sample\r\nwordlist\r\ntext\r\n")
    expected = %w[sample wordlist text]
    assert_equal(wordlist(filename).sort, expected.sort)
  end

  def test_read_file
    filename = 'testfile.txt'
    mock_file(filename, "1;C;2, 3\r\n2;A;3, 4, 6\r\n3;K;5\r\n4;T;\r\n")
    expected_graph = Graph.new
    expected_graph.add_vertex(1, 'C', [2, 3])
    expected_graph.add_vertex(2, 'A', [3, 4, 6])
    expected_graph.add_vertex(3, 'K', [5])
    expected_graph.add_vertex(4, 'T', [])
    assert_equal(expected_graph.vertices, read_file(filename, Graph.new).vertices)
  end

  def test_find_words
    filename = 'testfile.txt'
    mock_file(filename, "1;C;2, 3\r\n2;A;3, 4, 6\r\n3;K;5\r\n4;T;\r\n5;E;\r\n6;B;\r\n")
    assert_output("Longest valid word(s):\ncake\n") { find_words(filename) }
  end
end
