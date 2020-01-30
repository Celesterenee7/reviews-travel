class ReviewsController < ApplicationController
  before_action :admin_only, only: [:edit, :update, :destroy]

  def index
    @destination = Destination.find(params[:destination_id])
    if params[:input_parameter]
      @reviews = @destination.reviews.search(params[:input_parameter])
      json_response(@reviews)
    else
      @reviews = Review.all
      json_response(@reviews)
    end
  end

  def show
    @destination = Destination.find(params[:destination_id])
    @review = Review.find(params[:id])
    json_response(@review)
  end

  def new
    @destination = Destination.find(params[:destination_id])
    @review = @destination.reviews.new
    json_response(@review)
  end

  def create
    @destination = Destination.find(params[:destination_id])
    @review = @destination.reviews.new(review_params)
    json_response(@review, :created)
  end

  def update
    @review = Review.find(params[:id])
    if @review.update!(review_params)
      render status: 200, json: {
        message: "This review has been updated successfully."
      }
    end
  end

  def destroy
    @review = Review.find(params[:id])
    if @review.destroy
      render status: 200, json: {
        message: "This review has been deleted successfully."
      }
    end
  end

  def review_params
    params.require(:review).permit(:author, :content_body, :rating)
  end
end
