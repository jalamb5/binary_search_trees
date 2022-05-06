# frozen_string_literal: true

# Generate each item in tree and store left and right branches
class Node
  attr_accessor :data, :left, :right

  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end
end

# Generate a bst of nodes based on values from an array (array must be sorted and contain only unique values)
class Tree
  attr_accessor :root, :data

  def initialize(array)
    @data = array.sort.uniq
    @root = build_tree(data)
  end

  def build_tree(array)
    return nil if array.empty?

    mid = (array.length - 1) / 2
    root_node = Node.new(array[mid])

    left_tree = array.slice(0...mid)
    right_tree = array.slice((mid + 1)..-1)
    root_node.left = build_tree(left_tree)
    root_node.right = build_tree(right_tree)

    root_node
  end
end

my_tree = Tree.new([5, 6, 7, 8])
p my_tree
