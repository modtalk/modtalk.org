#!/usr/bin/env ruby
$LOAD_PATH.unshift('/rails-app/lib')
require 'elasticsearch'

client = Elasticsearch::Client.new host: 'elasticsearch', log: true

index = 'modtalk'
if client.indices.exists index: index
  client.indices.delete index: index
end
client.indices.create index: index, body: {
  settings: {
    analysis: {
      filter: {
        autocomplete_filter: {
          type: 'edge_ngram',
          min_gram: 1,
          max_gram: 20
        }
      },
      analyzer: {
        autocomplete: {
          type: 'custom',
          tokenizer: 'standard',
          filter: %w(lowercase autocomplete_filter)
        }
      }
    }
  }
}

client.indices.put_mapping index: index, type: 'my_type', body: {
  my_type: {
    properties: {
      description: {
        type: 'string',
        analyzer: 'autocomplete'
      }
    }
  }
}

client.index index: index, type: 'page', id: 'download', body: { title: 'Download', url: '/download', description: 'Download Modtalk', subdomain: :www, tags: [:download]}
client.index index: index, type: 'docs', id: 'getting_started', body: { title: 'Getting Started', description: 'Get started with Modtalk', url: '/getting_started', subdomain: :docs, tags: [:documentation]}

client.search index: index, body: {
  query: {
    match: {
      title: {
        query: 'get',
        analyzer: 'autocomplete'
      }
    }
  }
}