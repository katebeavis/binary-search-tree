require 'pry'
require 'pry-nav'

class Node

  attr_accessor :value, :left_child, :right_child

  def initialize value=nil
    @value = value
    @left_child = nil
    @right_child = nil
  end

  def add new_value
    if new_value <= self.value
      add_left_child new_value
    else 
      add_right_child new_value
    end
  end

  def add_left_child new_value
    if self.left_child.nil?
      self.left_child = Node.new(new_value)
    else
      self.left_child.add(new_value)
    end
  end

  def add_right_child new_value
    if self.right_child.nil?
      self.right_child = Node.new(new_value)
    else
      self.right_child.add(new_value)
    end
  end

  def min tree
    if tree.left_child.nil?
      min_node = tree
      return min_node
    else
      min(tree.left_child)
    end
  end

  def count
    self.values.count
  end

  def values
    result = []

    result << self.value
    result << self.left_child.values unless self.left_child.nil?
    result << self.right_child.values unless self.right_child.nil?

    result.flatten.compact.sort
  end

  def search search_value
    return "Value not present" if !value_present? search_value
    if search_value == value
      return self
    elsif search_value < value
      left_child.search search_value
    elsif search_value > value
      right_child.search search_value
    end
  end

  def value_present? value
    values.include? value
  end

  def delete node
    if value_present? node
      node = search node
      replace_node node
    end
  end

  def replace_node node
    if only_child? node
      node.value = nil
    elsif has_only_left_child? node
      node.value = node.left_child.value
      node.left_child.value = nil
    elsif has_only_right_child? node
      node.value = node.right_child.value
      node.right_child.value = nil
    elsif has_two_children? node
      delete_two_children_node node
    end
  end

  def delete_two_children_node node
    replacement_node = min node.right_child
    node.value = replacement_node.value
    replacement_node.value = nil
  end

  def only_child? node
    node.left_child.nil? && node.right_child.nil?
  end

  def has_only_left_child? node
    !node.left_child.nil? && node.right_child.nil?
  end

  def has_only_right_child? node
    node.left_child.nil? && !node.right_child.nil?
  end

  def has_two_children? node
    !node.left_child.nil? && !node.right_child.nil?
  end

  def sum
    self.values.inject(:+)
  end

  t = Node.new(5)
  t.add(3)
  t.add(1)
  t.add(4)
  t.add(9)
  t.add(6)

end
