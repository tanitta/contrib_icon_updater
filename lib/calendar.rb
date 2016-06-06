require 'uri'
require 'net/https'
require 'nokogiri'
require 'date'

class Calendar
  def initialize(user_name)
    @user_name = user_name
    @contributions_hash = contributions_hash 
    @contributions_array = contributions_hash.sort
  end
  
  def contributions_hash
    uri = URI.parse("https://github.com/users/#{ @user_name }/contributions" )
    http = Net::HTTP.new(uri.host, uri.port)
    if uri.scheme == 'https'
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_PEER
    end
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)
    doc = Nokogiri::HTML(response.body)
    
    node_set = doc.search('rect[class="day"]') + doc.search('rect[class="day active"]')
    m = {}
    node_set.each do |node|
      date = DateTime.parse(node["data-date"])
      m[date] = node
    end
    m
  end
  
  def latest_activities
    latest_node["data-count"].to_i
  end
  
  def latest_color
    latest_node["fill"]
  end
  
  def activities_on(date)
    node_on(date)["data-count"].to_i
  end
  
  def color_on(date)
    node_on(date)["fill"]
  end
  
  def node_on(date)
    @contributions_hash[date]
  end
  
  def latest_node
    @contributions_array.last[1]
  end
  
  def latest_date
    @contributions_array.last[0]
  end
  
  def annual_activities
    @contributions_array.inject(0){|sum, elem| sum + elem[1]["data-count"].to_i}
  end
  
  def is_changed?
    cashed_params = File.read(File.expand_path("../../cache", __FILE__)).split
    cached_activities = cashed_params[0].to_i
    cached_date = DateTime.parse(cashed_params[1])
    
    latest_activities != cached_activities || latest_date!= cached_date
  end
  
  def cache_change
    File.open(File.expand_path("../../cache", __FILE__), "w") do |f|
      f.write ( latest_activities.to_s + " " + latest_date.to_s)
    end
  end
end

