class AddExistingUsersToDefaultLeague < ActiveRecord::Migration[5.0]
  def up
    league = League.create(name: 'Super Pickem 2018-19')
    users = User.all.each do |user|
      LeaguesUser.find_or_create_by(user_id: user.id, league_id: league.id)
    end
  end

  def down
    LeaguesUser.delete_all
  end
end
