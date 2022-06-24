# frozen_string_literal: true

require_relative 'deck'

class Player
  attr_accessor :bank, :cards
  attr_reader :name

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

  def show_cards_face
    @cards.map(&:show).join('')
  end

  def show_cards_shirt
    @cards.map { '*' }.join(' ')
  end
end
