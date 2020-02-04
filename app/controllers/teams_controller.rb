class TeamsController < ApplicationController
    before_action :get_event
    before_action :get_round
    
    def new
        @team = Team.new
    end

    def create
        @team = Team.new(team_params)
        @team.event = @event
        if @team.save
            redirect_to @event
        else
            render 'new'
        end
    end

    def show
        @team = Team.find(params[:id])
    end

    def index
        @teams = Team.all
    end

    def edit
        @team = Team.find(params[:id])
    end

    def update
        @team = Team.find(params[:id])

        if @team.update(team_params)
            redirect_to event_round_path(@event,@round)
        else
            render 'edit'
        end
    end

    private
        def team_params
            params.require(:team).permit(:event_id, :round_id, player_ids: [])
        end

        def get_event
            @event = Event.find(params[:event_id])
        end

        def get_round
            @round = Round.find(params[:round_id])
        end
end
