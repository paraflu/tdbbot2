module.exports = (robot) ->

    tldr_print = (user_id) ->
      tldrs = res.brain.tldr[user_id]
      msg += "#{i} #{tldr}\n" for tldr, i in tldrs
      robot.logger.debug tldrs
      return msg

    robot.respond /tldr (.*)$/i, (msg) ->
      id = msg.user.id
      message = msg.match[1].trim()
      if message != "" 
        res.brain.tldr ?= []
        res.brain.tldr[id] ?= []
        res.brain.tldr[id].push(message)
      res.replay tldr_print(id)

    robot.respond /tldr (remove|clear) (\d+)/i, (msg) ->
      user_id = msg.from.id
      tldr_id = parseInt(msg.match[2],10)
        
      if res.brain.tldr[user_id]? && res.brain.tldr[user_id][tldr_id]? 
        res.brain.tldr[user_id].splice(tldr_id) 
        
