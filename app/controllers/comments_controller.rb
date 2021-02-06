class CommentsController < ApplicationController
    before_action :redirect_if_not_logged_in

    def new
        @comment = Comment.new
    end

    def index
        if params[:winery_id] && @winery = Winery.find_by_id(params[:winery_id])
            @comments = @winery.comments
        else
            @error = "That winery doesn't exist" if params[:winery_id]
            @comments = Comment.all
        end
    end

    def create
        @comment = current_user.comments.build(comment_params)
        if @comment.save
            redirect_to comments_path
        else
            render :new
        end
    end

    def show
        @comment = Comment.find_by(id: params[:id])
    end
    
    def edit
        @comment = Commment.find_by(id: params[:id])
    end

    def update
        @comment = Commment.find_by(id: params[:id])
        if @comment.update(comment_params)
            redirect_to comment_path
        else
            render :edit
        end
    end

    private
        def comment_params
            params.require(:comment).permit(:content)
        end
end
