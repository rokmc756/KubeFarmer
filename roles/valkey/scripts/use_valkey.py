import redis

client = redis.StrictRedis(host='192.168.1.219', port=6379, db=0, password='changeme')

# set and get Key
client.set('key01', 'value01')
print('key01.value :', client.get('key01'))

# append and get Key
client.append('key01', ',value02')
print('key01.value :', client.get('key01'))

client.set('key02', 1)

# increment
client.incr('key02', 100)
print('key02.value :', client.get('key02'))

# decrement
client.decr("key02", 51)
print('key02.value :', client.get('key02'))

# list
client.lpush('list01', 'value01', 'value02', 'value03')
print('list01.value :', client.lrange('list01', '0', '2'))

# hash
client.hset('hash01', 'key01', 'value01')
client.hset('hash01', 'key02', 'value02')
client.hset('hash01', 'key03', 'value03')
print('hash01.value :', client.hget('hash01', 'key01'), client.hget('hash01', 'key02'), client.hget('hash01', 'key03'))

# set
client.sadd('set01', 'member01', 'member02', 'member03')
print('set01.value :', client.smembers('set01'))

# run
