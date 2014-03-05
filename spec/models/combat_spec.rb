require 'spec_helper'

describe Combat do

  let(:combat) { create :combat }
  
  it_behaves_like 'faye observable'
end
