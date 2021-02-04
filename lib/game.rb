require 'gosu'
require_relative 'snake'
require_relative 'food'

class Game < Gosu::Window
  HEIGHT = 20
  WIDTH = 20
  START_SPEED = 0.1
  def initialize
    super WIDTH * Snake::SIZE, HEIGHT * Snake::SIZE
    @snake = Snake.new(self)
    @food = Food.new(self, @snake)
    self.caption = "Snake Game"
    @font = Gosu::Font.new(self, Gosu.default_font_name, 20)
    @dead_object = { over: "", continue: "" }
    @points = 0
    reset
  end

  def update
    @snake.move
    check_food
    check_dead
  end

  def draw
    @snake.draw
    @food.draw
    @font.draw_text(@game_over, 90, 150, 1, 2.0, 2.0, Gosu::Color::RED)
    @font.draw_text("Points = #{@points}", 0, 0, 1, 1.0, 1.0, Gosu::Color::GREEN)
    @font.draw_text(@dead_object[:over], 90, 150, 1, 2.0, 2.0, Gosu::Color::RED)
    @font.draw_text(@dead_object[:continue], 110, 200, 1, 0.8, 0.8, Gosu::Color::GREEN)
  end

  def button_down(id)
    case id
    when Gosu::KbRight then @snake.change_direction(:right)
    when Gosu::KbLeft then @snake.change_direction(:left)
    when Gosu::KbUp then @snake.change_direction(:up)
    when Gosu::KbDown then @snake.change_direction(:down)
    when Gosu::KbReturn then reset
    else
      super
    end
  end

  def check_food
    if @snake.eat?(@food)
      @food.renew
      @points += 1
    end
  end

  def check_dead
    if @snake.dead?
      @snake.change_direction(:stop)
      @dead_object[:over] = "GAME OVER"
      @dead_object[:continue] = "(press [enter] to play again)"
      @food.disappear
    end
  end

  def reset
    @snake = Snake.new(self)
    @food = Food.new(self, @snake)
    @points = 0
    @dead_object = { over: "", continue: "" }
  end
end

Game.new.show
