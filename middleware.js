import { NextResponse } from 'next/server'
import { pathToRegexp, match, parse, compile } from 'path-to-regexp'

export function middleware(req) {
  const pathname = req.nextUrl.pathname
  const params = pathToRegexp('/s/:code')
  const result = params.exec(pathname)
  console.log('hello')
  if (result?.[1]) {
    return NextResponse.redirect('http://api.9uv.top:8089/s/' + result?.[1])
  }
  return NextResponse.next()
}

export const config = {
  matcher: '/s/:code*',
}
