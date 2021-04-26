class ImageSerializer
  include FastJsonapi::ObjectSerializer
  attributes :image, :image_url, :location
end
