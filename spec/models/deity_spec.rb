require 'spec_helper'

describe Deity do

  let(:deity) { create :deity }

  context 'character relation' do

    let(:character) { build :character }

    it 'can be selected for character' do
      expect {
        character.deity = deity
        character.save
        character.reload
      }.to change{ character.deity }.from(nil).to(deity)
      expect(character.deity.name).to eq(deity.name)
    end
  end
end
