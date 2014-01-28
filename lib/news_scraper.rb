require 'nokogiri'
require 'open-uri'
require 'colorize'

class NewsScraper
  def initialize(url)
    @doc = Nokogiri::HTML(open(url))
    get_stories
  end

  def get_stories
    @stories = @doc.xpath(".//div[contains(concat(' ',@class,' '),' story ')]")
    get_titles
  end

  def get_titles
    #each "story" apparently has multiple titles
    @stories.each do |story|
      puts "----------------------------------------------------------------------------------\n"
      titles = story.xpath(".//span[contains(@class, 'titletext')]")
      titles.each do |title|
        link = title.xpath("..").first["href"]
        puts title.text + "\n"
        puts link.colorize(:blue)
      end
    end
  end
end

NewsScraper.new('http://news.google.com')