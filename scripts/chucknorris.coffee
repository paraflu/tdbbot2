Entities = require('html-entities').XmlEntities

module.exports = (robot) ->
    url = "http://api.icndb.com/jokes/random"

    robot.hear /chuck/i, (resp) ->
       entities = new Entities();
       resp.http(url)
        .header('Accept', 'application/json')
        .get() (err, res, body) ->
          try
            data = JSON.parse body
            resp.send "#{(entities.decode(data.value.joke)}"
          catch error
            console.log error
