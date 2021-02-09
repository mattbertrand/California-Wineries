class WineriesController < ApplicationController
    before_action :redirect_if_not_logged_in
    before_action :find_winery, only: [:show, :edit, :update, :destroy]
    
    def new
        if params[:user_id] && @user = User.find_by_id(params[:user_id])
            @winery = @user.wineries.build
        else
            @winery = Winery.new
        end
        @winery.build_region
    end

    def index
        if params[:user_id] && @user = User.find_by_id(params[:user_id])
            @wineries = @user.wineries.alpha
        else
            @error = "That user doesn't exist" if params[:user_id]
            @wineries = Winery.alpha
        end
    end

    def create
        @winery = current_user.wineries.build(winery_params)
        if @winery.save
            redirect_to wineries_path
        else
            flash.now[:error] = @winery.errors.full_messages
            render :'new'
        end
    end

    def show
        redirect_to wineries_path if !@winery
    end

    def edit
        redirect_to wineries_path if !@winery || @winery.user != current_user
        @winery.build_region if !@winery.region
    end

    def update
        redirect_to wineries_path if !@winery || @winery.user != current_user
        if @winery.update(winery_params)
            redirect_to winery_path(@winery)
        else
            flash.now[:error] = @winery.errors.full_messages
            render :edit
        end
    end

    def destroy
        @winery.destroy
        flash[:notice] = "#{@winery.name} was deleted"
        redirect_to wineries_path
    end

    private
        def winery_params
            params.require(:winery).permit(:name, :website, :phone, :description, :region_id, region_attributes: [:name])
        end

        def find_winery
            @winery = Winery.find_by(id: params[:id])
        end
end
