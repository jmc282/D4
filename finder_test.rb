require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require_relative 'finder.rb'

# Test Suite for finder
class FinderTest < Minitest::Test

	def test_permutations
		paths = ['abc']
		assert_equal(permutations(paths),'abc'.permutations.to_a)
	end

	# def test_real_words

	# 	permutations = 'apple'.permutations.to_a
	# 	real_words = real_words(permutations, wordlist)
	# end

end