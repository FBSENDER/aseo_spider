module Amazon
  class Ecs
    @@options = {
      :version => '2013-08-01',
      :service => 'AWSECommerceService',
      :response_group => 'Large',
      :country => 'cn'
    }
  end
end

require "aseo_spider/amazon_spider/add_keywords"
require "aseo_spider/amazon_spider/item_search"
require "aseo_spider/amazon_spider/item_lookup"
