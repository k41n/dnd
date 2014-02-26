require 'spec_helper'

describe Game do

  let(:game) { create :game }

  context '#as_json' do

    let(:expected_hash) {
      {
          name: game.name,
          master: game.master.name,
          description: game.description
      }
    }

    it 'returns only required keys' do
      expect(game.as_json.to_hash).to eq(expected_hash)
    end
  end

  context '#validate' do

    let(:proper_params) {
      {
        name: game.name,
        master: game.master,
        description: game.description
      }
    }

    let(:params_without_name) {
      proper_params.delete_if{ |k,_| k == :name }
    }

    let(:game_without_name) {
      Game.new(params_without_name)
    }

    it 'requires name' do
      expect(game_without_name).not_to be_valid
    end
  end
end
