module Fleximage
  module Operator

    # Change the colourspace

    class Colourspace < Operator::Base
      def operate(options = {})

        # set colourspace
        @image.colorspace = Magick::RGBColorspace
        @image
      end
    end

  end
end

