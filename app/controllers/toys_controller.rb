class ToysController < ApplicationController
  wrap_parameters format: []

  def index
    toys = Toy.all
    render json: toys, status: :ok
  end

  def create
    toy = Toy.create!(toy_params)
    render json: toy, status: :created

  rescue ActiveRecord::RecordInvalid => invalid
    render json: { errors: invalid.record.errors }, status: :unprocessable_entity
  end

  def update
    toy = Toy.find_by(id: params[:id])
    toy.update(toy_params)
    render json: toy, status: :accepted

  rescue ActiveRecord::RecordInvalid => e
    render json: {errors: e.record.errors.full_messages}, status: :unprocessable_entity
  end

  def destroy
    toy = Toy.find_by(id: params[:id])
    toy.destroy
    head :no_content

  rescue ActiveRecord::RecordNotFound => e
    render json: {errors: e.record.errors.full_messages}, status: :not_found
  end

  private
  
  def toy_params
    params.permit(:name, :image, :likes)
  end

end
