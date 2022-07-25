<template lang="pug">
.page-body
  .like-button(v-if='isLiked' @click='deleteLike()')
    i.fa-solid.fa-heart.fa-2x.has-text-info
  .like-button(v-else @click='addLike()')
    i.fa-regular.fa-heart.fa-2x.has-text-info
  .has-text-centered
    |  {{ likeCount }}
</template>

<script>
import { useToast } from 'vue-toast-notification'
const $toast = useToast()

export default {
  name: 'LikeButton',
  props: {
    post: { type: Object, default: () => {} },
    currentUserId: { type: String, default: '' }
  },
  data() {
    return {
      isLiked: false,
      likeUsers: this.post.like_users,
      currentUser: parseInt(this.currentUserId),
      likeId: null,
      likeCount: 0
    }
  },
  created() {
    this.fetchLike()
  },
  methods: {
    fetchLike() {
      if (this.likeUsers.includes(this.currentUser)) {
        this.isLiked = true
      }
      this.likeId = this.findLikeId(this.currentUser)
      this.likeCount = this.likeUsers.length
    },
    findLikeId(userId) {
      if (!this.isLiked) {
        return null
      }
      return this.post.likes.find((like) => like.user_id === userId).id
    },
    addLike() {
      this.isLiked = true
      ++this.likeCount
      fetch(`/api/posts/${this.post.id}/likes`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'X-Requested-With': 'XMLHttpRequest',
          'X-CSRF-Token': document
            .querySelector('meta[name="csrf-token"]')
            ?.getAttribute('content')
        }
      })
        .then((response) => {
          return response.json()
        })
        .then((json) => {
          this.likeId = json.id
          $toast.success('いいねしました')
        })
    },
    deleteLike() {
      this.isLiked = false
      --this.likeCount
      fetch(`/api/posts/${this.post.id}/likes/${this.likeId}`, {
        method: 'DELETE',
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'X-Requested-With': 'XMLHttpRequest',
          'X-CSRF-Token': document
            .querySelector('meta[name="csrf-token"]')
            ?.getAttribute('content')
        }
      }).then(() => {
        this.likeId = null
        $toast.error('いいねを外しました')
      })
    }
  }
}
</script>
