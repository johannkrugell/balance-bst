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
    @tree = Tree.new([1, 8, 3, 4, 10, 6, 7, 11])
  end

  def test_initialize_tree
    assert_equal 7, @tree.root.data
  end

  def test_build_tree
    assert_equal 7, @tree.root.data
    assert_equal 4, @tree.root.left.data
    assert_equal 10, @tree.root.right.data
    assert_equal 3, @tree.root.left.left.data
    assert_equal 6, @tree.root.left.right.data
    assert_equal 8, @tree.root.right.left.data
    assert_equal 11, @tree.root.right.right.data
    assert_equal 1, @tree.root.left.left.left.data
  end

  def test_insert
    @tree.insert(9)
    assert_equal 9, @tree.root.right.left.right.data
    @tree.insert(2)
    assert_equal 2, @tree.root.left.left.left.right.data
  end

  def test_delete
    # delete leaf
    @tree.delete(10)
    assert_nil @tree.root.right.right
    # delete node with one child
    @tree.delete(3)
    assert_equal 1, @tree.root.left.left.data
    # delete node with two children
    @tree.delete(10)
    assert_equal 11, @tree.root.right.data
  end

  def test_find
    assert_equal 7, @tree.find(7).data
    assert_equal 4, @tree.find(4).data
    assert_equal 10, @tree.find(10).data
    assert_equal 3, @tree.find(3).data
    assert_equal 6, @tree.find(6).data
    assert_equal 8, @tree.find(8).data
    assert_equal 11, @tree.find(11).data
    assert_equal 1, @tree.find(1).data
  end

  def test_level_order
    assert_equal [7, 4, 10, 3, 6, 8, 11, 1], @tree.level_order
  end

  def test_inorder
    assert_equal [1, 3, 4, 6, 7, 8, 10, 11], @tree.inorder
  end

  def test_preorder
    assert_equal [7, 4, 3, 1, 6, 10, 8, 11], @tree.preorder
  end

  def test_postorder
    assert_equal [1, 3, 6, 4, 8, 11, 10, 7], @tree.postorder
  end


end
