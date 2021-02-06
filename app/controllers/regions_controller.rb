class RegionsController < ApplicationController
    def index
        @regions = Region.all.includes(:wineries)
    end

    def show
        @region = Region.find_by_id(params[:id])
    end

    def new
    end
end
