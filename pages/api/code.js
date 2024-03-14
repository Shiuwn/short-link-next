export default async function handler(req, res) {

  if (req.method !== 'POST') {
    res.status(405).json({ code: 2, msg: 'Only POST requests are allowed' });
    return
  }
  if (!req.body) {
    res.json({
      code: 2,
      msg: 'empty url'
    })
    return
  }
  const endPoint = 'http://api.9uv.top:8089/code'
  const result = await fetch(endPoint, {
    method: 'POST',
    body: req.body
  }).then(res => res.json()).catch(console.error)
  if (!result) {
    res.json({
      code: 2,
      msg: 'server error'
    })
    return
  }
  res.json(result)
}
