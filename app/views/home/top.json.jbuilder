json.array! @posts do |post|
  json.body post.body
  json.post_image post.post_image
  json.country_name post.country_name
  json.tag_name tag.tag_name
end