require_relative 'snake'
class Food
  attr_accessor :food_coord, :x, :y

  HEIGHT = 20
  WIDTH = 20
  def initialize(game, snake)
    @x = 40
    @y = 40
    @game = game
    @snake = snake
    @size = 20
  end

  def renew
    @x = rand(12) * 20
    @y = rand(10) * 20
  end

  def disappear
    @size = 0
  end

  def draw
    Gosu.draw_rect(@x, @y, @size, @size, Gosu::Color::RED, 0, :default)
  end
end
