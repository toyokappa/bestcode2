export default class ToggleFormField {
  $root: any

  constructor($root) {
    this.$root = $root
    this.bind()
  }

  add(e) {
    const target = e.currentTarget
    const regexp = new RegExp(target.dataset.index, "g")
    const newIndex = new Date().getTime() // 一意のIndexを作成するためunixtimeを利用
    const newFieldString = target.dataset.html.replace(regexp, newIndex)

    // string型のHTMLをNodeに変換
    const tmpTag = document.createElement("div")
    tmpTag.innerHTML = newFieldString
    const newFieldElement = tmpTag.firstElementChild

    if (newFieldElement) {
      // 新規追加したFieldがわかるようにタグ付け
      newFieldElement.classList.add("new-toggle-field")
      target.parentNode.insertBefore(tmpTag.firstChild, target)
    }
  }

  remove(e) {
    const targetField = e.currentTarget.closest(".remove-target")

    if (targetField.classList.contains("new-toggle-field")) {
      // 新規追加したFieldは削除する
      targetField.remove()
      return
    }

    if (targetField.querySelector("._destroy")) {
      targetField.querySelector("._destroy").value = true
    }
    targetField.style.display = "none"
  }

  bind() {
    this.$root.on("click", ".add-form-field", this.add)
    this.$root.on("click", ".remove-form-field", this.remove)
  }
}

document.addEventListener("turbolinks:load", () => {
  const $root = $(".toggle-form-field")
  if ($root[0]) new ToggleFormField($root)
})