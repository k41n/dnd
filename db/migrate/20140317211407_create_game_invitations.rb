class CreateGameInvitations < ActiveRecord::Migration
  def change
    create_table :game_invitations do |t|
      t.references :character
      t.references :game
      t.timestamps
    end
  end
end
