require 'spec_helper'

describe "Api::CharactersController" do

  let(:player) { create(:player) }  
  let(:another_player) { create(:player) }
  let(:character) { create(:character) }

  context 'GET /api/characters' do
    before do
      create_list :character, 5, player: player
      create_list :character, 5, player: another_player
    end

    it 'gives all characters to user not logged in' do
      do_get '/api/characters'
      expect(json_body.size).to eq(10)
    end

    it 'gives owned characters to user logged in' do
      login_player player
      do_get '/api/characters/my'
      expect(json_body.size).to eq(5)
    end

    it 'includes skills in JSON' do
      Character.destroy_all
      create_list :skill, 5, characters: [ character ]
      do_get "/api/characters"
      expect(json_body[0]['skills'].size).to eq(5)
    end
  end

  context 'POST /api/characters' do

    def character_hash
      {
        name: Faker::Name.name
      }
    end

    it 'does not create character without login' do
      do_post '/api/characters', character_hash
      expect(status).to eq(401)   
    end

    it 'does create characted with proper login' do
      login_player player      
      expect {
        do_post '/api/characters', character_hash
      }.to change{Character.count}.from(0).to(1)
      expect(Character.last.player.id).to eq(player.id)
    end
  end

  context 'POST /api/characters/invite' do

    let(:game) { create :game }

    it 'invites character to game if both specified' do
      expect {
        do_post '/api/characters/invite', gameId: game.id, name: character.name
      }.to change{ character.invited_to?(game) }.from(false).to(true)
    end
  end

end