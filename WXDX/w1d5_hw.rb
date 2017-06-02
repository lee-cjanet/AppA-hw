class Stack
  def initialize
    @stack_storage = []
    # create ivar to store stack here!
  end

  def add(el)
    @stack_storage << el
    # adds an element to the stack
  end

  def remove
    @stack_storage.pop
    # removes one element from the stack
  end

  def show
    @stack_storage.dup
    # return a copy of the stack
  end
end

class Queue
  def initialize
    @queue_array = []
  end

  def enqueue(el)
    @queue_array << el
  end

  def dequeue
    dequeue.shift
  end

  def show
    @queue_array
  end
end



class Map
  def initialize
    @map = []
  end

  def assign(key, v)
    pair_idx = @map.index {|pair| pair[0] == k}
    pair_idx ? @map[pair_idxx][1] = v : @map << [k, v]
    [k, v]
  end

  def lookup(k)
    @map.each {|pair| return pair[1] if pair[0] == k}
    nil
  end

  def remove(k)
    @map.delete! {|pair| pair[0] ==k }
    nil
  end

  def show
    deep_dup(@map)
  end

  private
  def deep_dup(arr)
    arr.map { |el| el.is_a?(Array) ? deep_dup(el) : el }
  end
end
