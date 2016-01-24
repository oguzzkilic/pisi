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
    $file_name = gets.chomp.to_s
  end

  def file_check
    if File.exist?($file_name)
      extension = File.extname($file_name)
      extension == ".psd" ? (puts "Parsing...") : (puts "File extension is incorrect")
    end
  end

  def file_parse
    psd = PSD.new("#{$file_name}", parse_layer_images: true)
    psd.parse!

    psd.tree.descendant_layers.each do |layer|
      sprite = layer.name[0..5]
      path   = layer.path

      if sprite === "sprite"
        FileUtils.mkdir_p("output")
        layer.image.save_as_png "output/#{path}.png"
      end

    end
  end

  def create_retina_images
    Dir.glob("output/*.png") do |fname|
      img = Magick::Image.read(fname)[0]
      img.thumbnail(2).write("#{fname}@2x.png")
    end
  end

  def run
    file_get
    file_check
    file_parse
    create_retina_images

    puts "Finish"
  end
end

pisi = Pisi.new
pisi.run
