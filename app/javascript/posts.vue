<template lang="pug">
section.container
  header.tabs.is-centered.is-medium
    ul
      li(:class="{'is-active': isOrder == 'popular'}")
        a(@click='sortPopular()')
          | 人気順
      li(:class="{'is-active': isOrder == 'newest'}")
        a(@click='sortNewest()')
          | 新着順
  .posts
    .post.media(v-for='(post, index) in posts' :key='post.id')
      .media-left
        i.fa-solid.fa-circle.rank-icon
          .rank-number
            | {{ index + 1 }}
      .media-left
        .post-image
          img.image.is-64x64(:src='post.image_url', alt='post_image')
      .media-content
        .title.is-5
          a(:href='post.url') {{ post.title }}
        .sub-title
          span.sub-title-text
            | {{ post.site_name }}
            | {{ post.date }}
      .media-right
        a.comment-link(:href='post.show_url')(:class="{'has-comment': post.comments_count != 0}")
          i.fa-regular.fa-message.fa-2x
          .post_comments_count
            | {{ post.comments_count }}
      .media-right
        likeButton(:post='post', :currentUserId='this.currentUserId')
      a.card-link(:href='post.show_url')
</template>

<script>
import LikeButton from 'like_button.vue'

export default {
  name: 'Posts',
  components: {
    likeButton: LikeButton
  },
  props: {
    currentUserId: { type: String, default: '' }
  },
  data() {
    return {
      posts: [],
      isOrder: 'popular'
    }
  },
  created() {
    this.getPosts()
  },
  methods: {
    getPosts() {
      fetch('/api/posts', {
        method: 'GET',
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'X-Requested-With': 'XMLHttpRequest'
        }
      })
        .then((response) => response.json())
        .then((json) => {
          this.posts = json.posts
          this.sortPopular()
        })
    },
    sortNewest() {
      this.posts = this.posts.sort((a, b) => {
        return new Date(a.created_at) > new Date(b.created_at) ? -1 : 1
      })
      this.isOrder = 'newest'
    },
    sortPopular() {
      this.posts = this.posts.sort((a, b) => {
        if (a.likes_count > b.likes_count) return -1
        else if (a.likes_count < b.likes_count) return 1
        else return new Date(a.created_at) < new Date(b.created_at) ? -1 : 1
      })
      this.isOrder = 'popular'
    }
  }
}
</script>
