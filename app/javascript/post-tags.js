import Choices from 'choices.js'

document.addEventListener('DOMContentLoaded', () => {
  const element = document.getElementById('js-post-tags')
  if (element) {
    return new Choices(element, {
      allowHTML: true,
      delimiter: ',',
      removeItemButton: true,
      addItemText: (value) => {
        return `Enterを押すと<b>「${value}」</b>のタグが追加されます`
      }
    })
  }
})
