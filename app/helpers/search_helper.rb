include UrlHelper

module SearchHelper
  def self.relevant_issues(client, query)
    results = client.search index: ModtalkWebsite::Config.search[:index], body: {
      query: {
        bool: {
          must: [
            {
              match: {
                private: 'false'
              }
            },
            {
              match: {
                type: 'issue'
              }
            },
            {
              match: {
                subject: query
              }
            }
          ]
        }
      }
    }

    results['hits']['hits'].map { |e|
      source = e['_source']
      {
        type: 'issue',
        title: source['subject'],
        url: issue_path(e['_id']),
        description: source['description'],
        id: e['_id'],
        score: e['_score']
      }
    }
  end
end
