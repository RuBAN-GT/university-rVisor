class TestScreenUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  storage :file

  def store_dir
    "uploads/tests/screens/"
  end

  def extension_whitelist
    %w(jpg png)
  end

  process resize_to_fit: [1920, 4000]
  process convert: 'png'

  version :thumb do
    process :resize_to_fill => [250, 250]
  end

  def filename
    "#{secure_token(10)}.#{file.extension}" if original_filename.present?
  end

  protected

    def secure_token(length=16)
      var = :"@#{mounted_as}_secure_token"
      model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.hex(length/2))
    end
end
