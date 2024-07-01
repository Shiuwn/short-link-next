type client
type db
type collection
type insert_result = {insertedId: string}
type cursor
type delete_result = {
  acknowledged: bool,
  deletedCount: int,
}
type schema_id = {_id: string}
type update_result = {
  acknowledged: bool,
  matchedCount: bool,
  modifiedCount: int,
  upsertedCount: int,
  upsertedId: schema_id,
}
type update_option = {upsert: bool}
@module("mongodb") @new
external client: string => client = "MongoClient"

@send
external database: (client, string) => db = "db"

@send
external collection: (db, string) => collection = "collection"

@send
external insertOne: (collection, 'a) => promise<option<insert_result>> = "insertOne"
@send
external find: (collection, 'a) => cursor = "find"
@send
external next: cursor => promise<option<'a>> = "next"
@send
external hasNext: cursor => promise<bool> = "hasNext"
@send
external findOne: (collection, 'a) => promise<option<'b>> = "findOne"
@send
external delMany: (collection, 'a) => promise<option<delete_result>> = "deleteMany"
@send
external update_one: (
  collection,
  ~filter: 'a,
  ~update: 'b,
  ~opt: update_option=?,
) => promise<option<update_result>> = "update_one"

let uri = "mongodb+srv://bruce:yush241263Q@cluster0.irerjya.mongodb.net/?retryWrites=true&w=majority"

let short_link_client = client(uri)
let short_link_db = short_link_client->database("short_link")
let short_link_coll = short_link_db->collection("url")
