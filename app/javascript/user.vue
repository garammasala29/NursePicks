<template lang='pug'>
article.section
  .tabs.is-centered.is-medium.is-boxed
    ul
      li(:class="{'is-active': isSelect == 'posts'}")
        a(@click="isSelect='posts'")
          | 投稿した記事
          i.fa-solid.fa-file-medical
      li(:class="{'is-active': isSelect == 'comments'}")
        a(@click="isSelect='comments'")
          | コメント
          i.fa-solid.fa-message
      li(:class="{'is-active': isSelect == 'likes'}")
        a(@click="isSelect='likes'")
          | いいねした記事
          i.fa-solid.fa-thumbs-up
  .tab-contents
    .content(:class="{'is-active': isSelect == 'posts'}")
      ul(v-for='post in posts' :key='post.id')
        li
          a(:href='post.path') {{ post.title }}
              //- - if current_user == @user
                = button_to '削除', post, method: :delete
    .content(:class="{'is-active': isSelect == 'comments'}")
      ul(v-for='comment in comments')
        li
          a(:href='comment.postPath') {{ comment.content }} ーーー {{ comment.post_title }}
        //-     - if current_user == @user
        //-       = button_to '削除', post_comment_path(comment.post_id, comment), method: :delete
    .content(:class="{'is-active': isSelect == 'likes'}")
      ul(v-for='like in likes')
        li
          a(:href='like.postPath') {{ like.title }}
      //-       - if current_user == @user
      //-         = button_to 'いいねを外す', post_likes_path(like.post_id), method: :delete
</template>

<script>
export default {
  name: 'UserPosts',
  props: {
    currentUserId: { type: String, default: '' },
    userId: { type: String, default: null }
  },
  data() {
    return {
      posts: [],
      comments: [],
      likes: [],
      isSelect: 'posts',
    }
  },
  created() {
    this.getPosts()
  },
  methods: {
    getPosts() {
      fetch(`/api/users/${this.userId}`, {
        method: 'GET',
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'X-Requested-With': 'XMLHttpRequest'
        }
      })
        .then((response) => response.json())
        .then((json) => {
          this.posts = json.user.posts
          this.comments = json.user.comments
          this.likes = json.user.likes
        })
    },

  }
}
</script>
