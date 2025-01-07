<?php
$redis = new Redis();
$redis->connect("192.168.1.219",6379);
$redis->auth("changeme");

// set and get Key
$redis->set('key01', 'value01');
print 'key01.value : ' . $redis->get('key01') . "\n";

// append and get Key
$redis->append('key01', ',value02');
print 'key01.value : ' . $redis->get('key01') . "\n";

$redis->set('key02', 1);
print 'key02.value : ' . $redis->get('key02') . "\n";

// increment
$redis->incr('key02', 100);
print 'key02.value : ' . $redis->get('key02') . "\n";

// decrement
$redis->decr('key02', 51);
print 'key02.value : ' . $redis->get('key02') . "\n";

// list
$redis->lPush('list01', 'value01');
$redis->rPush('list01', 'value02');
print 'list01.value : ';
print_r ($redis->lRange('list01', 0, -1));

// hash
$redis->hSet('hash01', 'key01', 'value01');
$redis->hSet('hash01', 'key02', 'value02');
print 'hash01.value : ';
print_r ($redis->hGetAll('hash01'));

// set
$redis->sAdd('set01', 'member01');
$redis->sAdd('set01', 'member02');
print 'set01.value : ';
print_r ($redis->sMembers('set01'));
?>

