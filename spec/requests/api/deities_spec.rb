require 'spec_helper'

describe "Api::DeitiesController" do

  context 'GET /api/deities' do
    it 'returns list of deities' do
      create_list :deity, 5
      do_get "/api/deities"
      expect(json_body.size).to eq(5)
    end
  end

end