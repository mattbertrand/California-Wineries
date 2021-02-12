class WineriesController < ApplicationController
    before_action :redirect_if_not_logged_in
    before_action :find_winery, only: [:show, :edit, :update, :destroy]
    before_action :find_region, only: [:index, :new, :create]
    
    def new
        if params[:user_id] && @user = User.find_by_id(params[:user_id])
            @winery = @user.wineries.build
        else
            @winery = Winery.new
        end
        @winery.build_region
    end

    
    def create
        @winery = current_user.wineries.build(winery_params)
        if @winery.save
            if @region
                redirect_to region_wineries_path(@region)
            else
                redirect_to wineries_path
            end
        else
            flash.now[:error] = @winery.errors.full_messages
            if @region
                render :new_region_winery
            else
                render :'new'
            end
        end
    end
    
    def index
        if params[:user_id] && @user = User.find_by_id(params[:user_id])
            @wineries = @user.wineries.alpha
        else
            @error = "That user doesn't exist" if params[:user_id]
            @wineries = Winery.alpha
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
            @winery = Winery.find_by_id(params[:id])
        end

        def find_region
            if params[:region_id]
                @region = Region.find_by_id(params[:id])
            end
        end
end
