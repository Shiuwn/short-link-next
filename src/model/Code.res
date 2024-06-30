type url_map = {
  code: string, // 映射码
  url: string, // url 地址
  exp: int, // 到期时间
}

let insert_code = async (url: string, code: string): bool => {
  let coll = DB.short_link_coll
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
let query_code_by_url = async (url: string) => {
  let coll = DB.short_link_coll
  let res =
    await coll
    ->DB.findOne({"url": url})
    ->Promise.catch(async exn => {
      Utils.log_err(exn)
      None
    })
  res
}
let query_url_by_code = async (code: string) => {
  let coll = DB.short_link_coll
  let res =
    await coll
    ->DB.findOne({"code": code})
    ->Promise.catch(async exn => {
      Utils.log_err(exn)
      None
    })
  res
}
let del_code_expired = async (): bool => {
  let now = Date.now()->Belt.Int.fromFloat / 1000
  let coll = DB.short_link_coll
  let res =
    await coll
    ->DB.delMany({"exp": {"$lt": now}})
    ->Promise.catch(async exn => {
      Utils.log_err(exn)
      None
    })

  switch res {
  | Some(_) => true
  | None => false
  }
}
