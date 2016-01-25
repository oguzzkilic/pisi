# Pisi

You can export images from your PSD files in an easy and fast way. It is enough that you add “sprite” prefix to the names of the layers that belong to the images that you want to use for sprite.

Pisi simply scans all PSD files and export all of the matching images. During this process, it resizes the images as double of the original size for retina screens and rename the files according to the denomination criteria of sprite plugins

All you need to do is to drag and drop the exported images to the related workspace to use them with sprite plugins. This denomination process will save time during the design process.

# Usage
```sh
$ ruby pisi.rb
```
* layer names must start with "sprite" prefix
* Example: sprite-icon-fb => icon-fb.png & icon-fb@2x.png

# Features

* Support for retina displays
* Creating 1x, 2x .png images

# License
Licensed under the MIT license.
