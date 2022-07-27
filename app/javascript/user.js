import { createApp } from 'vue'
import User from './user.vue'

document.addEventListener('DOMContentLoaded', () => {
  const selector = '#js-user-posts'
  const user = document.querySelector(selector)
  if (user) {
    const userId = user.getAttribute('data-user-id')
    const currentUserId = user.getAttribute('data-current-user-id')
    createApp(User, {
      currentUserId,
      userId
    }).mount(selector)
  }
})
