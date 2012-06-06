require 'RMagick'

class HomeController < ApplicationController
  
  def colortone(image, color, level, negate)
    background = image.clone
    overlay = image.clone
    
    background = background.colorize(1.00, 1.00, 1.00, color)
    overlay = overlay.quantize(number_colors=256, colorspace=GRAYColorspace)
    
    if negate
      overlay = overlay.negate
    end
  
    return background.blend(overlay, level)
  end
  
  def index
    image = ImageList.new("public/sendoff.jpg")
    
    result = colortone(image, "#222b6d", 0.75, false)
    result = colortone(result, "#f7daae", 0.10, true)
    result = result.contrast
    result = result.modulate(1.00, 1.50, 1.00)
    result = result.auto_gamma_channel
    
    send_data result.to_blob, :stream => 'false', :filename => 'test.jpg', :type => 'image/jpeg', :disposition => 'inline'
  end
end
