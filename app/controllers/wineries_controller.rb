class WineriesController < ApplicationController
    before_action :redirect_if_not_logged_in
    before_action :set_comment, only: [:show, :edit, :update]
    before_action :redirect_if_not_comment_author, only: [:edit, :update]

    def new
        if params[:user_id] && @user = User.find_by_id(params[:user_id])
            @winery = @user.wineries.build
        else
            @winery = Winery.new
        end
    end

    def index
        if params[:user_id] && @user = User.find_by_id(params[:user_id])
            @wineries = @user.wineries
        else
            @error = "That user doesn't exist" if params[:user_id]
            @wineries = Winery.all
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


    private
        def winery_params
            params.require(:winery).permit(:name, :website, :phone, :description)
        end

        def set_comment
            @comment = Comment.find_by(id: params[:id])
            flash[:message] = "Comment was not found"
            redirect_to comments_path
        end

        def redirect_if_not_comment_author
            redirect_to comments_path if @comment.user != current_user
        end
end
