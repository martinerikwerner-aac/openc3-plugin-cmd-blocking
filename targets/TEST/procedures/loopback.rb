require 'socket'

PORT = 12345
DELAY_SECONDS = 1.5

server = TCPServer.new(PORT)

loop do
    client = server.accept
    loop do
        data = client.recv(1024)
        break if data.empty?
        sleep(Float(DELAY_SECONDS))
        client.sendmsg(data)
    end
end
