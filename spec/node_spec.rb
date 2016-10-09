require 'spec_helper'

describe 'Node' do
  let(:tree) { Node.new(5) }

  describe 'add' do

    context 'when adding a value smaller than the root' do
      before do
        tree.add(3)
      end

      it 'adds a left child' do
        expect(tree.left_child).to_not eq nil
      end

      it 'sets the value passed in by the add method' do
        expect(tree.left_child.value).to eq 3
      end
    end

    context 'when adding a value larger than the root' do
      before do
        tree.add(6)
      end

      it 'adds a left child' do
        expect(tree.right_child).to_not eq nil
      end

      it 'sets the value passed in by the add method' do
        expect(tree.right_child.value).to eq 6
      end
    end
  end
  
  describe 'min' do
    before do
      tree.add(8)
      tree.add(3)
      tree.add(2)
    end

    it 'returns node with the smallest value' do 
      expect(tree.min(tree).value).to eq 2
    end
  end

  describe 'values' do
    before do
      tree.add(3)
      tree.add(1)
      tree.add(4)
      tree.add(9)
      tree.add(6)
    end

    it 'returns all the values' do
      expect(tree.values).to eq([1, 3, 4, 5, 6, 9])
    end
  end

  describe 'count' do
    before do
      tree.add(3)
      tree.add(1)
      tree.add(4)
      tree.add(9)
      tree.add(6)
    end

    it 'returns the amount of nodes in the tree' do
      expect(tree.count).to eq(6)
    end
  end

  describe 'value present' do
    before do
      tree.add(3)
      tree.add(1)
      tree.add(4)
      tree.add(9)
      tree.add(6)
    end

    it 'returns true if the given node is present in the tree' do
      expect(tree.value_present?(4)).to eq true
    end

    it 'returns false if the given node is NOT present in the tree' do
      expect(tree.value_present?(20)).to eq false
    end
  end

  describe 'search' do
    before do
      tree.add(3)
      tree.add(1)
      tree.add(4)
      tree.add(9)
      tree.add(6)
    end

    it 'returns the object searched for' do
      expect(tree.search(4).value).to eq 4
    end

    it 'does not blow up if given node is NOT present in the tree' do
      expect(tree.search(20)).to eq "Value not present"
    end
  end

  describe 'delete' do
    before do
      tree.add(3)
      tree.add(1)
      tree.add(4)
      tree.add(9)
      tree.add(6)
      tree.add(2)
    end

    it 'does nothing if the given node does not exist in the tree' do
      tree.delete(8)

      expect(tree.values).to eq([1, 2, 3, 4, 5, 6, 9])
    end

    context 'only child' do
      it 'deletes it from the tree' do
        tree.delete(6)

        expect(tree.values).to eq([1, 2, 3, 4, 5, 9])
      end
    end

    context 'a node which has one left child node' do

      it 'deletes it from the tree' do
        tree.delete(9)

        expect(tree.values).to eq([1, 2, 3, 4, 5, 6])
      end

      it 'preserves the deleted nodes left child' do
        tree.delete(9)

        expect(tree.values).to include(6)
      end
    end

    context 'a node which has one right child node' do

      it 'deletes it from the tree' do
        tree.delete(1)

        expect(tree.values).to eq([2, 3, 4, 5, 6, 9])
      end

      it 'preserves the deleted nodes right child' do
        tree.delete(1)

        expect(tree.values).to include(2)
      end
    end

    context 'a node which has two children' do

      it 'deletes it from the tree' do
        tree.delete(3)

        expect(tree.values).to eq([1, 2, 4, 5, 6, 9])
      end

      it 'preserves the deleted nodes children' do
        tree.delete(3)

        expect(tree.values).to include(1, 4)
      end
    end
  end

  describe 'sum' do
    before do
      tree.add(3)
      tree.add(1)
      tree.add(4)
      tree.add(9)
      tree.add(6)
    end

    it 'sums up the all the nodes in the tree' do
      expect(tree.sum).to eq(28)
    end
  end

  describe 'only child' do
    before do
      tree.add(3)
    end

    it 'returns true for a node that has NO children' do
      expect(tree.only_child?(tree.left_child)).to eq true
    end

    it 'returns false for a node that has children' do
      expect(tree.only_child?(tree)).to eq false
    end
  end

  describe 'has only left child' do
    before do
      tree.add(3)
      tree.add(9)
      tree.add(1)
    end

    it 'returns true for a node that only has a left child' do
      expect(tree.has_only_left_child?(tree.left_child)).to eq true
    end

    it 'returns false for a node that does NOT only have a left child' do
      expect(tree.has_only_left_child?(tree)).to eq false
    end
  end

  describe 'has only right child' do
    before do
      tree.add(3)
      tree.add(6)
      tree.add(9)
    end

    it 'returns true for a node that only has a right child' do
      expect(tree.has_only_right_child?(tree.right_child)).to eq true
    end

    it 'returns false for a node that does NOT only have a right child' do
      expect(tree.has_only_right_child?(tree)).to eq false
    end
  end

  describe 'has two children' do
    before do
      tree.add(3)
      tree.add(1)
      tree.add(4)
    end

    it 'returns true for a node that has two children' do
      expect(tree.has_two_children?(tree.left_child)).to eq true
    end

    it 'returns false for a node that does NOT have two children' do
      expect(tree.has_two_children?(tree)).to eq false
    end
  end
end
