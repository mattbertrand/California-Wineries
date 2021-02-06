class WineriesController < ApplicationController
    before_action :redirect_if_not_logged_in

    def new
        @winery = Winery.new
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
