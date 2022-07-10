<template lang="pug">
article.section
  .media(v-for='(post, index) in posts')
    .media-left
      i.fa-solid.fa-circle.rank-icon
        .rank-number
          | {{ index + 1 }}
    .media-left
      img.image.is-64x64(:src='post.image_url')
    .media-content
      .title.is-5
        a(:href='post.url') {{ post.title }}
      .sub-title
        a.comment-link(:href='post.show_url')
          i.fa-solid.fa-message
            | {{ post.comments_count }}
        | {{ post.site_name }}
        | {{ post.date }}
      //- .media-right
      //-   - if current_user
      //-     - if current_user.liked?(post)
      //-       = link_to post_likes_path(post), method: :delete
      //-         i.fa-solid.fa-heart.fa-2x.has-text-info
      //-     - else
      //-       = link_to post_likes_path(post), method: :post
      //-         i.fa-regular.fa-heart.fa-2x.has-text-info
      //-   - else
      //-     i.fa-solid.fa-heart.fa-2x
      //-   p.has-text-centered
      //-     = post.likes.count
</template>

<script>
export default {
  name: 'Posts',
  data: function () {
    return {
      posts: []
    }
  },
  computed: {
    url() {
      return `/api/posts`
    }
  },
  created() {
    this.getPosts()
  },
  methods: {
    getPosts() {
      fetch(this.url, {
        method: 'GET',
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'X-Requested-With': 'XMLHttpRequest'
        }
      })
        .then((response) => response.json())
        .then((json) => {
          this.posts = json.posts
        })
    }
  }
}
</script>
