import { createApp } from 'vue'
import Post from './posts.vue'

document.addEventListener('DOMContentLoaded', () => {
  const selector = '#js-posts'
  const posts = document.querySelector(selector)
  if (posts) {
    const currentUserId = posts.getAttribute('data-current-user-id')
    createApp(Post,{
      currentUserId,
    }).mount(selector)
  }
})
