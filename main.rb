# frozen_string_literal: true

class Node
  include Comparable
  attr_accessor :data, :left, :right

  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end
end

class Tree < Node
  attr_accessor :root

  def initialize(array)
    @root = build_tree(array)
  end

  def build_tree(array)
    array.uniq!
    array.sort!
    return nil if array.empty?    
      mid = array.length / 2
      root = Node.new(array[mid])
      root.left = build_tree(array[0...mid])
      root.right = build_tree(array[mid + 1..-1])
      root
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  def insert(value, current_node = @root)
    if value < current_node.data
      if current_node.left.nil?
         current_node.left = Node.new(value)
      else
        insert(value, current_node.left)
      end
    elsif value > current_node.data
      if current_node.right.nil?
        current_node.right = Node.new(value)
      else
        insert(value, current_node.right)
      end
    end
  end

  def search(value, current_node = @root)
    if current_node.nil?
      return current_node
    elsif value < current_node.data
      search(value, current_node.left)
    elsif value > current_node.data
      search(value, current_node.right)
    else
      puts "Value is #{current_node.data}"
      return current_node
    end
  end

  # delete leaf from tree
  def delete(value, current_node = @root)
    if current_node.nil?
      return current_node
    elsif value < current_node.data
      current_node.left = delete(value, current_node.left)
    elsif value > current_node.data
      current_node.right = delete(value, current_node.right)
    else
      # delete leaf
      if current_node.left.nil? && current_node.right.nil?
        current_node = nil
      elsif
      # delete node with one child
        if current_node.left.nil?
          temp = current_node
          current_node = current_node.right
          temp = nil
        elsif current_node.right.nil?
          temp = current_node
          current_node = current_node.left
          temp = nil
        else
          temp = find_min(current_node.right)
          current_node.data = temp.data
          current_node.right = delete(temp.data, current_node.right)
        end
      else
        # delete node with two children
        if !current_node.left.nil? && !current_node.right.nil?
          temp = find_min(current_node.right)
          current_node.data = temp.data
          current_node.right = delete(temp.data, current_node.right)
        end        
      end
    end
    return current_node
  end

  def find_min(current_node)
    current_node = current_node.left until current_node.left.nil?
    current_node
  end

  def find(value)
    current_node = @root
    until current_node.nil?
      if value < current_node.data
        current_node = current_node.left
      elsif value > current_node.data
        current_node = current_node.right
      else
        return current_node
      end
    end
    nil
  end

  def level_order(current_node = @root)
    queue = []
    result = []
    queue.push(current_node)
    until queue.empty?
      current_node = queue.shift
      result.push(current_node.data)
      queue.push(current_node.left) unless current_node.left.nil?
      queue.push(current_node.right) unless current_node.right.nil?
    end
    result
  end  

  def inorder(current_node = @root, result = [])
    return if current_node.nil?
      inorder(current_node.left, result)
      result.push(current_node.data)
      inorder(current_node.right, result)
      result
  end

  def preorder(current_node = @root, result = [])
    return if current_node.nil?
      result.push(current_node.data)
      preorder(current_node.left, result)
      preorder(current_node.right, result)
      result
  end

  def postorder(current_node = @root, result = [])
    return if current_node.nil?
      postorder(current_node.left, result)
      postorder(current_node.right, result)
      result.push(current_node.data)
      result
  end

  def height(value)
    return 0 if value == nil
    current_node = find(value)
    return -1 if current_node.nil?
      left_height = height(current_node.left.nil? ? 0 : current_node.left.data)
      right_height = height(current_node.right.nil? ? 0: current_node.right.data)
      left_height > right_height ? left_height + 1 : right_height + 1
  end

  def depth(value)
    current_node = @root
    root = @root
    return -1 if current_node.nil?
    current_depth = 0
    until current_node.data == value do
      if current_node.data > value
        root = root.left
        current_node = root
      else
        root = root.right
        current_node = root
      end
      current_depth += 1
    end
    current_depth
  end
end
