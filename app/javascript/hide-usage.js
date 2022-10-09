document.addEventListener('DOMContentLoaded', () => {
  const elements = document.querySelectorAll('#js-hide-usage')
  const usage = document.querySelector('.usage')
  const message = document.querySelector('.hide-usage-message')
  for (const element of elements) {
    if (usage.style.display === 'block') {
      element.addEventListener('click', () => {
        usage.style.display = 'none'
        message.style.display = 'block'
      })
    } else {
      element.addEventListener('click', () => {
        usage.style.display = 'block'
        message.style.display = 'none'
      })
    }
  }
})

// if (document.cookie === 'nursepicks_usage=hide') {
//   document.cookie = "nursepicks_usage=''"
//   const usage = element.getAttribute('data-usage')
//   document.getElementById(usage).classList.toggle('is-active')
// } else {
//   document.cookie = 'nursepicks_usage=hide'
//   const usage = element.getAttribute('data-usage')
//   document.getElementById(usage).classList.toggle('is-active')
// }
