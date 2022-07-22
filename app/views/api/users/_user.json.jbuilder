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
json.comments user.comments do |comment|
  json.id comment.id
  json.content comment.content
  json.post_title comment.post.title
  json.postPath post_path(comment.post_id)
end
json.likes user.likes do |like|
  json.id like.id
  json.title like.post.title
  json.postPath post_path(like.post_id)
end
