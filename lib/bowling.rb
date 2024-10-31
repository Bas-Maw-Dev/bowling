# frozen_string_literal: true
class Bowling # rubocop:disable Style/Documentation
  attr_accessor :scorecard, :game_score

  def initialize
    @scorecard = []
    @game_score = 0
  end

  def roll(pins)
    rand(0..pins)
  end

  def display_frame(score)
    add_score(score)
    return strike if score[0] == 10
    return spare(score[0]) if score[0] + score[1] == 10

    @scorecard << score.map(&:to_s)
  end

  def play_frame
    roll_one = roll(10)
    return display_frame([10]) if roll_one == 10

    roll_two = roll(10 - roll_one)
    display_frame([roll_one, roll_two])
  end

  def strike
    @scorecard << %w[0 X]
  end

  def spare(roll_one)
    @scorecard << %W[#{roll_one} /]
  end

  def add_score(score)
    @game_score += score.sum
  end
end