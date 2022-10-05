json.id user.id
json.name user.name
json.url user.url
json.icon_url user.icon_url
json.posts user.posts do |post|
  json.id post.id
  json.title post.title
  json.url post.url
  json.site_name post.site_name
  json.image_url post.image_url
  json.date l(post.created_at, format: :short)
  json.user_id post.user_id
  json.show_url post_url(post)
  json.comments_count post.comments.size
  json.tags post.tags do |tag|
    json.name tag.name
  end
end
json.comments user.comments.includes(:post) do |comment|
  json.id comment.id
  json.content comment.content
  json.post_id comment.post.id
  json.post_title comment.post.title
  json.post_url comment.post.url
  json.post_image_url comment.post.image_url
  json.show_url post_path(comment.post_id)
end
json.likes user.likes.includes(:post) do |like|
  json.id like.id
  json.post_id like.post.id
  json.post_title like.post.title
  json.postPath post_path(like.post_id)
end
