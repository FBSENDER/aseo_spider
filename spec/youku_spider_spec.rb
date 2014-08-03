# encoding: utf-8
require "spec_helper"
describe AseoSpider::Youku do 
  subject{AseoSpider::Youku.new}
  it "#get_videos" do 
    href = URI.encode('http://www.soku.com/search_video/q_高尔夫球_orderby_3')
    subject.get_videos(href)
  end
end
