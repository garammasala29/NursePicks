<template lang="pug">
section.user-tabs
  nav.tabs.is-centered.is-boxed.is-fullwidth
    ul
      li(:class="{'is-active': isSelect == 'posts'}")
        a(@click="isSelect='posts'")
          i.fa-solid.fa-file-medical
          | 投稿した記事
      li(:class="{'is-active': isSelect == 'comments'}")
        a(@click="isSelect='comments'")
          i.fa-solid.fa-message
          | コメント
      li(:class="{'is-active': isSelect == 'likes'}")
        a(@click="isSelect='likes'")
          i.fa-solid.fa-thumbs-up
          | いいねした記事
  section.tab-contents
    .content(:class="{'is-active': isSelect == 'posts'}")
      table.table.is-striped
        tbody
          tr(v-for='(post, index) in posts' :key='post.id')
            th
              | {{ index + 1 }}
            td
              a(:href='post.path') {{ post.title }}
            td(v-if='currentUserId == userId' @click='deletePost(post.id)')
              button.button.is-small.is-info.delete-button
                i.fa-solid.fa-trash-can
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
            td(v-if='currentUserId == userId' @click='deleteComment(comment.post_id, comment.id)')
              button.button.is-small.is-info.delete-button
                i.fa-solid.fa-trash-can
    .content(:class="{'is-active': isSelect == 'likes'}")
      table.table.is-striped
        tbody
          tr(v-for='(like, index) in likes')
            th
              | {{ index + 1 }}
            td
              a(:href='like.postPath') {{ like.post_title }}
            td(v-if='currentUserId == userId' @click='deleteLike(like.post_id, like.id)')
              button.button.is-small.is-info.delete-button
                i.fa-solid.fa-heart
</template>

<script>
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
      isSelect: 'posts'
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
    deletePost(id) {
      if (window.confirm('記事を削除してもよろしいですか？')) {
        fetch(`/api/posts/${id}`, {
          method: 'DELETE',
          headers: {
            'Content-Type': 'application/json; charset=utf-8',
            'X-Requested-With': 'XMLHttpRequest',
            'X-CSRF-Token': document
              .querySelector('meta[name="csrf-token"]')
              ?.getAttribute('content')
          }
        }).then((response) => {
          if (response.ok) {
            this.posts = this.posts.filter((post) => post.id !== id)
            $toast.success('記事を削除しました')
          }
        })
      }
    },
    deleteComment(postId, commentId) {
      if (window.confirm('コメントを削除してもよろしいですか？')) {
        fetch(`/api/posts/${postId}/comments/${commentId}`, {
          method: 'DELETE',
          headers: {
            'Content-Type': 'application/json; charset=utf-8',
            'X-Requested-With': 'XMLHttpRequest',
            'X-CSRF-Token': document
              .querySelector('meta[name="csrf-token"]')
              ?.getAttribute('content')
          }
        }).then((response) => {
          if (response.ok) {
            this.comments = this.comments.filter(
              (comment) => comment.id !== commentId
            )
            $toast.success('コメントを削除しました')
          }
        })
      }
    },
    deleteLike(postId, likeId) {
      if (window.confirm('いいねを削除してもよろしいですか？')) {
        fetch(`/api/posts/${postId}/likes/${likeId}`, {
          method: 'DELETE',
          headers: {
            'Content-Type': 'application/json; charset=utf-8',
            'X-Requested-With': 'XMLHttpRequest',
            'X-CSRF-Token': document
              .querySelector('meta[name="csrf-token"]')
              ?.getAttribute('content')
          }
        }).then((response) => {
          if (response.ok) {
            this.likes = this.likes.filter((like) => like.id !== likeId)
            $toast.success('いいねを削除しました')
          }
        })
      }
    }
  }
}
</script>
