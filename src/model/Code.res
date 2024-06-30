type url_map = {
  code: string, // 映射码
  url: string, // url 地址
  exp: int, // 到期时间
}

let insert_code = async (url: string, code: string): bool => {
  let coll = DB.short_link_db->DB.collection("url")
  let now = Date.now()
  let res =
    await coll
    ->DB.insertOne({
      url,
      code,
      exp: Date.now()->Belt.Int.fromFloat / 1000 + Config.time_limit_min * 60,
    })
    ->Promise.catch(exn => {
      exn->Utils.log_err
      Promise.resolve(None)
    })
  switch res {
  | Some(a) => true
  | None => false
  }
}
let query_code = () => %todo
let query_url = () => %todo
let del_code_expired = () => %todo
