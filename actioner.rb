class Actioner
  attr_accessor :node_actioner, :zero_position, :actions

  Node = Struct.new(:action, :parent, :cost, :depth, :state)

  ACTION_UP = :up
  ACTION_DOWN = :down
  ACTION_RIGHT = :right
  ACTION_LEFT = :left

  def initialize(node_actioner)
    @zero_position = { row: nil, column: nil }
    @node_actioner = node_actioner.dup
  end

  def validate
  	# Pega o valor do zero
    get_zero_position
    # Pega as ações que podem ser feitas
    possible_actions
  end

  def go_up
    return unless actions.include?(ACTION_UP)
    Node.new(ACTION_UP, @node_actioner, @node_actioner.cost + 1, @node_actioner.depth + 1, state_up)
  end

  def go_down
    return unless actions.include?(ACTION_DOWN)
    Node.new(ACTION_DOWN, @node_actioner, @node_actioner.cost + 1, @node_actioner.depth + 1, state_down)
  end

  def go_right
    return unless actions.include?(ACTION_RIGHT)
    Node.new(ACTION_RIGHT, @node_actioner, @node_actioner.cost + 1, @node_actioner.depth + 1, state_right)
  end

  def go_left
    return unless actions.include?(ACTION_LEFT)
    Node.new(ACTION_LEFT, @node_actioner, @node_actioner.cost + 1, @node_actioner.depth + 1, state_left)
  end

  private

  def state_up
    state = node_actioner.dup.state.dup.map { |s| s.dup }.dup
    for i in (0..state.length - 1) do
      for j in (0..state[i].length - 1) do
        if state.dig(i-1).dig(j) == 0
          state[i-1][j] = state[i][j]
          state[i][j] = 0
          # p state
          return state
        end
      end
    end
  end

  def state_down
    state = node_actioner.dup.state.dup.map { |s| s.dup }.dup
    for i in (0..state.length - 1) do
      for j in (0..state.length - 1) do
        if state.dig(i+1).dig(j) == 0
          state[i+1][j] = state[i][j]
          state[i][j] = 0
          # p state
          return state
        end
      end
    end
  end

  def state_right
    state = node_actioner.dup.state.dup.map { |s| s.dup }.dup
    for i in (0..state.length - 1) do
      for j in (0..state.length - 1) do
        if state.dig(i).dig(j+1) == 0
          state[i][j+1] = state[i][j]
          state[i][j] = 0
          # p state
          return state
        end
      end
    end
  end

  def state_left
    state = node_actioner.dup.state.dup.map { |s| s.dup }.dup
    for i in (0..state.length - 1) do
      for j in (0..state.length - 1) do
        if state.dig(i).dig(j-1) == 0
          state[i][j-1] = state[i][j]
          state[i][j] = 0
          # p state
          return state
        end
      end
    end
  end

  def get_zero_position
    state = node_actioner.dup.state.dup.map { |s| s.dup }.dup
    for i in (0..state.length - 1) do
      for j in (0..state.length - 1) do
        if state[i][j] == 0
          @zero_position[:row] = i
          @zero_position[:column] = j
          return true
        end
      end
    end
    raise 'Zero not found'
  end

  def possible_actions
    @actions = []
    @actions << ACTION_UP if can_go_up?
    @actions << ACTION_DOWN if can_go_down?
    @actions << ACTION_RIGHT if can_go_right?
    @actions << ACTION_LEFT if can_go_left?
    @actions
  end

  def can_go_up?
    zero_position[:row] != 2
  end

  def can_go_left?
    zero_position[:column] != 2
  end

  def can_go_down?
    !zero_position[:row].zero?
  end

  def can_go_right?
    !zero_position[:column].zero?
  end
end