class Node
  include Comparable

  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end
end

class Tree
  attr_accessor :root

  def initialize
    @root = root
  end

  def build_tree(array)
    array = array.sort.uniq
    mid = array.length/2
    root = Node.new(mid)

    left_tree = array.slice(0..mid)
    right_tree = array.slice(mid + 1...array.length)

    array.each do |n|
      # call a new Node with each item in array
      Node.new(n)
    end
  end
end

p Tree.new.build_tree([5,6,7,8])