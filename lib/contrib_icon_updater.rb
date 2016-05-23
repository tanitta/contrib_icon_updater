require_relative './calendar'
require 'twitter'
require 'json'
class ContribIconUpdater
  attr_accessor :config

  def initialize
    @config = JSON::parse(File.read("config.json"))
    
    user_name = @config["github"]["source_account"]
    @calendar = Calendar.new(user_name)
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = @config["twitter"]["consumer_key"]
      config.consumer_secret     = @config["twitter"]["consumer_secret"]
      config.access_token        = @config["twitter"]["token"]
      config.access_token_secret = @config["twitter"]["token_secret"]
    end
  end

  def post_icon
    icon_name = "icon#{ contribution_level( @calendar.latest_color ).to_s }.png"
    icon = File.open("resource/" + icon_name, "r") 
    @client.update_profile_image(icon)
  end

  def contribution_level(color_code)
    colors = {
      "#eeeeee" => 0,
      "#d6e685" => 1,
      "#8cc665" => 2,
      "#44a340" => 3,
      "#1e6823" => 4,
    }
    colors[color_code]
  end
end
