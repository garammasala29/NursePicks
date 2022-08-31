document.addEventListener('DOMContentLoaded', () => {
  const element = document.querySelector('#js-menu')
  element.addEventListener('click', () => {
    const menu = document.querySelector('#nav-menu')
    element.classList.toggle('is-active')
    menu.classList.toggle('is-active')
  })
})
