class ProcessingsController < ApplicationController
  helper_method :processing

  def new
    @processing = Processing.new

    render :form
  end

  def create
    @processing = Processing.new(processing_params)

    if @processing.save
      render :edit
    else
      render :form
    end
  end

  def update
    if processing.update(crop_params)
      redirect_to processing
    else
      render :edit
    end
  end

  private

  def processing
    @processing ||= Processing.find(params[:id])
  end

  def processing_params
    params.require(:processing).permit(:image, :remote_image_url)
  end

  def crop_params
    params.require(:processing).permit(:crop_x, :crop_y)
  end
end
