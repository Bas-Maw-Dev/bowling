# frozen_string_literal: true
class Bowling # rubocop:disable Style/Documentation
  attr_accessor :scorecard, :game_score

  def initialize
    @scorecard = []
    @game_score = 0
  end

  def roll(pins)
    pins_down = rand(0..pins)
    pins_down = 'X' if pins_down == 10
    pins_down
  end

  def display_frame(score)
    @game_score += score.sum
    return @scorecard << ['X'] if score[0] == 10

    score = [score[0], '/'] if score[0] + score[1] == 10
    @scorecard << score.map(&:to_s)
  end

  def play_frame
    roll_one = roll(10)
    return display_frame([10]) if roll_one == 10

    roll_two = roll(10 - roll_one)
    display_frame([roll_one, roll_two])
  end
end