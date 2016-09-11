class GamesController < ApplicationController
  def index
    @week = params[:week_id]
    @games = Game.where(:week => @week)
                 .includes([:home_team, :away_team])
                 .as_json(:include => [:home_team, :away_team])

    @picks = current_user.picks.where(:week => @week)

    # this logic should be moved to model
    @games.each do |game|
      pick = @picks.find_by(:game_id => game['id'])
      if (pick)
        game['winner_id'] = pick['winner_id']
      end
    end
  end
end
