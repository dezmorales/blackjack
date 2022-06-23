require_relative 'deck'

class Player
  attr_reader :name, :bank, :cards

  def initialize(name)
    @name = name
    @bank = 100
    @cards = []
  end

  def add_card(card)
    @cards << card
  end

  def current_score
    sum = 0
    @cards.each { |card| sum += card.score unless card.value == 'A' }
    @cards.count { |card| card.value == 'A' }.times do

      sum += sum <= 10 ? 11 : 1
    end
    sum
  end

  def place_bet
    @bank -= 10
  end

  def add_bank
    @bank += 10
  end

  def show_card
    @cards.map(&:show).join('')
  end

  def hide_card
    @cards.map { "*" }.join(' ')
  end
end
