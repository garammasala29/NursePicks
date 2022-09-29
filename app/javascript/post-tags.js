import Choices from 'choices.js'


document.addEventListener('DOMContentLoaded', () => {
  const elementMultipleSelect = document.getElementById(
    'js-post-tags'
  )
  if (elementMultipleSelect) {
    return new Choices(elementMultipleSelect, {
      allowHTML: true,
      delimiter: ',',
      removeItemButton: true,
      addItemText: (value) => {
        return `Enterを押すと<b>「${value}」</b>のタグが追加されます`;
      }
    })
  }
})
