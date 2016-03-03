module.exports = (robot) ->

    tldr_print = (user_id) ->
      tldrs = res.brain.tldr[user_id]
      msg += "#{i} #{tldr}\n" for tldr, i in tldrs
      return msg

    robot.respond /tldr (.*)$/, (msg) ->
      message = msg.match[1].trim()
      robot.logger.debug msg
      id = msg.user.id
      res.brain.tldr ?= []
      res.brain.tldr[id] ?= []
      res.brain.tldr[id].push(message)
      res.replay tldr_print(id)

    robot.respond /tldr (remove|clear) (\d+)/, (msg) ->
        user_id = msg.from.id
        tldr_id = parseInt(msg.match[2],10)
        res.brain.tldr[user_id].splice(tldr_id) if res.brain.tldr[user_id]? && res.brain.tldr[user_id][tldr_id]?