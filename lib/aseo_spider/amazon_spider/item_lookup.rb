module AseoSpider
  class Amazon 
    def item_lookup(asin,access_key,secret_key,associate_tag)
      result = Amazon::Ecs.item_lookup(asin,{:AWS_access_key_id => access_key,:AWS_secret_key => secret_key,:associate_tag => associate_tag})
      if result.has_error?
        raise result.error
      end
      return nil if result.first_item.nil?
      item = result.first_item
      hash_result = {}
      hash_result[:title] = item.get("ItemAttributes/Title")
      hash_result[:features] = Amazon::Element.get_array(item,"ItemAttributes/Feature")
      hash_result[:descriptions] = item.get("EditorialReviews/EditorialReview/Content")
      hash_result[:category] = []
      node_path = "BrowseNodes/BrowseNode"
      loop do
        node = item.get(node_path)
        break if node.nil?
        category = {:id => item.get("#{node_path}\/BrowseNodeId"),:name => item.get("#{node_path}\/Name")}
        category[:is_category_root] = item.get("#{node_path}\/IsCategoryRoot") unless item.get("#{node_path}\/IsCategoryRoot").nil?
        hash_result[:category] << category
        node_path += '/Ancestors/BrowseNode'
      end
      hash_result
    end
  end
end
