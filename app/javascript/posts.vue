<template lang="pug">
section.container
  .search-post.field.is-horizontal
    .field-label.is-normal
      .label
        | 記事の検索
    .field-body
      .field
        .control
          input(v-model.trim='keyword', placeholder='タイトル、サイト元、タグで記事を検索', class='input', type='text')
  header.tabs.post-tabs.is-centered.is-medium
    ul
      li(:class="{'is-active': isOrder == 'popular'}")
        a(@click='sortPopular()')
          | 人気順
      li(:class="{'is-active': isOrder == 'newest'}")
        a(@click='sortNewest()')
          | 新着順
  .posts
    .post.media(v-for='(post, index) in filterPosts' :key='post.id')
      .media-left
        .rank-crown(v-if='index < 3')
          i.fa-solid.fa-crown.rank-icon(:class="['is-rank-' + index]")
            .rank-number
              | {{ index + 1 }}
        .rank-circle(v-else)
          i.fa-regular.fa-circle.rank-icon(:class="['is-rank-' + index]")
            .rank-number
              | {{ index + 1 }}
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
          i.fa-solid.fa-message.fa-2x
          .post_comments_count
            | {{ post.comments_count }}
      .media-right
        likeButton(:post='post', :currentUserId='this.currentUserId')
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
      keyword: '',
      isOrder: 'popular'
    }
  },
  created() {
    this.getPosts()
  },
  computed: {
    // prettier-ignore
    filterPosts() {
      return this.posts.filter((post) => {
        if (post.title.toLowerCase().includes(this.keyword.toLowerCase())) return true
        if (post.site_name.toLowerCase().includes(this.keyword.toLowerCase())) return true
        for (const tag of post.tags) {
          if (tag.name.toLowerCase().includes(this.keyword.toLowerCase())) return true
        }
        return false
      })
    }
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
