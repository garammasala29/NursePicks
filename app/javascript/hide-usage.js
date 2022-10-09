document.addEventListener('DOMContentLoaded', () => {
  const elements = document.querySelectorAll('#js-hide-usage')
  for (const element of elements) {
    element.addEventListener('click', () => {
      const usage = document.querySelector('.usage')
      if (usage) {
        usage.style.display = 'none'
      } 
      // if (document.cookie === 'nursepicks_usage=hide') {
      //   document.cookie = "nursepicks_usage=''"
      //   const usage = element.getAttribute('data-usage')
      //   document.getElementById(usage).classList.toggle('is-active')
      // } else {
      //   document.cookie = 'nursepicks_usage=hide'
      //   const usage = element.getAttribute('data-usage')
      //   document.getElementById(usage).classList.toggle('is-active')
      // }
    })
  }
})
