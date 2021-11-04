#!/usr/bin/env node

//  ┏━┓┏━┓┏━╸┏┓╻   ╺━┓┏━┓┏━┓┏┳┓
//  ┃ ┃┣━┛┣╸ ┃┗┫   ┏━┛┃ ┃┃ ┃┃┃┃
//  ┗━┛╹  ┗━╸╹ ╹   ┗━╸┗━┛┗━┛╹ ╹

const { spawnSync } = require('child_process')

const { argv, exit } = process

const roomRe = /j\/(\d+)/
const passwordRe = /pwd=([\w\d]+)(&|$)/

const getFirstMatchGroup = (str, re) => (str.match(re) ?? []).slice(1)[0]

const [url] = argv.slice(2)
const roomId = getFirstMatchGroup(url, roomRe)
const password = getFirstMatchGroup(url, passwordRe)

if (roomId == null) {
  spawnSync('notify-send', ['open-zoom', 'Unable to parse URL'])
  exit(1)
}

let path = 'zoommtg://zoom.us/join?confno=' + roomId
if (password != null) {
  path += '&pwd=' + password
}

spawnSync('mimeo', [path])
