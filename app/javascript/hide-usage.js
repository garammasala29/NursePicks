document.addEventListener('DOMContentLoaded', () => {
  const elements = document.querySelectorAll('#js-hide-usage')
  const usage = document.querySelector('.usage')
  const message = document.querySelector('.hide-usage-message')
  for (const element of elements) {
    element.addEventListener('click', () => {
      usage.classList.toggle('is-hidden')
      message.classList.toggle('is-hidden')
      if (document.cookie === 'nursepicks_usage=hide') {
        document.cookie = 'nursepicks_usage='
      } else {
        document.cookie = 'nursepicks_usage=hide'
      }
    })
  }
})
