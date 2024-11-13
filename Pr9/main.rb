require 'rss'
require 'open-uri'
require 'json'
require 'uri'

class RSSUpdater
  def initialize(feed_urls, output_file = 'rss_feed.json')
    @feed_urls = feed_urls
    @output_file = output_file
  end

  def update_feeds
    feeds_data = @feed_urls.map do |url|
      fetch_feed(url)
    end.compact

    save_to_json(feeds_data)
  end

  private

  def fetch_feed(url)
    URI.open(url) do |rss|
      feed = RSS::Parser.parse(rss)
      {
        title: feed.channel.title,
        link: feed.channel.link,
        description: feed.channel.description,
        items: feed.items.map { |item| { title: item.title, link: item.link, date: item.pubDate } }
      }
    end
  rescue StandardError => e
    puts "Помилка під час завантаження каналу #{url}: #{e.message}"
    nil
  end

  def save_to_json(data)
    File.open(@output_file, 'w') do |file|
      file.write(JSON.pretty_generate(data))
    end
    puts "Дані збережено в #{@output_file}"
  end
end

feed_urls = [
  'https://news.ycombinator.com/rss',
  'https://rss.nytimes.com/services/xml/rss/nyt/HomePage.xml'
]

rss_updater = RSSUpdater.new(feed_urls)
rss_updater.update_feeds
