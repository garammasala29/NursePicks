json.id post.id
json.title post.title
json.url post.url
json.site_name post.site_name
json.image_url post.image_url
json.user_id post.user_id
json.created_at post.created_at
json.date l(post.created_at, format: :short)
json.comments post.comments
json.comments_count post.comments.size
json.show_url post_url(post)
json.likes post.likes
json.likes_id post.likes.pluck(:id)
json.like_users post.likes.pluck(:user_id)
json.likes_count post.likes.size
json.tags post.tags do |tag|
  json.name tag.name
end