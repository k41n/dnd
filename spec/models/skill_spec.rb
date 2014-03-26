require 'spec_helper'

describe Skill do

  let(:skill) { create :skill }
  let(:character_class) { create :character_class }

  it 'could be made available for specific character class' do
    expect{
      skill.available_for << character_class
    }.to change{ Skill.last.available_for.size }.from(0).to(1)
  end
end
