FactoryBot.define do
  factory :report do
    title { "MyString" }
    content { "MyText" }
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/IMG_4538.jpg' )) }
  end

  factory :reportB do
    title { "MyRepot" }
    content { "Text" }
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/IMG_4918.jpg' )) }
  end

end
