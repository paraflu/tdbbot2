module.exports = (robot) ->
    url = "http://api.icndb.com/jokes/random"

    robot.hear /\/chuck/i, (resp) ->
       resp.http(url)
        .header('Accept', 'application/json')
        .get() (err, res, body) ->
          # error checking code here
          #console.log(body)
          try
            data = JSON.parse body
            console.log(resp);
            console.log(data);
            resp.send "#{data.value.joke}"
          catch error
            console.log error
