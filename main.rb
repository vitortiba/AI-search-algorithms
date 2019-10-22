# Para iniciar o programa, utilize Ruby ou esse compilador online: https://repl.it/languages/ruby
require 'json'
require_relative 'actioner'
require_relative 'length_search'
require_relative 'depth_search'
require_relative 'limited_depth_search'
require_relative 'dynamic_limited_depth_search'
require_relative 'uniform_cost_search'

decision_variable = ''
while decision_variable != 'parar' do
  puts "\n"
  puts 'Procura por largura -> 1'
  puts 'Procura por profundidade -> 2'
  puts 'Procura por profundidade limitada -> 3'
  puts 'Procura por profundidade dinâmica -> 4'
  puts 'Procura por custo uniforme -> 5'
  puts 'Parar o programa -> Ctrl + C'
  puts "\n"

  puts 'Digite o que deseja ser feito (apenas escreva o comando depois do \'->\' da instrucao desejada): '

  decision_variable = gets.chomp
  case decision_variable
    when '1'
      puts 'Digite o estado inicial: '
      first_state = JSON.parse(gets.chomp)
      search = LengthSearch.new(first_state).execute

      puts "\n"
      puts "Nó final -> Profundidade: #{search[:node].depth}, Estado: #{search[:node].state}, Custo: #{search[:node].cost}, Ação: #{search[:node].action}, Pai: #{search[:node].parent.state}"
      parent = search[:node].parent

      puts "\nPasso a passo: "
      puts search[:node].action.to_s + ' |- Ação final.'
      (0..search[:node].depth.to_i).each do |i|
        break if parent.nil? || parent.action.nil?
        puts parent.action.to_s + ' |- Ação ->' + (search[:node].depth.to_i - i - 1).to_s
        parent = parent.parent
      end
    when '2'
      puts 'Digite o estado inicial: '
      first_state = JSON.parse(gets.chomp)
      search = DepthSearch.new(first_state).execute

      puts "\n"
      puts "Nó final -> Profundidade: #{search[:node].depth}, Estado: #{search[:node].state}, Custo: #{search[:node].cost}, Ação: #{search[:node].action}, Pai: #{search[:node].parent.state}"
      parent = search[:node].parent

      puts "\nPasso a passo: "
      puts search[:node].action.to_s + ' |- Ação final.'
      (0..search[:node].depth.to_i).each do |i|
        break if parent.nil? || parent.action.nil?
        puts parent.action.to_s + ' |- Ação ->' + (search[:node].depth.to_i - i - 1).to_s
        parent = parent.parent
      end
    when '3'
      puts 'Digite o limite: '
      limit = gets.chomp
      puts 'Digite o estado inicial: '
      first_state = JSON.parse(gets.chomp)
      search = LimitedDepthSearch.new(limit.to_i, first_state).execute

      if search[:success]
        puts "\n"
        puts "Nó final -> Profundidade: #{search[:node].depth}, Estado: #{search[:node].state}, Custo: #{search[:node].cost}, Ação: #{search[:node].action}, Pai: #{search[:node].parent.state}"
        parent = search[:node].parent

        puts "\nPasso a passo: "
        puts search[:node].action.to_s + ' |- Ação final.'
        (0..search[:node].depth.to_i).each do |i|
          break if parent.nil? || parent.action.nil?
          puts parent.action.to_s + ' |- Ação ->' + (search[:node].depth.to_i - i - 1).to_s
          parent = parent.parent
        end
      else
        puts 'Não foi encontrado nesse limite estabelecido'
      end
    when '4'
      puts 'Digite o estado inicial: '
      first_state = JSON.parse(gets.chomp)
      search = DynamicLimitedDepthSearch.new(first_state).execute

      puts "\n"
      puts "Nó final -> Profundidade: #{search[:node].depth}, Estado: #{search[:node].state}, Custo: #{search[:node].cost}, Ação: #{search[:node].action}, Pai: #{search[:node].parent.state}"
      parent = search[:node].parent

      puts "\nPasso a passo: "
      puts search[:node].action.to_s + ' |- Ação final.'
      (0..search[:node].depth.to_i).each do |i|
        break if parent.nil? || parent.action.nil?
        puts parent.action.to_s + ' |- Ação ->' + (search[:node].depth.to_i - i - 1).to_s
        parent = parent.parent
      end
    when '5'
      puts 'Digite o estado inicial: '
      first_state = JSON.parse(gets.chomp)
      search = UniformCostSearch.new(first_state).execute

      puts "\n"
      puts "Nó final -> Profundidade: #{search[:node].depth}, Estado: #{search[:node].state}, Custo: #{search[:node].cost}, Ação: #{search[:node].action}, Pai: #{search[:node].parent.state}"
      parent = search[:node].parent

      puts "\nPasso a passo: "
      puts search[:node].action.to_s + ' |- Ação final.'
      (0..search[:node].depth.to_i).each do |i|
        break if parent.nil? || parent.action.nil?
        puts parent.action.to_s + ' |- Ação ->' + (search[:node].depth.to_i - i - 1).to_s
        parent = parent.parent
      end
    else
      puts 'Esse comando nao esta registrado'
  end
end
puts "Programa fechado, voce pode iniciar novamente com os valores zerados."