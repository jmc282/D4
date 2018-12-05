require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require_relative 'graph.rb'

# Test Suite for finder
class GraphTest < Minitest::Test
  def setup
    @g = Graph.new
    @v = Vertex.new(1, 'C', [2, 3])
  end

  def test_add_vertex
    @g.add_vertex(1, 'C', [2, 3])
    vertex = @g.vertices[0]
    assert_equal(@v.id, vertex.id)
    assert_equal(@v.data, vertex.data)
    assert_equal(@v.neighbors, vertex.neighbors)
  end

  def test_find_vertex_by_id_nonexisting
    assert_nil(@g.find_vertex_by_id(0))
  end

  def test_find_vertex_by_id_wrong_type
    assert_nil(@g.find_vertex_by_id('C'))
  end

  def test_find_vertex_by_id
    @g.add_vertex(4, 'T', [])
    vertex = @g.find_vertex_by_id(4)
    assert_equal(4, vertex.id)
  end

  def test_edges
    @g.add_vertex(1, 'C', [2])
    @g.add_vertex(2, 'A', [4, 6])
    @g.add_vertex(4, 'T', [])
    @g.add_vertex(6, 'B', [])
    expected = [[1, 2], [2, 4], [2, 6]]
    assert_equal(expected.sort, @g.edges.sort)
  end

  def test_ends
    @g.add_vertex(2, 'A', [4, 6])
    @g.add_vertex(4, 'T', [])
    @g.add_vertex(6, 'B', [])
    expected = [4, 6]
    ends = []
    end_vertices = @g.ends
    end_vertices.each { |e| ends << e.id }
    assert_equal(expected.sort, ends.sort)
  end

  def test_vertex_edges
    @g.add_vertex(1, 'C', [2])
    @g.add_vertex(2, 'A', [4, 6])
    @g.add_vertex(4, 'T', [])
    @g.add_vertex(6, 'B', [])
    expected = [[2, 6], [2, 4]]
    assert_equal(expected.sort, @g.vertex_edges(2).sort)
  end

  def test_path_true
    @g.add_vertex(1, 'C', [2])
    @g.add_vertex(2, 'A', [4, 6])
    @g.add_vertex(4, 'T', [])
    @g.add_vertex(6, 'B', [])
    actual = @g.path?(1, 2)

    assert_equal(true, actual[0])
  end

  def test_path_false
    @g.add_vertex(1, 'C', [2])
    @g.add_vertex(2, 'A', [4, 6])
    @g.add_vertex(4, 'T', [])
    @g.add_vertex(6, 'B', [])
    actual = @g.path?(6, 1)

    assert_equal(false, actual)
  end

  def test_paths
    @g.add_vertex(1, 'C', [2])
    @g.add_vertex(2, 'A', [4, 6])
    @g.add_vertex(4, 'T', [])
    @g.add_vertex(6, 'B', [])
    expected = %w[TAC BAC TA BA T B]
    assert_equal(expected.sort, @g.paths.sort)
  end
end
