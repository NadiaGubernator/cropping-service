FactoryGirl.define do
  factory :processing do
    after :create do |b|
      b.update_column(:image, 'spec/fixtures/images/rails.png')
    end
  end
end
