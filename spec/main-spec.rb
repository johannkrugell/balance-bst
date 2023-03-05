# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/pride'

require_relative '../main'

class NodeTest < Minitest::Test
  def setup
    @node = Node.new(1)
  end

  def test_initialize_node
    assert_equal 1, @node.data
    assert_nil @node.left
    assert_nil @node.right
  end
end

class TreeTest < Minitest::Test
  def setup
    @tree = Tree.new([1, 2, 3, 4, 5, 6, 7])
  end

  def test_initialize_tree
    assert_equal 4, @tree.root.data
  end
end
