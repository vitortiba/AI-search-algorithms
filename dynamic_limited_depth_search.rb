require_relative 'limited_depth_search'

class DynamicLimitedDepthSearch

	Node = Struct.new(:action, :parent, :cost, :depth, :state)

  OBJECTIVE_STATE = [[1, 2, 3], [4, 5, 6], [7, 8, 0]].freeze

	attr_accessor :first_state

  def initialize(first_state)
    @first_state = first_state
  end

  def execute
    limit = 0
    list = []
    list.push(Node.new(nil, nil, 0, 0, first_state))
    done = false

    while done == false do
      search = LimitedDepthSearch.new(limit, first_state).execute
      # Se for sucesso da busca limitada ele retorna
      return search if search[:success]
      limit += 1
    end
  end
end