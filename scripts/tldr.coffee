tldr_print = (user_id, tldrs) ->
      msg = ""
      msg += "#{i} #{tldr}\n" for tldr, i in tldrs
      return msg


module.exports = (robot) ->

    robot.respond /tldr (.*)$/i, (msg) ->
      user_id = msg.envelope.user.id
      message = msg.match[1].trim()
      if message != "" 
        robot.brain.tldr ?= []
        robot.brain.tldr[user_id] ?= []
        robot.brain.tldr[user_id].push(message)
      response = tldr_print user_id, robot.brain.tldr[user_id]  
      robot.logger.debug response
      msg.replay response

    robot.respond /tldr (remove|clear) (\d+)/i, (msg) ->
      user_id = msg.envelope.user.id
      tldr_id = parseInt(msg.match[2],10)
        
      if robot.brain.tldr[user_id]? && robot.brain.tldr[user_id][tldr_id]? 
        robot.brain.tldr[user_id].splice(tldr_id)
        msg.replay tldr_print user_id, robot.brain.tldr[user_id]
        
