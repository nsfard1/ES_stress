from elasticsearch import Elasticsearch
# from datetime import datetime

def search():
    es = Elasticsearch([{'host': 'localhost', 'port': 9200}])
    res = es.search(index="twitter_elastic_example", doc_type="tweets", body=
    {
        "query": {
	    "match_phrase": {
		"text": "beer"
            }
        }# ,

        # "fields": ["tweet"]
    })
    print("%d documents found" % res['hits']['total'])

    print(res['took'], end=' ')

    r = res['took']

    # for doc in res['hits']['hits']:
        # print("%s: %s" % (doc['_id'], res['took']))
    es.indices.clear_cache(index=["twitter_elastic_example"])# , query=True)

    return r

total = 0
for i in range(100):
    total += search()
total /= 100
print('\n', total)

