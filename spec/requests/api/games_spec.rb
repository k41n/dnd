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

      it 'refuses to create game without name and returns error' do
        expect{
          do_post '/api/games', game_params_without_name
        }.not_to change{Game.count}.from(0).to(1)
        expect(status).to eq(422)
      end

    end
  end
end
