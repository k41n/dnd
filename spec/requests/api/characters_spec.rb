require 'spec_helper'

describe "Api::CharactersController" do

  let(:player) { create(:player) }  
  let(:another_player) { create(:player) }
  let(:character) { create(:character) }
  let(:perk) { create(:perk) }

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
      expect(json_body[0]['skill_ids'].size).to eq(5)
    end
  end

  context 'POST /api/characters' do

    def character_hash
      {
        name: Faker::Name.name
      }
    end

    def character_hash_with_perks
      character_hash.merge({
        perk_ids: [ perk.to_param ],
        perk_settings: { 
          perk.to_param => {
            stat: 'str',
            stat1: 'cha'
          }
        }.to_json
      })
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

    it 'saves perks settings' do
      login_player player
      expect {
        do_post '/api/characters', character_hash_with_perks
      }.to change{Character.count}.from(0).to(1)
      expect(Character.last.perks.size).to eq(1)
      expect(Character.last.perk_settings).to eq({perk.to_param => {"stat" => "str", "stat1" => "cha"}}.to_json)
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

  context 'POST /api/characters/accept/:invitation_id' do
    let(:game) { create :game }

    before do
      @invite = character.invite_to(game)
    end

    it 'accepting invite destroys it' do
      expect {
        do_post "/api/characters/accept/#{@invite.to_param}"
      }.to change{ character.invited_to?(game) }.from(true).to(false)
    end
  end

end