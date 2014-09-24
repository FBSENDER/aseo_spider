module AseoSpider
  class AmazonSpider
    def item_lookup(asin,access_key,secret_key,associate_tag)
      item = nil
      loop do 
        begin
          result = Amazon::Ecs.item_lookup(asin,{:AWS_access_key_id => access_key,:AWS_secret_key => secret_key,:associate_tag => associate_tag})
          item = result.first_item
          break
        rescue Exception => ex
          puts ex
        end
      end
      hash_result = {}
      hash_result[:title] = item.get("ItemAttributes/Title")
      hash_result[:img_1] = item.get("SmallImage/URL")
      hash_result[:img_2] = item.get("MediumImage/URL")
      hash_result[:img_3] = item.get("LargeImage/URL")
      hash_result[:url] = item.get("DetailPageURL")
      hash_result[:brand] = item.get("ItemAttributes/Brand")
      hash_result[:features] = Amazon::Element.get_array(item,"ItemAttributes/Feature")
      hash_result[:descriptions] = item.get("EditorialReviews/EditorialReview/Content")
      hash_result[:category_id] = item.get("BrowseNodes/BrowseNode/BrowseNodeId")
      hash_result[:category_name] = item.get("BrowseNodes/BrowseNode/Name")
      hash_result[:price] =/[\d\/.,]+/.match(item.get("ItemAttributes/ListPrice/FormattedPrice")).to_s.sub(',','').to_f
      hash_result[:price] = /[\d\/.,]+/.match(item.get("OfferSummary/LowestNewPrice/FormattedPrice")).to_s.sub(',','').to_f if hash_result[:price] == 0
      hash_result

    end
  end
end
