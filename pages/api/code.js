export default async function handler(req, res) {
  const url = req.body?.url || ''
  if (!url) {
    res.json({
      code: 2,
      msg: 'empty url'
    })
    return
  }
  const endPoint = 'http://api.9uv.top:8089/code'
  const result = await fetch(endPoint).then(res => res.json()).catch(console.error)
  if (!result) {
    res.json({
      code: 2,
      msg: 'server error'
    })
    return
  }
  res.json(result)
}
