fs = require('fs')

STK_JARVIS='BQADBAADPQQAAv1q5gNSipU1gQABY-UC';
STK_COC = 'BQADAQAD6AEAAsGZigABPCp4PLTfUA8C';

sendPhoto = (robot, res, fname) ->
  robot.emit 'telegram:invoke', 'sendPhoto', { chat_id: res.message.room, photo: fs.createReadStream(fname) }, (error, response) ->
      console.log(error);
      console.log(response);

sendStiker = (robot, res, id) ->
  robot.emit 'telegram:invoke', 'sendSticker', { chat_id: res.message.room, sticker_id: id }, (error, response) ->
      console.log(error);
      console.log(response);

module.exports = (robot) ->

  language = [ "baci tua madre con quella bocca?", "linguaggio daiiii",
    "ddddaaaaiiiii"]

  robot.hear /[crm]azzo|merda|stronzo/i, (res) ->
    res.reply res.random language

  robot.hear /coc/i, (res) ->
    sendStiker robot, res, STK_COC

  robot.hear /fossalta/i, (res) ->
    sendPhoto robot, res, __dirname + "/images/fossaltal8.jpg"
    #res.send "FOSSALTA L8"




  robot.hear /ciao/i, (res) ->
    robot.logger.debug "res: " + res
    res.reply "ciao"

  robot.listen(
    # Matcher
    (message) ->
      true

    # Callback
    (response) ->
      #console.log(response);
  )
