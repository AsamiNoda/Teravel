json.array! @posts do |post|
  json.body post.body
  json.country_name post.country_name
  json.name post.user.name
end