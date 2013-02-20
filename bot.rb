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

post '/' do 
  doc = Nokogiri::XML(request.body.read)
  bot.channel_list.first.msg(doc.xpath('/activity/description').text)
end

