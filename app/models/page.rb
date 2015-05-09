class Page
  def self.search(query)
    client = Elasticsearch::Client.new ModtalkWebsite::Config.search
    results = client.search index: ModtalkWebsite::Config.search[:index], body: {
      query: {
        match: {
          title: {
            query: query,
            analyzer: 'autocomplete'
          }
        }
      }
    }

    results['hits']['hits'].map { |e|
      source = e['_source']
      {
        type: e['_type'],
        title: source['title'],
        description: source['description'],
        url: "//modtalk.devvm/#{e['url']}",
        id: e['_id'],
        score: e['_score'],
        raw: e
      }
    }
  end
end