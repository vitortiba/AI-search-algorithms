class DepthSearch
  OBJECTIVE_STATE = [[1, 2, 3], [4, 5, 6], [7, 8, 0]].freeze

  Node = Struct.new(:action, :parent, :cost, :depth, :state)

  attr_accessor :first_state

  def initialize(first_state)
    @first_state = first_state
  end

  def execute
    list = []
    list.push(Node.new(nil, nil, 0, 0, first_state))

    while !list.empty? do
    	# Tira o ultimo elemento da lista para ser utilizado
      @node = list.pop
      p @node.state
      return { success: true, node: @node } if @node.state == OBJECTIVE_STATE
      list.push(next_options)
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