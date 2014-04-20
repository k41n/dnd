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

    it 'returns url of the combat background' do
      combat = create :combat, game: game
      do_get "/api/games/#{game.to_param}/combats", page: 1
      expect(json_body[0]['background_url']).to eq(combat.background.url)
    end

  end

  context 'PUT /api/games/:game_id/combats/:combat_id' do
    let!(:combat) { create :combat }
    let(:json) { {a: 1}.to_json }

    it 'updates combat' do
      expect {
        do_put "/api/combats/#{combat.to_param}", combat: { description: 'updated_description' }
      }.to change{Combat.last.description}.to('updated_description')
    end

    it 'resets json if reset is true in params' do
      expect {
        do_put "/api/combats/#{combat.to_param}", { combat: { description: 'updated_description', json: json }, reset: true }
      }.to change{Combat.last.json_orig}.to(json)
    end
  end

  context 'POST /api/combats/:combat_id/reset' do
    let!(:combat) { create :combat }
    let(:json) { {a: 1}.to_json }

    it 'resets combat json to orig' do
      combat.update_attribute( :json_orig, json )
      expect {
        do_post "/api/combats/#{combat.to_param}/reset"
      }.to change{Combat.last.json}.from(nil).to(json)
    end

  end
end