module AseoSpider
  class Youku
    def get_videos(href)
      page_no = 1
      loop do 
        page = Nokogiri::HTML Httparty.get("#{href}_page_#{page_no}")
        break if page.css("div.sk_null").size > 0 
        page.css("div.v").each do |v|
          img = v.at("div.v-thumb > img")
          link = v.at("div.v-link > a")
          begin
            img_href = img["src"]
            name = link["title"]
            href = link["href"]
            src = link["href"].sub(/http:\/\/v.youku.com\/v_show\/id_/,'http://player.youku.com/player.php/sid').sub(/\.html/,'/v.swf')
            max_0 = Random.new.rand(100)
            like_sum = Random.new.rand(max_0 + 1)
            pv_sum = like_sum * 10 + max_0
          rescue Exception => ex
            puts ex
            next
          end
        end
        puts "page : #{page_no} done" if $debug
        page_no += 1
      end
  end
end
