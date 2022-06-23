require_relative 'deck'

class Card
  ACE_ELEVEN = 11
  ACE_ONE = 1
  PICTURES_VALUE = 10

  attr_reader :value, :suit

  def initialize(value, suit)
    @value = value
    @suit = suit
  end

  def score
    if Deck::CARDS_NUMBER.include?(@value)
      @value.to_i
    elsif Deck::CARDS_PICTURE.include?(@value)
      PICTURES_VALUE
    end
  end

  def show
    "#{@value}#{@suit}"
  end
end
