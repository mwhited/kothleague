class PlayersController < ApplicationController
    before_action :get_event
    def new
        @player = Player.new
    end

    def create
        @player = Player.new(player_params)
        @player.event = @event
        if @player.save
            redirect_to @event
        else
            render 'new'
        end
    end

    def show
        @player = Player.find(params[:id])
    end

    def index
        @players = Player.all
    end

    def edit
        @player = Player.find(params[:id])
    end

    def update
        @player = Player.find(params[:id])

        if @player.update(player_params)
            redirect_to @event
        else
            render 'edit'
        end
    end

    private
        def player_params
            params.require(:player).permit(:event_id, :name, :tdeviation, :tskill, :points)
        end

        def get_event
            @event = Event.find(params[:event_id])
        end
end
