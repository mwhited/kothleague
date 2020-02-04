class RankHistoryController < ApplicationController
    before_action :get_event
    before_action :get_player

    def new
        @rankhistory = RankHistory.new
    end

    def create
        @rankhistory = RankHistory.new(rankhistory_params)

        if @rankhistory.save
            redirect_to @rankhistory
        else
            render 'new'
        end
    end

    def show
        @rankhistory = RankHistory.find(params[:id])
    end

    def index
        @rankhistorys = RankHistory.all
    end

    def edit
        @rankhistory = RankHistory.find(params[:id])
    end

    def update
        @rankhistory = RankHistory.find(params[:id])

        if @rankhistory.update(rankhistory_params)
            redirect_to event_player_path(@event,@player)
        else
            render 'edit'
        end
    end

    private
        def rankhistory_params
            params.require(:rankhistory).permit(:event_id, :player_id)
        end

        def get_event
            @event = Event.find(params[:event_id])
        end

        def get_player
            @player = Event.find(params[:player_id])
        end
end
