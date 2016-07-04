module ModelHelpers
  def mocked_csv(filename)
    instance_double(ActionDispatch::Http::UploadedFile, original_filename: filename)
  end
end

RSpec.configure do |config|
  config.include ModelHelpers, type: :model
end
