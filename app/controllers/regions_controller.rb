class RegionsController < ApplicationController
    before_action :redirect_if_not_logged_in
    before_action :find_region, only: [:index, :new, :create, :destroy]

    def index
        @regions = Region.all.includes(:wineries)
    end

    def show
        @region = Region.find_by_id(params[:id])
    end

    def new
        @region = Region.new

        3.times { @region.wineries.build }
    end

    def create
        @region = Region.new(region_params)
        if @region.save
            redirect_to wineries_path
        else
            render :new
        end
    end

    def destroy
        @region.destroy
        flash[:notice] = "#{@region.name} was deleted"
        redirect_to wineries_path
    end

    private
        def region_params
            params.require(:region).permit(:name)
        end

        def find_region
            @region = Region.find_by_id(params[:id])
        end
end
