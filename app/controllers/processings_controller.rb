class ProcessingsController < ApplicationController
  helper_method :processing

  def index
    @processing = Processing.last
  end

  def new
    @processing = Processing.new

    render :form
  end

  def create
    @processing = Processing.new(processing_params)

    if @processing.save
      redirect_to processings_path(created: true)
    else
      render :form
    end
  end

  def update
    return unless processing.update(crop_params)
    Processing::UpdateCrop.call(processing)
    redirect_to processing
  end

  private

  def processing
    @processing ||= Processing.friendly.find(params[:id])
  end

  def processing_params
    params.require(:processing).permit(:image, :remote_image_url)
  end

  def crop_params
    params.require(:processing).permit(:crop_x, :crop_y, :crop_size)
  end
end
