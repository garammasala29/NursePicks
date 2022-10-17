document.addEventListener('DOMContentLoaded', () => {
  const elements = document.querySelectorAll('#js-hide-usage')
  const usage = document.querySelector('.usage')
  const message = document.querySelector('.hide-usage-message')
  for (const element of elements) {
    element.addEventListener('click', () => {
      usage.classList.toggle('is-hidden')
      message.classList.toggle('is-hidden')
    })


    // if (document.cookie === 'nursepicks_usage=hide') {
    //   element.addEventListener('click', () => {
    //     document.cookie = "nursepicks_usage=''"
    //     message.style.display = 'none'
    //     usage.style.display = 'block'
    //   })
    // } else {
    //   element.addEventListener('click', () => {
    //     document.cookie = 'nursepicks_usage=hide'
    //     usage.style.display = 'none'
    //     message.style.display = 'block'
    //   })
    // }
  }
})
