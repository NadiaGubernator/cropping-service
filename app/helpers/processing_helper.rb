module ProcessingHelper
  def cropped_image
    processing.image.cropped.url.to_s
  end

  def file_name
    t('file_name') + '_' + + processing.image.file.filename
  end

  def available_sizes
    Processing::SIZES.select { |size| crop_policy_allows?(size) }
  end

  def presence_policy_allows?
    Processing::PresencePolicy.new(processing, crop_x, crop_y).allowed?
  end

  def crop_policy_allows?(size = crop_size)
    Processing::CropPolicy.new(processing, size, crop_x, crop_y).allowed?
  end

  def policies_allow?
    presence_policy_allows? && crop_policy_allows?
  end

  def crop_size
    @crop_size ||= params[:size]
  end

  def crop_x
    @crop_x ||= params[:x]
  end

  def crop_y
    @crop_y ||= params[:y]
  end
end
