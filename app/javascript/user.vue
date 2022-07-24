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
      table.table.is-striped
        tbody
          tr(v-for='(post, index) in posts' :key='post.id')
            th
              | {{ index + 1 }}
            td
              a(:href='post.path') {{ post.title }}
            td(v-if='currentUserId == userId')
              i.fa-solid.fa-trash-can.has-text-info
              //- button.button.is-info.is-outlined(v-if='currentUserId == userId')
    .content(:class="{'is-active': isSelect == 'comments'}")
      table.table.is-striped
        tbody
          tr(v-for='(comment, index) in comments')
            th
              | {{ index + 1 }}
            td
              a(:href='comment.postPath') {{ comment.content }}
            td
              | {{ comment.post_title }}
            td(v-if='currentUserId == userId')
              i.fa-solid.fa-trash-can.has-text-info
            //- post_comment_path(comment.post_id, comment), method: :delete
    .content(:class="{'is-active': isSelect == 'likes'}")
      table.table.is-striped
        tbody
          tr(v-for='(like, index) in likes')
            th
              | {{ index + 1 }}
            td
              a(:href='like.postPath') {{ like.title }}
            //- td(v-if='currentUserId == userId')
            //-   likeButton(:post='post', :currentUserId='currentUserId')
</template>

<script>
import LikeButton from 'like_button.vue'

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
  components: {
    likeButton: LikeButton
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
