document.addEventListener('DOMContentLoaded', () => {
  const elements = document.querySelectorAll('#js-modal')
  for (const element of elements) {
    element.addEventListener('click', () => {
      const modal = element.getAttribute('data-modal')
      document.getElementById(modal).classList.toggle('is-active')
    })
  }
})
