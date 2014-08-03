# encoding: utf-8
require "spec_helper"
describe AseoSpider do 
  it "#query" do 
    AseoSpider::Baidu.new.get_related_keywords('酒店预订')
  end
end
