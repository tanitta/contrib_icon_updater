require_relative './calendar'
require 'twitter'
require 'json'
class ContribIconUpdater
  def initialize
    @config = JSON::parse(File.read(File.expand_path("../../config.json", __FILE__)))
    user_name = @config["github"]["source_account"]
    @calendar = Calendar.new(user_name)
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = @config["twitter"]["consumer_key"]
      config.consumer_secret     = @config["twitter"]["consumer_secret"]
      config.access_token        = @config["twitter"]["token"]
      config.access_token_secret = @config["twitter"]["token_secret"]
    end
  end
  
  def update
    if @calendar.is_changed?
      change_icon if @config["twitter"]["enable_to_change_icon"]
      change_name if @config["twitter"]["enable_to_change_name"]
      @calendar.cache_change
    end
  end
  
  private
  def change_name
    changed_name = @config["twitter"]["user_name"] + " Lv." + @calendar.annual_activities.to_s
    @client.update_profile(name: changed_name)
  end
    
  def change_icon
    icon_name = "icon#{ contribution_level( @calendar.latest_color ).to_s }.png"
    icon = File.open(File.expand_path("../../resource/" + icon_name, __FILE__), "r") 
    
    @client.update_profile_image(icon)
  end

  def contribution_level(color_code)
    {
      "#eeeeee" => 0,
      "#d6e685" => 1,
      "#8cc665" => 2,
      "#44a340" => 3,
      "#1e6823" => 4,
    }[color_code]
  end
end
