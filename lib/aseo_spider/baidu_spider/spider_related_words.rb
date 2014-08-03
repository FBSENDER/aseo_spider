# encoding: utf-8
module AseoSpider
  class Baidu
    def get_related_keywords(word)
      engine = ::Query::Engine::Baidu
      result = engine.query(word)
      p result.related_keywords if $debug
      result.related_keywords
    end
  end
end
