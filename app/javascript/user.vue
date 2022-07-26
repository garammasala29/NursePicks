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
            td(v-if='currentUserId == userId' @click='deletePost(post.id)')
              i.fa-solid.fa-trash-can.has-text-info
              //- deleteButton(:post='post')
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
              //- deleteButton(:post='comment')
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
import deleteButton from 'delete_button.vue'
import { useToast } from 'vue-toast-notification'
const $toast = useToast()

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
    deletePost(id) {
      if (window.confirm('本当に削除してもよろしいですか？')) {
        fetch(`/api/posts/${id}`, {
          method: 'DELETE',
          headers: {
            'Content-Type': 'application/json; charset=utf-8',
            'X-Requested-With': 'XMLHttpRequest',
            'X-CSRF-Token': document
              .querySelector('meta[name="csrf-token"]')
              ?.getAttribute('content')
          }
        })
          .then((response) => {
              if (response.ok) {
                console.log(this.posts)
                this.posts = this.posts.filter(
                  (post) =>  post.id !== id
                )
                console.log(this.posts)
                $toast.success('記事を削除しました')
              }
            })
      }
    }
  }
}
</script>
