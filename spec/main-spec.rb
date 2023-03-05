# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/pride'

require_relative '../main'

class NodeTest < Minitest::Test
  def setup
    @node = Node.new(1)
  end

  def test_node
    assert_equal 1, @node.data
    assert_nil @node.left
    assert_nil @node.right
  end
end