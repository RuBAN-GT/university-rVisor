module Heatmap
  class Image
    attr_accessor :area

    def initialize
      @area = []
    end

    def <<(item)
      @area << { :x => item[0].to_f, :y => item[1].to_f } if item.is_a?(Array) && item.length >= 2
    end

    def generate(sample, file)
      s_obj    = Magick::Image.read(sample).first
      width    = s_obj.columns.to_f
      height   = s_obj.rows.to_f

      point    = "#{Rails.root}/lib/assets/heatmap/point.png"
      p_obj    = Magick::Image.read(point).first
      gradient = "#{Rails.root}/lib/assets/heatmap/gradient.png"

      # Creating a blank canvas
      system "convert -size #{width}x#{height} pattern:gray100 #{file}"

      # Drawing each area
      compose = ["convert #{file}"]
      compose << @area.map do |data|
        "-page " +
            "+#{data[:x] * width - p_obj.columns.to_f / 2}" +
            "+#{data[:y] * height - p_obj.rows.to_f / 2} #{point}"
      end
      compose << "-layers flatten #{file}"
      system compose.join(" ")

      # Applying color with a LUT
      system "convert -channel ALL -clut #{file} #{gradient} #{file}"

      # Apply a default 50% opacity
      system "convert #{file} -alpha set -channel A -evaluate set 50% #{file}"

      system "composite -gravity center #{file} #{sample} #{file}"

      file
    end
  end
end