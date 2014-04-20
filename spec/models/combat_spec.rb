require 'spec_helper'

describe Combat do

  let(:combat) { create :combat }
  let(:json1) { {a: 1}.to_json }
  
  it_behaves_like 'faye observable'

  context 'json content' do
    it 'has persistable json field' do
      expect{combat.update_attribute(:json, json1)}.to change{combat.json}.from(nil).to(json1)
    end

    it 'has persistable json_orig field' do
      expect{combat.update_attribute(:json_orig, json1)}.to change{combat.json_orig}.from(nil).to(json1)
    end

    it 'can copy json_orig to json' do
      combat.update_attribute(:json_orig, json1)
      expect{combat.reset_json}.to change{combat.json}.from(nil).to(json1)
    end
  end
end
