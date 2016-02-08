module.exports = (robot) ->
    url = "http://api.icndb.com/jokes/random"

    robot.hear /chuck/i, (resp) ->
       resp.http(url)
        .header('Accept', 'application/json')
        .get() (err, res, body) ->
          # error checking code here
          #console.log(body)
          data = JSON.parse body
          resp.send "#{data.value.joke}"