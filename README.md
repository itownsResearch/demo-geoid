# iTowns : Demo-geoid

This demo showcases the use of [itowns2](itowns) ([geoid branch](http://github.com/iTowns/itowns2/tree/geoid)) to show the Earth's [geoid](https://en.wikipedia.org/wiki/Geoid).

[![Demo](http://www.itowns-project.org/demo-geoid/demo-geoid.jpg)](http://www.itowns-project.org/demo-geoid/)

To produce a new dataset pyramid, a possibility is to create two gdal-compatible images of size (512x2^N)x(256x2^N), such as 8192x4096 or 4096x2048, and to process them with the provided publish_pyramid.sh script.
- 1 single-channel float32 image for the elevation
- 1 color image (rgb uint8) for the coloring

For instance, the provided dataset as been created from files named "localcolors.tif" and "geoid.tif" using :
* ./publish_pyramid.sh localcolors.tif 4 4096 localcolors JPEG jpg
* ./publish_pyramid.sh geoid.tif  4 4096 geoid ENVI bil

# Dataset
The dataset credentials are : "© IGN, dataset : EIGEN-6C4 model (CNES/GRGS and GFZ)"
