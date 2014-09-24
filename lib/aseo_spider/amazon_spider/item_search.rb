module AseoSpider
  class AmazonSpider
    def item_search(keyword,search_index = "all")
      result = []
      (1..10).each do |page|
        asins = search_page(keyword,page,search_index)
        break if asins.empty?
        result = result + asins
      end
      result
    end

    private

    def search_page(keyword,item_page,search_index)
      loop do 
        begin
          #do api
          asins = []
          result = Amazon::Ecs.item_search(keyword,{:search_index => search_index, :item_page => item_page, :response_group => "ItemIds"})
          if !result.items.nil? && result.items.size > 0
            result.items.each do |item|
              asins << item.get("ASIN")
            end
          end
          return asins
        rescue Exception => ex
          puts ex
          next
        end
      end
    end
  end
end
