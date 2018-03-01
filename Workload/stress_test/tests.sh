STR=$'initializing...\n'
echo "$STR"
curl -X DELETE 'http://localhost:9200/_all'
STR=$'\n\nTest1:'
echo "$STR"
python es-index-stress-test.py --es_address localhost --indices 1  --not-green --documents 100 --clients 1 --seconds 200 --stats-frequency 5 > v3_output/clients-1
echo cleaning up...
curl -X DELETE 'http://localhost:9200/_all'
STR=$'\n\nTest2:'
echo "$STR"
python es-index-stress-test.py --es_address localhost --indices 1 --not-green --documents 100 --clients 2 --seconds 200 --stats-frequency 5 > v3_output/clients-2
echo cleaning up...
curl -X DELETE 'http://localhost:9200/_all'
STR=$'\n\nTest3:'
echo "$STR"
python es-index-stress-test.py --es_address localhost --indices 1 --not-green --documents 100 --clients 3 --seconds 200 --stats-frequency 5 > v3_output/clients-3
echo cleaning up...
curl -X DELETE 'http://localhost:9200/_all'
STR=$'\n\nTest4:'
echo "$STR"
python es-index-stress-test.py --es_address localhost --indices 1 --not-green --documents 100 --clients 4 --seconds 200 --stats-frequency 5 > v3_output/clients-4
echo cleaning up...
curl -X DELETE 'http://localhost:9200/_all'
STR=$'\n\nTest5:'
echo "$STR"
python es-index-stress-test.py --es_address localhost --indices 1 --not-green --documents 100 --clients 5 --seconds 200 --stats-frequency 5 > v3_output/clients-5
echo cleaning up...
curl -X DELETE 'http://localhost:9200/_all'
STR=$'\n\nTest6:'
echo "$STR"
python es-index-stress-test.py --es_address localhost --indices 1 --not-green --documents 100 --clients 6 --seconds 200 --stats-frequency 5 > v3_output/clients-6
echo cleaning up...
curl -X DELETE 'http://localhost:9200/_all'
STR=$'\n\nTest7:'
echo "$STR"
python es-index-stress-test.py --es_address localhost --indices 1 --not-green --documents 100 --clients 7 --seconds 200 --stats-frequency 5 > v3_output/clients-7
echo cleaning up...
curl -X DELETE 'http://localhost:9200/_all'
STR=$'\n\nTest8:'
echo "$STR"
python es-index-stress-test.py --es_address localhost --indices 1 --not-green --documents 100 --clients 8 --seconds 200 --stats-frequency 5 > v3_output/clients-8
echo cleaning up...
curl -X DELETE 'http://localhost:9200/_all'
echo exiting..
