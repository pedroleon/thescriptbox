#!/usr/bin/ruby

require 'net/http'

domain = "www.cadenaser.com"
referer = "http://www.cadenaser.com/player_radio.html"
get_token = "/comunes/player/gettoken.php?file=SER_AUTH"
asx = "/comunes/player/mm.php?video=SER_AUTH&auth="
timestamp = Time.new.to_i  
output = "/tmp/#{timestamp}.asx"

headers = {
  'Referer' => referer
}

http = Net::HTTP.new(domain, 80)
resp, data = http.post get_token, "", headers
token = data.scan(/auth='(.*)'/)[0][0]
resp, data = http.post asx+token, "", headers
File.open(output, 'w') {|f| f.write( data ) }
puts output
