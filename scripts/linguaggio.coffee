module.exports = (robot) ->

  language = [ "baci tua madre con quella bocca?", "linguaggio daiiii",
    "ddddaaaaiiiii"]

  robot.hear /[crm]azzo|merda|stronzo/i, (res) ->
    res.send res.random language

  robot.hear /fossalta/i, (res) ->
    res.send "FOSSALTA L8"

  robot.hear /ciao/i, (res) ->
    res.reply "ciao"

  robot.listen(
    # Matcher
    (message) ->
      true

    # Callback
    (response) ->
      console.log(response);
  )
