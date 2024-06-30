type client
type db
type collection
type insert_result = {
  insertedId: string
}
@module("mongodb") @new
external client: string => client = "MongoClient"

@send
external database: (client, string) => db = "db"

@send
external collection: (db, string) => collection = "collection"

@send
external insertOne: (collection, 'a) => promise<option<insert_result>> = "insertOne"

let uri = "mongodb+srv://bruce:yush241263Q@cluster0.irerjya.mongodb.net/?retryWrites=true&w=majority"

let short_link_client = client(uri)
let short_link_db = short_link_client->database("short_link")
