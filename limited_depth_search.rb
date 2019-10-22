class LimitedDepthSearch

	Node = Struct.new(:action, :parent, :cost, :depth, :state)

  OBJECTIVE_STATE = [[1, 2, 3], [4, 5, 6], [7, 8, 0]].freeze
  START_STATE = [[1, 5, 2], [7, 4, 3], [8, 6, 0]].freeze

  attr_accessor :limit, :first_state

  def initialize(limit, first_state)
    @limit = limit
    @first_state = first_state
  end

  def execute
    list = []
    list << Node.new(nil, nil, 0, 0, first_state)

    while !list.empty? do
      @node = list.pop
      return { success: true, node: @node } if @node.state == OBJECTIVE_STATE
      if @node.depth <= limit
        list.push(next_options)
      end
      list = list.flatten.compact
    end
    { success: false, node: nil }
  end

  private

  def next_options
    methods_array = ['go_up', 'go_down', 'go_right', 'go_left']
    actioner = Actioner.new(@node.dup)
    actioner.validate
    p @node.state
    methods_array.map do |method|
      actioner.send(method)
    end
  end
end