class Deck
  SUITS = %i[♣️ ♠️ ♥️ ♦].freeze
  CARDS_NUMBER = %w[2 3 4 5 6 7 8 9 10].freeze
  CARDS_PICTURE = %w[J Q K A].freeze

  attr_reader :deck

  def initialize
    @deck = []
  end

  def create_deck
    SUITS.each_with_index do |suit|
      CARDS_NUMBER.each { |value| @deck << Card.new(value, suit) }
      CARDS_PICTURE.each { |value| @deck << Card.new(value, suit) }
    end

    @deck.shuffle!
  end

  def deal_cards
    @deck.pop
  end
end
