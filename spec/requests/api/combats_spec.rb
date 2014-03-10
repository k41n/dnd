require 'spec_helper'

describe "Api::CombatsController" do

  let(:game) { create :game }

  context 'GET /api/games/:game_id/combats' do

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

  context 'PUT /api/games/:game_id/combats/:combat_id' do
    let!(:combat) { create :combat, game: game }

    it 'updates combat' do
      expect {
        do_put "/api/games/#{game.to_param}/combats/#{combat.to_param}", combat: { description: 'updated_description' }
      }.to change{Combat.last.description}.to('updated_description')
    end

    
  end
end