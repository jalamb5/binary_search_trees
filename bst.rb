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

  def insert(value)
    current_node = root
    until current_node.nil?
      parent_node = current_node
      current_node = value > current_node.data ? current_node.right : current_node.left
    end
    current_node = Node.new(value)
    parent_node.data < current_node.data ? parent_node.right = current_node : parent_node.left = current_node
  end

  def delete(value)
    current_node = root
    until current_node.data == value
      parent_node = current_node
      current_node = value > current_node.data ? current_node.right : current_node.left
    end
    parent_node.data < current_node.data ? parent_node.right = nil : parent_node.left = nil
    current_node = nil
  end

  def find(value)
    current_node = root
    until current_node.data == value
      current_node = value > current_node.data ? current_node.right : current_node.left
    end
    current_node
  end

  def level_order(node = root, queue = [])
    print "#{node.data} "
    queue << node.left unless node.left.nil?
    queue << node.right unless node.right.nil?
    return nil if queue.empty?

    level_order(queue.shift, queue)
  end

  def preorder(node = root)
    # Root Left Right
    return if node.nil?

    print "#{node.data} "
    preorder(node.left)
    preorder(node.right)
  end

  def inorder(node = root)
    # Left Root Right
    return if node.nil?

    inorder(node.left)
    print "#{node.data} "
    inorder(node.right)
  end

  def postorder(node = root)
    # Left Right Root
    return if node.nil?

    postorder(node.left)
    postorder(node.right)
    print "#{node.data} "
  end

  def height(node = root)
    left_node, right_node = node, node
    left_height = 0
    right_height = 0
    until left_node.nil?
      left_node = left_node.left
      left_height += 1
    end
    until right_node.nil?
      right_node = right_node.right
      right_height += 1
    end
    left_height > right_height ? left_height : right_height
  end

  def depth(node = root)
    current_node = root
    value = node.data
    depth_count = 0
    until current_node.data == value
      current_node = value > current_node.data ? current_node.right : current_node.left
      depth_count += 1
    end
    depth_count
  end

  def balanced?
    # diff between height of left subtree and right subtree is no more than 1
    left_node, right_node = root, root
    left_height = 0
    right_height = 0
    until left_node.nil?
      left_node = left_node.left
      left_height += 1
    end
    until right_node.nil?
      right_node = right_node.right
      right_height += 1
    end
    larger = left_height > right_height ? left_height : right_height
    smaller = left_height < right_height ? left_height : right_height
    return true if (larger - smaller) <= 1
    return false if (larger - smaller) > 1
  end
end

my_tree = Tree.new([5, 6, 8, 9, 10, 11, 12, 13, 14, 15])
my_tree.insert(7)

item = my_tree.find(14)

p my_tree.depth(item)
p my_tree.balanced?
