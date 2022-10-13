require 'openc3'
require 'openc3/script'

id = subscribe_packets([['TEST', 'A_TLM']])

t = Thread.new do
  123.times do
    puts("consumer #{Time.now}")
    id, packets = get_packets(id, block: (10 * 1000), count: 1)
    raise Timeout::Error unless packets
  end
end

sleep(1)

123.times do
  puts("producer #{Time.now}")
  cmd('TEST', 'A_CMD', 'A_PARAM' => 123)
end

t.join
