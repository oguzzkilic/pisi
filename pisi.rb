# Pisi - simple psd to png
# Author @oguzzkilic

require "fileutils"
require "rubygems"
require "rmagick"
require "psd"

class Pisi
  $file_name;
  
  def file_get
    puts "Enter file path" 
    # example: file.psd or ../file.psd etc.
    $file_name = gets.chomp.to_s
  end

  def file_check
    if File.exist?($file_name)
      extension = File.extname($file_name)
      
      # is it .psd ?
      extension == ".psd" ? (puts "Parsing...") : (puts "File extension is incorrect")
    end
  end

  def file_parse
    psd = PSD.new("#{$file_name}", parse_layer_images: true)
    psd.parse! # parsing all layers

    psd.tree.descendant_layers.each do |layer|
      sprite = layer.name[0..5] # get layer prefix
      path   = layer.path

      if sprite === "sprite"
        FileUtils.mkdir_p("output") # create new dir
        layer.image.save_as_png "output/#{path}.png" # save all the images dir
      end

    end
  end

  def create_retina_images
    Dir.glob("output/*.png") do |fname|
      img = Magick::Image.read(fname)[0]
      img.thumbnail(2).write("#{fname}@2x.png") # orginal size x2 for retina displays
    end
  end

  def run
    file_get
    file_check
    file_parse
    create_retina_images
    
    # end message
    puts "Finish"
  end
end

pisi = Pisi.new
pisi.run
