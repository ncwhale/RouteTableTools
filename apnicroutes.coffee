http = require 'http'

fetch_ip_data = (country = 'CN', callback) ->
  return_array = []
  fetched_data = ''
  country = country.toLowerCase()
  country_regex = new RegExp "apnic\\|#{country}\\|ipv4\\|[0-9\\.]+\\|[0-9]+\\|[0-9]+\\|allocated",'gi'
  request = http.request 'http://ftp.apnic.net/apnic/stats/apnic/delegated-apnic-latest', (res) ->
  #request = http.request 'http://192.168.10.1/apnic.list', (res) ->
    #res.setEncoding 'utf8'
    res.on 'data', (chunk)->
      fetched_data += chunk

    res.on 'end', ()->
      for line in fetched_data.match country_regex 
        params = line.split '|'
        return_array.push [ params[3], 32 - (Math.log params[4]) / Math.LN2 ]

      (setImmediate ()->callback return_array,null ) if callback?

  request.on 'error', (err)->
    (setImmediate ()->callback return_array,err ) if callback?

  request.end()

fetch_ip_data process.argv[2] ? 'cn', (ips, err)->
  console.log err if err?
  pref_count = 1024
  for [ip, cord] in ips
    console.log "sudo ip rule add to #{ip}/#{cord} pref #{++pref_count} table #{ process.argv[3] ? 9 }"
