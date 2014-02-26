module ControllerMacros
  include Warden::Test::Helpers

  def login_master
    master = create(:master)
    Warden.test_mode!
    login_as master, scope: :player
  end

end