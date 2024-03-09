type document
@send external createElement: (document, string) => Dom.element = "createElement"
@val external doc: document = "document"
@set external setTextareaValue: (Dom.element, string) => unit = "value"
@send external textareaSelect: Dom.element => unit = "select"
@send external execCommand: (document, string) => unit = "execCommand"
@get external getBody: document => Dom.element = "body"
@send external appendChild: (Dom.element, Dom.element) => unit = "appendChild"
@send external removeElement: Dom.element => unit = "remove"
let copy = (text: string) => {
  let el = doc->createElement("textarea")
  el->setTextareaValue(text)
  let body = getBody(doc)
  body->appendChild(el)
  textareaSelect(el)
  doc->execCommand("copy")
  removeElement(el)
}
