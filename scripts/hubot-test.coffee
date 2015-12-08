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
    
# 進捗どうですか
  new CronJob '0 25 17 * * 1-5', () =>
    robot.send {room: "general"}, "進捗どうですか"
    robot.send {room: "general"}, "http://41.media.tumblr.com/c4e10b790a638418561ce1281b39d01f/tumblr_mx4txxHqSw1qa8o34o1_400.jpg"
  , null, true, "Asia/Tokyo"
