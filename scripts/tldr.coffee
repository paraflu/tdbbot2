# Description:
#   "TLDR hanlder"
#
# Dependencies:
#
#
# Configuration:
#   None
#
# Commands:
#   hubot tldr <input>
#   hubot tldr clear|remove id
#   hubot tldr
#
# Author:
#   Andrea Forlin <andrea.forlin@gmail.com>

tldr_print = (user_id, tldrs) ->
      i = 0;
      msg = ""
      for tldr in tldrs
        i++
        msg += "#{i}) #{tldr}\n"
      return msg


module.exports = (robot) ->

    robot.brain.on 'loaded', ->
      robot.brain.data.tldr ?= []

    robot.respond /\stldr$/i, (msg) ->
      msg.reply tldr_print user_id, robot.brain.data.tldr[user_id]

    robot.respond /tldr\s+(?!remove|clear)(.*)$/i, (msg) ->
      try
        user_id = msg.envelope.user.id
        message = msg.match[1].trim()
        robot.logger.debug message
        if message != ""
          robot.brain.data.tldr[user_id] ?= []
          robot.brain.data.tldr[user_id].push(message)
        response = tldr_print user_id, robot.brain.data.tldr[user_id]
        robot.logger.debug response
        msg.reply "#{response}"
      catch error
        msg.reply "Errore in inserimento di #{message}: #{error}"

    robot.respond /tldr (remove|clear) (\d+)/i, (msg) ->
      try
        robot.logger.debug "remove item"
        user_id = msg.envelope.user.id

        tldr_id = parseInt(msg.match[2],10)

        robot.logger.debug robot.brain.data.tldr[user_id]

        if robot.brain.data.tldr[user_id] && robot.brain.data.tldr[user_id][tldr_id]
          robot.brain.data.tldr[user_id].splice(tldr_id-1)
          msg.reply tldr_print user_id, robot.brain.data.tldr[user_id]
          robot.logger.debug robot.brain.data.tldr[user_id]
      catch error
        msg.reply "Errore la cancellazione di #{tldr_id}: #{error}"
