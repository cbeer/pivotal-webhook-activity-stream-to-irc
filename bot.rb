require 'cinch'
require 'nokogiri'


bot = Cinch::Bot.new do
  configure do |c|
  	c.nick = "ff-pivotal"
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
  
  # /activity/stories/story/url returns a URL of the form http://www.pivotaltracker.com/services/v3/projects/<project_id>/stories/<story_id> which isn't browser-actionable (access denied)
  #url = doc.xpath('/activity/stories/story/url').text

  story_id = doc.xpath('/activity/stories/story/id').text
  bot.channel_list.first.msg(desc + ' https://www.pivotaltracker.com/story/show/' + story_id)
end

