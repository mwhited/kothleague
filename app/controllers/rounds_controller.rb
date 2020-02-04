class RoundsController < ApplicationController
    before_action :get_event
    def new
        @round = Round.new
    end

    def create
        @round = Round.new(round_params)
        @round.event = @event
        if @round.save
            if @round.started && (@round.games.nil? || @round.games.empty?)
                generateGames(player_ids:@round.player_ids, numgames:@round.numgames)
            end
            redirect_to event_round_path(@event,@round)
        else
            render 'new'
        end
    end

    def show
        @round = Round.find(params[:id])
    end

    def index
        @rounds = Round.all
    end

    def edit
        @round = Round.find(params[:id])
    end

    def update
        @round = Round.find(params[:id])

        if @round.update(round_params)
            if @round.started && (@round.games.nil? || @round.games.empty?)
                generateGames(player_ids:@round.player_ids, numgames:@round.numgames)
            end
            redirect_to event_round_path(@event,@round)
        else
            render 'edit'
        end
    end

    private
        def round_params
            params.require(:round).permit(:event_id, :name, :datetime, :started, :numgames, player_ids: [])
        end

        def get_event
            @event = Event.find(params[:event_id])
        end

        def generateGames(player_ids: [], numgames:)
            teams = generateTeams(player_ids:player_ids, numteams:(numgames*2))
            teams.shuffle!
            games = Array.new(numgames){Game.new}

            i = 0
            games.each do |game|
                game.round = @round
                game.team1 = teams[i]
                game.team2 = teams[i+1]
                game.complete = false
                game.t1score = 0
                game.t2score = 0
                i = i+2
                game.save
            end
        end

        def generateTeams(player_ids: [], numteams:)
            players = Player.where(id: player_ids).order("tskill desc")
            
            teams = Array.new(numteams){Team.new}
            i = 0
            players.each do |player|
                team = snake(1,numteams, i)-1
                teams[team].players << player
                i = i + 1
            end
    
            teams.each do |team|
                team.event = @event
                team.save
            end

            return teams
        end
    
        def snake(low, high, x)
            k = (high-low+1)
            m = x % (2*k)
            v = m + low - k - 0.5
            a = v.abs()
            f = a.floor()
            r = k - f
            return r
        end
end
