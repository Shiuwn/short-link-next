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

let index_map: Map.t<int, string> = Map.make()
let base_char = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
let limit_count = 4
let base_len = base_char->String.length
let parse_index = (base: int) => {
  let len = base_char->String.length
  let b = ref(base)
  let code = ref("")
  for _ in 0 to limit_count - 1 {
    let index = mod(b.contents, len)
    code := code.contents ++ base_char->String.getUnsafe(index)
    b := b.contents / len
  }
  code.contents
}

let seek = (base: int): int => {
  let index = ref(-1)

  if base <= 0 || base >= base_len - 1 {
    -1
  } else {
    let break = ref(false)
    for i in base_len - 1 downto 0 {
      if !break.contents {
        if index.contents >= 0 {
          break.contents = true
        } else {
          index :=
            switch index_map->Map.get(i) {
            | Some(_) => -1
            | None => i
            }
        }
      }
    }

    index.contents
  }
}

let gen_code = () => {
  let base =
    (Math.random() *. base_len->Belt.Float.fromInt->Math.pow(~exp=limit_count->Belt.Float.fromInt))
      ->Belt.Int.fromFloat
  switch index_map->Map.get(base) {
  | Some(_) => {
      let index = seek(base)
      if index < 0 {
        ""
      } else {
        parse_index(index)
      }
    }
  | None => parse_index(base)
  }
}

let log_err = (err: 'a) => {
  Js.log(err)
}

let now = () => {
  Date.now()->Belt.Int.fromFloat / 1000
}
