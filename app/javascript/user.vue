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
      .empty-message(v-if='posts.length === 0')
        i.fa-regular.fa-face-sad-tear
        .empty-message-text
          | 投稿した記事はまだありません。
          p(v-if='currentUserId == userId')
            | おすすめの記事を投稿してみましょう！
      .posts(v-else)
        .post.media(v-for='post in posts' :key='post.id')
          .post-start
            .media-left
              a.post-image(:href='post.url', target='_blank', rel='noopener')
                img.image.is-64x64(:src='post.image_url', alt='post_image')
            .media-content
              .title.is-6
                a(:href='post.url', target='_blank', rel='noopener') {{ post.title }}
              .sub-title
                span
                  | {{ post.site_name }}
                  | {{ post.date }}
                span.post-tags
                  span.post-tag(v-for='tag in post.tags')
                    | {{ tag.name }}
            .media-right.comment-link(:class="{'has-comment': post.comments_count != 0}")
              a(:href='post.show_url')
                i.fa-solid.fa-message
                .post_comments_count
                  | {{ post.comments_count }}
            .media-right.delete-button(v-if='currentUserId == userId' @click='deletePost(post.id)')
              i.fa-solid.fa-trash-can
          .is-mobile-sub-title
            | {{ post.site_name }}
            | {{ post.date }}
            span.post-tags
              span.post-tag(v-for='tag in post.tags')
                | {{ tag.name }}
    .content(:class="{'is-active': isSelect == 'comments'}")
      .empty-message(v-if='comments.length === 0')
        i.fa-regular.fa-face-sad-tear
        .empty-message-text
          | 投稿したコメントはまだありません。
          p(v-if='currentUserId == userId')
            | 気になる記事にコメントしてみましょう！
      .posts(v-else)
        .post.media(v-for='comment in comments' :key='comment.id')
          .post-start
            .media-left.media-image
              a.post-image(:href='comment.post_url', target='_blank', rel='noopener')
                img.image.is-64x64(:src='comment.post_image_url', alt='post_image')
            .media-content
              .title.is-6
                a(:href='comment.show_url') {{ comment.content }}
              .sub-title
                | {{ comment.post_title }}
            .media-right.delete-button(v-if='currentUserId == userId' @click='deleteComment(comment.post_id, comment.id)')
              .delete-button-icon
                i.fa-solid.fa-trash-can
          .is-mobile-sub-title
            | {{ comment.post_title }}
    .content(:class="{'is-active': isSelect == 'likes'}")
      .empty-message(v-if='likes.length === 0')
        i.fa-regular.fa-face-sad-tear
        .empty-message-text
          | いいねした記事はまだありません。
          p(v-if='currentUserId == userId')
            | 気になる記事にいいねしてみましょう！
      .posts(v-else)
        .post.media(v-for='like in likes' :key='like.id')
          .post-start
            .media-left.media-image
              a.post-image(:href='like.post_url', target='_blank', rel='noopener')
                img.image.is-64x64(:src='like.post_image_url', alt='post_image')
            .media-content
              .title.is-6
                a(:href='like.post_url', target='_blank', rel='noopener') {{ like.post_title }}
              .sub-title
                span
                  | {{ like.post_site_name }}
            .media-right.delete-button(v-if='currentUserId == userId' @click='deleteLike(like.post_id, like.id)')
              .delete-button-icon
                i.fa-solid.fa-heart-circle-xmark
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
