class GamesController < ApplicationController
    include Saulabs::TrueSkill

    before_action :get_round
    before_action :get_event_from_round
    def new
        @game = Game.new
    end

    def create
        @game = Game.new(game_params)
        @game.event = @event
        if @game.save
            redirect_to event_round_game_path(@round,@game)
        else
            render 'new'
        end
    end

    def show
        @game = Game.find(params[:id])
    end

    def index
        @games = Game.all
    end

    def edit
        @game = Game.find(params[:id])
    end

    def update
        @game = Game.find(params[:id])

        old_complete = @game.complete

        if @game.update(game_params)
            if @game.complete && !old_complete
                update_ratings()
            end
            redirect_to event_round_path(@event,@round)
        else
            render 'edit'
        end
    end

    private
        def update_ratings
            team1t = []
            team2t = []
            team1activity = (@game.team1.players.length.to_f/@event.teamsize)
            @game.team1.players.each do |player|
                pt = Saulabs::TrueSkill::Rating.new(player.tskill,player.tdeviation,team1activity)
                team1t << pt
            end
            team2activity = (@game.team2.players.length.to_f/@event.teamsize)
            @game.team2.players.each do |player|
                pt = Saulabs::TrueSkill::Rating.new(player.tskill,player.tdeviation,team2activity)
                team2t << pt
            end

            tgraph = nil
            if @game.t1score > @game.t2score
                puts "Starting t update: " + Time.now.strftime("%d/%m/%Y %H:%M:%S")
                tgraph = Saulabs::TrueSkill::FactorGraph.new({team1t => 1, team2t => 2},{:draw_probability => 0.0, :skills_additive => false})
                tgraph.update_skills
                puts "Ending t update: " + Time.now.strftime("%d/%m/%Y %H:%M:%S")

                add_player_ratings_and_points(team:@game.team1, points:@event.points_for_win, tratings: tgraph.teams[0])
                add_player_ratings_and_points(team:@game.team2, points:@event.points_for_loss, tratings: tgraph.teams[1])
            else
                tgraph = Saulabs::TrueSkill::FactorGraph.new({team2t => 1, team1t => 2},{:draw_probability => 0.0, :skills_additive => false})
                tgraph.update_skills
                
                add_player_ratings_and_points(team:@game.team2, points:@event.points_for_win, tratings: tgraph.teams[0])
                add_player_ratings_and_points(team:@game.team1, points:@event.points_for_loss, tratings: tgraph.teams[1])
            end
        end

        def add_player_ratings_and_points(team:, points:, tratings: [])
            x = 0
            team.players.each do |player|
                player.points = player.points + points
                player.tdeviation = tratings[x].deviation
                player.tskill = tratings[x].mean
                player.save
                rh = RankHistory.new()
                rh.player = player
                rh.game = @game
                rh.tskill = player.tskill
                rh.tdeviation = player.tdeviation
                rh.points = player.points
                rh.save
                x = x + 1
            end
        end

        def game_params
            params.require(:game).permit(:round_id, :complete, :t1score, :t2score)
        end

        def get_round
            @round = Round.find(params[:round_id])
        end
        def get_event_from_round
            if params[:event_id].present?
                @event = Event.find(params[:event_id])
            else
                @event = @round.event
            end
        end
end
