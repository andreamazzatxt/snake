require 'gosu'

class Snake
  attr_accessor :current_dir, :x, :y

  SIZE = 20
  DIRECTIONS = {
    down: { x: 0, y: +20, opposite: :up },
    up: { x: 0, y: -20, opposite: :down },
    right: { x: +20, y: 0, opposite: :left },
    left: { x: -20, y: 0, opposite: :right }
  }
  def initialize(game)
    @x = @y = 0.0
    @current_dir = :down
    @game = game
    @size = SIZE
    @speed = 0.6
    @eat_sound = Gosu::Sample.new('lib/eat.wav')
    @body = [{ x: @x, y: @y }]
  end

  def change_direction(sym)
    @current_dir = sym unless DIRECTIONS[@current_dir][:opposite] == sym
  end

  def eat?(food)
    if @x == food.x && @y == food.y
      @speed = (@speed - 0.2).negative? ? 0.1 : @speed - 0.1
      @eat_sound.play
      @body << { x: @x, y: @y }
      return true
    end
  end

  def dead?
    cond_a = @x > 400 || @y > 400
    cond_b = @x.negative? || @y.negative?
    @size = 0 if cond_a || cond_b
  end

  def move
    sleep(@speed)
    @x += DIRECTIONS[@current_dir][:x]
    @y += DIRECTIONS[@current_dir][:y]
    @body.pop
    @body.unshift({ x: @x, y: @y })
  end

  def draw
    @body.each do |e|
      Gosu.draw_rect(e[:x], e[:y], @size, @size, Gosu::Color::GREEN, 0, :default)
    end
  end
end
