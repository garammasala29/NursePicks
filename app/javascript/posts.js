import { createApp } from 'vue'
import Post from './posts.vue'

document.addEventListener('DOMContentLoaded', () => {
  const selector = '#js-posts'
  const posts = document.querySelector(selector)
  if (posts) {
    createApp(Post).mount(selector)
  }
})
