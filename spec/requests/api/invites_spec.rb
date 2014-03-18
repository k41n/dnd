require 'spec_helper'

describe "Api::InvitesController" do

  let(:player) { create(:player) }  
  let(:another_player) { create(:player) }
  let(:character1) { create :character, player: player }
  let(:character2) { create :character, player: another_player }

  context 'GET /api/invites' do
    before do
      create_list :game_invitation, 5, character: character1
      create_list :game_invitation, 5, character: character2
    end

    it 'gives owned characters to user logged in' do
      login_player player
      do_get '/api/invites'
      expect(json_body.size).to eq(5)
    end
  end

  context 'POST /api/invites/:id/accept' do
    let(:game) { create :game }
    let!(:invite) { create :game_invitation, character: character1, game: game }

    it 'accepts invite' do
      expect {
        do_post "/api/invites/#{invite.to_param}/accept"
      }.to change{character1.invited_to?(game)}.from(true).to(false)
    end
  end
end