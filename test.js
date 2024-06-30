const { MongoClient } = require('mongodb')
const uri = 'mongodb+srv://bruce:yush241263Q@cluster0.irerjya.mongodb.net/?retryWrites=true&w=majority'
const client = new MongoClient(uri)
const run = async () => {
  const urlCol = client.db('short_link').collection('url')
  const query = { title: 'Back to the Future' };
  const cursor =  urlCol.find(query);
  for await(const c of cursor ) {

  }
  console.log(movie)
}

run()
