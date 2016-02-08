module.exports = (robot) ->
    url = "http://api.icndb.com/jokes/random"

    robot.hear /\/chuck/i, (resp) ->
       console.log "start " + url
       resp.http(url)
        .header('Accept', 'application/json')
        .get() (err, res, body) ->
          try
            console.log(res);
            data = JSON.parse body
            console.log(data);
            resp.send "#{data.value.joke}"
          catch error
            console.log error
