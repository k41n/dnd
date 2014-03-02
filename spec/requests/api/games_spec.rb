require 'spec_helper'

describe "Api::GamesController" do
  context 'GET /api/games' do

    let(:master) {create :master}

    it 'receives list of current games' do
      create_list(:game, 5, master: master)
      do_get '/api/games'
      expect(json_body.size).to eq(5)
    end

    it 'uses pagination' do
      create_list(:game, 15, master: master)
      do_get '/api/games'
      expect(json_body.size).to eq(10)
    end

    it 'understands page parameter' do
      create_list(:game, 15, master: master)
      do_get '/api/games', page: 2
      expect(json_body.size).to eq(5)
    end
  end

  context 'POST /api/games' do
    let(:new_game_params) {
      {
        game: {
            name: Faker::Lorem.sentence,
            description: Faker::Lorem.paragraph
        }

      }
    }

    let(:game_params_without_name) {
      { game: new_game_params[:game].delete_if{ |k,_| k == :name } }
    }

    context 'when authorized' do

      before(:each) do
        login_master
      end

      it 'creates game' do
        expect{
          do_post '/api/games', new_game_params
        }.to change{Game.count}.from(0).to(1)
        expect(status).to eq(201)
      end

      it 'assigns user who created game as gamemaster' do
        do_post '/api/games', new_game_params
        expect(Game.last.master.id).to eq(Player.last.id)
      end

      it 'refuses to create game without name and returns error' do
        expect{
          do_post '/api/games', game_params_without_name
        }.not_to change{Game.count}.from(0).to(1)
        expect(status).to eq(422)
      end
    end
  end

  context 'DELETE /api/games/:id' do
    before(:each) do
      login_master
    end

    let!(:game) { create :game, master: @master }
    let(:another_master) { create :master }
    let(:another_game) { create :game, master: another_master }

    it 'deletes game' do
      expect {
        do_delete "/api/games/#{game.to_param}"
      }.to change{Game.count}.from(1).to(0)
    end

    it 'refuses to delete games of another master' do
      another_game
      expect {
        do_delete "/api/games/#{another_game.to_param}"
      }.not_to change{Game.count}.from(2)
    end
  end
end
