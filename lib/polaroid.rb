module Fleximage
  module Operator

    # Make an image into a polaroid

    class Polaroid < Operator::Base
      def operate(options = {})

        # apply border
        @image.border!(18, 18, '#f0f0ff')

	      # Bend the image
	      @image.background_color = 'none'
	      amplitude = @image.columns * 0.01
	      wavelength = @image.rows  * 2
	      @image.rotate!(90)
	      @image = @image.wave(amplitude, wavelength)
	      @image.rotate!(-90)

	      # Make the shadow
	      shadow = @image.flop
	      shadow = shadow.colorize(1, 1, 1, "gray75")
	      shadow.background_color = "white"
	      shadow.border!(10, 10, "white")
	      shadow = shadow.blur_image(0, 3)

	      # Composite image over shadow
	      @image = shadow.composite(@image, -amplitude/2, 5, Magick::OverCompositeOp)
	      @image.rotate!(+2)
	      @image.trim!
      end
    end

  end
end

