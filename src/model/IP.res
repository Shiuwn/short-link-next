let insert_ip = () => %todo
let delete_ip = () => %todo
let update_ip = async (ip: string, count: int) => {
  open DB
  let ip_coll = short_link_db->collection("ip")
  let res =
    await ip_coll
    ->update_one(
      ~filter={"ip": ip},
      ~update={
        "$set": {"count": count, "ip": ip, "exp": Utils.now() + Confing.time_limit_min * 60},
      },
      ~opt={"upsert": true},
    )
    ->Promise.catch(async exn => {
      Utils.log_err(exn)
      None
    })
  switch res {
  | Some(_) => true
  | None => false
  }
}
let query_ip = () => %todo
