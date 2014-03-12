require 'spec_helper'

describe "Api::MonstersController" do

  let(:monster) { create :monster }

  context 'GET /api/monsters' do
    it 'includes skills in JSON' do
      create_list :skill, 5, monsters: [ monster ]
      do_get "/api/monsters"
      expect(json_body[0]['skills'].size).to eq(5)
    end
  end

end