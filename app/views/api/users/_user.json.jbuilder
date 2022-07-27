json.id user.id
json.name user.name
json.url user.url
json.icon_url user.icon_url
json.posts user.posts do |post|
  json.id post.id
  json.title post.title
  json.user_id post.user_id
  json.path post_path(post)
end
json.comments user.comments.includes(:post) do |comment|
  json.id comment.id
  json.content comment.content
  json.post_id comment.post.id
  json.post_title comment.post.title
  json.postPath post_path(comment.post_id)
end
json.likes user.likes.includes(:post) do |like|
  json.id like.id
  json.post_id like.post.id
  json.post_title like.post.title
  json.postPath post_path(like.post_id)
end
