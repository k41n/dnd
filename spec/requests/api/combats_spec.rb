require 'spec_helper'

describe "Api::CombatsController" do
  context 'GET /api/games/:game_id/combats' do

    let(:game) { create :game }

    it 'receives list of combats belonging to game' do
      create_list :combat, 5, game: game
      do_get "/api/games/#{game.to_param}/combats"
      expect(json_body.size).to eq(5)
    end

    it 'uses pagination' do
      create_list(:combat, 15, game: game)
      do_get "/api/games/#{game.to_param}/combats"
      expect(json_body.size).to eq(10)
    end

    it 'understands page parameter' do
      create_list(:combat, 15, game: game)
      do_get "/api/games/#{game.to_param}/combats", page: 2
      expect(json_body.size).to eq(5)
    end

  end
end