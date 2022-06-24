# frozen_string_literal: true

class Interface
  MAX_CARDS = 3
  MAX_SCORE = 21

  def start_game
    puts 'Приветсвуем вас в игре BlackJack'
    puts 'Введите ваше имя:'
    name = gets.chomp.to_s

    @player = Player.new name
    @dealer = Player.new 'Дилер'
    @deck = Deck.new

    @deck.create_deck

    2.times { @player.cards << @deck.deal_card }
    2.times { @dealer.cards << @deck.deal_card }

    puts 'Раздаются карты.'
    sleep(2)

    puts "Ваш банк - #{@player.bank}"

    @player.place_bet
    @dealer.place_bet

    puts 'Принимаются ставки.'
    sleep(2)

    player_turn
  end

  def player_turn
    game_results if @player.cards.count == MAX_CARDS && @dealer.cards.count == MAX_CARDS
    puts "Ваши карты - #{@player.show_cards_face}. Ваши очки - #{@player.current_score}."
    puts "Карты диллера - #{@dealer.show_cards_shirt}"
    puts 'Ваш ход, что будете делать?'
    puts '1. Взять карту.'
    puts '2. Пропустить.'
    puts '3. Открыть карты.'

    input = gets.chomp.to_i

    case input
    when 1
      @player.cards << @deck.deal_card if @player.cards.count == 2
      puts "Ваши карты - #{@player.show_cards_face}. Ваши очки - #{@player.current_score}."
      puts 'Ход преходит к дилеру.'

      dealer_turn
    when 2
      puts 'Ход переходит к дилеру.'

      dealer_turn
    when 3
      game_results
    else
      raise 'Введено неверное число, введите число от 1 до 3'
    end
  rescue RuntimeError => e
    puts e.message
    retry
  end

  def dealer_turn
    game_results if @player.cards.count == MAX_CARDS && @dealer.cards.count == MAX_CARDS

    if @dealer.cards.count == 2 && @dealer.current_score < 17
      @dealer.cards << @deck.deal_card

      puts 'Дилер берет карту.'
      sleep(2)

      player_turn
    elsif @dealer.cards.count == MAX_CARDS || @dealer.current_score >= 17
      puts 'Дилер пропускает.'
      sleep(2)

      player_turn
    end
  end

  def find_winner
    p1 = MAX_SCORE - @player.current_score
    p2 = MAX_SCORE - @dealer.current_score

    return :draw if (p1 == p2) || (p1.negative? && p2.negative?)
    return @player if p2.negative?
    return @dealer if p1.negative?
    return @player if @player.current_score > @dealer.current_score

    @dealer
  end

  def game_results
    winner = find_winner
    puts 'Игра окончена.'

    puts "Ваши карты - #{@player.show_cards_face}. Ваши очки - #{@player.current_score}."
    puts "Карты дилера - #{@dealer.show_cards_face}. Очки дилера - #{@dealer.current_score}."

    if winner == :draw
      @player.bank += 10
      @dealer.bank += 10
      puts 'Ничья!'
    else
      winner.bank += 20
      puts "#{winner.name} победил!"
    end

    @player.cards = []
    @dealer.cards = []

    puts "#{@player.name}, хотите сыграть ещё раз?"
    puts '1. Да.'
    puts '2. Нет.'

    input = gets.chomp.to_i

    case input
    when 1
      next_round
    else
      puts "До свидания, #{@player.name}"
      exit
    end
  end

  def next_round
    check_bank

    @deck = Deck.new

    @deck.create_deck

    2.times { @player.cards << @deck.deal_card }
    2.times { @dealer.cards << @deck.deal_card }

    puts 'Раздаются карты.'
    sleep(2)

    puts "Ваш банк - #{@player.bank}"

    @player.place_bet
    @dealer.place_bet

    puts 'Принимаются ставки.'
    sleep(2)

    player_turn
  end

  def check_bank
    if @player.bank.zero?
      puts "#{@player.name} У вас закончились деньги!"
      exit
    elsif @dealer.bank.zero?
      puts 'У дилера закончились деньги!'
      exit
    end
  end
end
