FactoryGirl.define do
  factory :processing, class: Processing do
    image Rack::Test::UploadedFile.new(
      File.open(
        File.join(
          Rails.root, '/spec/fixtures/images/space.jpg'
        )
      )
    )
  end
end
