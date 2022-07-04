document.addEventListener('DOMContentLoaded', () => {
  const elements = document.querySelectorAll('#js-modal')
  for (const element of elements) {
    element.addEventListener('click', () => {
      const modal = document.getElementById('page-modal')
      modal.classList.toggle('is-active')
    })
  }
})
