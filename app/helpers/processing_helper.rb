module ProcessingHelper
  def cropped_image(processing)
    processing.image.cropped.url.to_s
  end
end
