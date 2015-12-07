# Description:
#   Example scripts for you to examine and try out.
#
# Notes:
#   They are commented out by default, because most of them are pretty silly and
#   wouldn't be useful and amusing enough for day to day huboting.
#   Uncomment the ones you want to try and experiment with.
#
#   These are from the scripting documentation: https://github.com/github/hubot/blob/master/docs/scripting.md

CronJob = require('cron').CronJob

module.exports = (robot) ->
  robot.respond /HELLO$/i, (res) ->
    res.send 'Hello!'
    
# 新チャネル通知
  robot.adapter.client?.on? 'raw_message', (msg) ->
    if msg?.type == 'channel_created'
      return if typeof robot?.send isnt 'function'
      robot.send {room: "general"}, "New channel <##{msg.channel.id}> created"
    
# 進捗どうですか
  new CronJob '0 25 17 * * 1-5', () =>
    robot.messageRoom "general", "進捗どうですか"
    robot.messageRoom "general", "http://41.media.tumblr.com/c4e10b790a638418561ce1281b39d01f/tumblr_mx4txxHqSw1qa8o34o1_400.jpg"
  , null, true, "Asia/Tokyo"

# どようび！
  new CronJob '0 30 17 * * 5', () =>
    robot.messageRoom "general", "どようび！"
    robot.messageRoom "general", "https://pbs.twimg.com/profile_images/1102063571/____.jpg"
  , null, true, "Asia/Tokyo"

# hubot起動終了通知
# http://shokai.org/blog/archives/10108
  cid = setInterval ->
    return if typeof robot?.send isnt 'function'
    robot.send {room: "general"}, "ガバリ"
    clearInterval cid
  , 1000

  ## 寝た時、通知してからexitする
  on_sigterm = ->
    robot.send {room: "general"}, 'スヤリ'
    setTimeout process.exit, 1000

  if process._events.SIGTERM?
    process._events.SIGTERM = on_sigterm
  else
    process.on 'SIGTERM', on_sigterm

# HUBOT_HEROKU_SLEEP_TIMEにshutdown
  sleepTime = (process.env.HUBOT_HEROKU_SLEEP_TIME or '').split(':').map (i) -> parseInt i, 10
  
  if sleepTime.length == 2 && isNaN(sleepTime[0]) == false && isNaN(sleepTime[1]) == false   
   hour = sleepTime[0].toString()
   minute = sleepTime[1].toString()
   new CronJob '0 ' + minute + ' ' + hour + ' * * *', () =>
     robot.send {room: "general"}, "Bye"
     setTimeout process.exit, 1000
   , null, true, "Asia/Tokyo"
