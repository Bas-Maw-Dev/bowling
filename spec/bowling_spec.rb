require_relative '../lib/bowling'

RSpec.describe Bowling do # rubocop:disable Metrics/BlockLength
  let(:bowling) { Bowling.new }
  context 'An instance of Bowling' do
    it 'exists' do
      expect(Bowling.new).to be_a(Bowling)
    end
  end

  context 'An instance of Bowling' do
    it 'can roll' do
      allow(bowling).to receive(:roll) { 5 }
      expect(bowling.roll(0)).to eq(5)
    end
  end

  context 'Frames of Bowling' do
    it 'can play a frame without spares or strikes' do
      allow(bowling).to receive(:roll).and_return(5, 4)
      expect(bowling.play_frame).to eq([%w[5 4]])
    end

    it 'can play a frame with a spare' do
      allow(bowling).to receive(:roll).and_return(5, 5)
      expect(bowling.play_frame).to eq([%w[5 /]])
    end

    it 'can play a frame with a strike' do
      allow(bowling).to receive(:roll).and_return(10)
      expect(bowling.play_frame).to eq([%w[X]])
    end

    it 'can play a frame with no pins knocked down' do
      allow(bowling).to receive(:roll).and_return(0)
      expect(bowling.play_frame).to eq([%w[0 0]])
    end
  end

  context 'Full Game of Bowling' do
    it 'can record two frames' do
      allow(bowling).to receive(:roll).and_return(4)
      2.times { bowling.play_frame }
      expect(bowling.scorecard).to eq([%w[4 4], %w[4 4]])
    end

    it 'can record a full game without any strikes or spares' do
      allow(bowling).to receive(:roll).and_return(4)
      10.times { bowling.play_frame }
      expect(bowling.scorecard).to eq([
                                        %w[4 4], %w[4 4],
                                        %w[4 4], %w[4 4],
                                        %w[4 4], %w[4 4],
                                        %w[4 4], %w[4 4],
                                        %w[4 4], %w[4 4]
                                      ])
    end

    it 'can record a full game with spares' do
      allow(bowling).to receive(:roll).and_return(5)
      10.times { bowling.play_frame }
      expect(bowling.scorecard).to eq([
                                        %w[5 /], %w[5 /],
                                        %w[5 /], %w[5 /],
                                        %w[5 /], %w[5 /],
                                        %w[5 /], %w[5 /],
                                        %w[5 /], %w[5 /]
                                      ])
    end
  end

  context 'Correct scoring for a full game' do
    it 'can record the correct score for a game with no strikes or spares' do
      allow(bowling).to receive(:roll).and_return(4)
      10.times { bowling.play_frame }
      expect(bowling.game_score).to eq(80)
    end

    it 'can record the correct score for a game with spares' do
      allow(bowling).to receive(:roll).and_return(5)
      10.times { bowling.play_frame }
      expect(bowling.game_score).to eq(150)
    end
  end
end