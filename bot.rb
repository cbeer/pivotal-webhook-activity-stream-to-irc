require 'cinch'
require 'nokogiri'


bot = Cinch::Bot.new do
  configure do |c|
  	c.nick = "ff-pivotal2"
    c.server = "irc.freenode.org"
    c.channels = ["#duraspace-ff"]
  end

  on :message, "hello" do |m|
    m.reply "Hello, #{m.user.nick}"
  end
end

Thread.new {
  bot.start
}

# Pivotal Activity Web Hook documentation:
#   https://www.pivotaltracker.com/help/integrations?version=v3#activity_web_hook
post '/' do 
  doc = Nokogiri::XML(request.body.read)
  desc = doc.xpath('/activity/description').text
  url = doc.xpath('/activity/stories/story/url').text
  bot.channel_list.first.msg(desc + ' ' + url)
end

