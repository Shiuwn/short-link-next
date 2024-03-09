type env
type process
@val external process: process = "process"
@get external getEnv: process => env = "env"
@get external getURL: env => string = "NEXT_PUBLIC_URL"

let default = () => {
  open Fetch
  let baseURL = ""
  let shortURLBase = process->getEnv->getURL
  let (url, setUrl) = React.useState(_ => "")
  let (shortUrl, setShortUrl) = React.useState(_ => "")
  let (copyText, setCopyText) = React.useState(_ => "Copy")
  let (loading, setLoading) = React.useState(_ => false)
  let onInput = (e: ReactEvent.Form.t) => {
    let value = ReactEvent.Form.currentTarget(e)["value"]
    setUrl(_ => value)
  }

  let copy = _ => {
    Utils.copy(shortUrl)
    setCopyText(_ => "Success")
    let _ = setTimeout(() => {
      setCopyText(_ => "Copy")
    }, 1000)
  }

  let shorten = async _ => {
    if url != "" {
      setLoading(_ => true)
      try {
        let res = await fetch(
          baseURL ++ "/code",
          {
            method: #POST,
            body: {"url": url}->Js.Json.stringifyAny->Belt.Option.getExn->Body.string,
          },
        )
        // ->Promise.catch(_=>{
        //   Js.log("fetch error")
        // })
        let data = await res->Response.json
        switch data {
        | Object(data) => {
            let d = Js.Dict.get(data, "data")
            switch d {
            | Some(d) =>
              switch d {
              | String(d) => setShortUrl(_ => shortURLBase ++ "/s/" ++ d)
              | _ => ()
              }

            | _ => ()
            }
          }
        | _ => ()
        }
      } catch {
      | _ => Js.log("api error")
      }

      setLoading(_ => false)
    }
  }
  let handleClick = _ => {
    let _ = shorten()
  }

  <div
    className="rounded-lg my-20 mx-auto border bg-card text-card-foreground shadow-sm w-full max-w-lg">
    <div className="flex flex-col space-y-1.5 p-6">
      <h3 className="text-2xl font-semibold whitespace-nowrap leading-none tracking-tight">
        {React.string("Shorten your link")}
      </h3>
      <p className="text-sm text-muted-foreground">
        {React.string("Paste a link to shorten it and share it with others.")}
      </p>
    </div>
    <div className="p-6 space-y-4">
      <div className="flex flex-row items-center space-x-4">
        <label
          className="text-sm font-medium leading-none peer-disabled:cursor-not-allowed peer-disabled:opacity-70 sr-only">
          {React.string("Link")}
        </label>
        <input
          className="flex h-10 rounded-md border border-input bg-background px-3 py-2 text-sm ring-offset-background file:border-0 file:bg-transparent file:text-sm file:font-medium placeholder:text-muted-foreground focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:cursor-not-allowed disabled:opacity-50 w-[300px] flex-1"
          id="link"
          placeholder="Enter a URL"
          value={url}
          onInput={onInput}
        />
        <button
          className="inline-flex items-center justify-center whitespace-nowrap rounded-md text-sm font-medium ring-offset-background transition-colors focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:pointer-events-none disabled:opacity-50 bg-primary text-primary-foreground hover:opacity-90 h-10 px-4 py-2"
          disabled={loading}
          onClick={handleClick}>
          {React.string("Shorten")}
        </button>
      </div>
      <div className="flex flex-row items-center space-x-2">
        <input
          className="flex h-10 rounded-md border border-input bg-background px-3 py-2 text-sm ring-offset-background file:border-0 file:bg-transparent file:text-sm file:font-medium placeholder:text-muted-foreground focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:cursor-not-allowed disabled:opacity-50 w-[300px] flex-1"
          id="shortened"
          placeholder="shorten link"
          readOnly=true
          value={shortUrl}
        />
        <button
          className="inline-flex items-center justify-center whitespace-nowrap rounded-md text-sm font-medium ring-offset-background transition-colors focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:pointer-events-none disabled:opacity-50 bg-primary text-primary-foreground hover:opacity-90 h-10 px-4 py-2"
          onClick={copy}>
          {React.string(copyText)}
        </button>
      </div>
    </div>
  </div>
}
