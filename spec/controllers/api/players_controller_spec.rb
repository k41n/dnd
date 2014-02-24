require 'spec_helper'

describe Api::PlayersController do
  render_views

  context '#index' do

    let!(:player) { create :player }
    let(:expected_players_response) {
      [
          {
              name: player.name
          }.stringify_keys
      ].to_json
    }


    it 'returns list of players as json' do
      get :index, format: :json
      expect(response.body).to eq(expected_players_response)
    end
  end
end
