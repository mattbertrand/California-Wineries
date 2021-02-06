class WineriesController < ApplicationController
    before_action :redirect_if_not_logged_in

    def new
        if params[:user_id] && @user = User.find_by_id(params[:user_id])
            @winery = @user.wineries.build
        else
            @winery = Winery.new
        end
    end

    def show
        @winery = Winery.find_by(id: params[:id])
        redirect_to wineries_path if !@winery
    end

    def create
        @winery = current_user.wineries.build(winery_params)
        if @winery.save
            redirect_to wineries_path
        else
            render :'new'
        end
    end

    def index
        @wineries = Winery.all
    end

    private
        def winery_params
            params.require(:winery).permit(:name, :website, :phone, :description)
        end
end
