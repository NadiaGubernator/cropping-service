class ProcessingsController < ApplicationController
  helper_method :processing

  def new
    @processing = Processing.new

    render :form
  end

  def create
    @processing = Processing.new(processing_params)

    if @processing.save
      redirect_to processings_path
    else
      render :form
    end
  end

  def update
    if processing.update(crop_params)
      Processing::UpdateCrop.call(processing)
      redirect_to processing
    else
      redirect_to edit_processing_path(processing)
    end
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
