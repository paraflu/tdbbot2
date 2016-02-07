module.exports = (robot) ->

  language = [ "baci tua madre con quella bocca?", "linguaggio daiiii",
    "ddddaaaaiiiii"]

  robot.hear /[crm]azzo|merda|stronzo/i, (res) ->
    res.send res.random language

  robot.hear /fossalta/, (res) ->
    res.send "FOSSALTA L8"
