json.array! @posts do |post|
  json.body post.body
  json.post_image post.post_image
  json.country post.country
end