speed_test() {
	local speedtest=$( curl  -m 12 -Lo /dev/null -skw "%{speed_download}\n" "$1" )
	local host=$(awk -F':' '{print $1}' <<< `awk -F'/' '{print $3}' <<< $1`)
	local ipaddress=$(ping -c1 -n ${host} | awk -F'[()]' '{print $2;exit}')
	local nodeName=$2
	printf "%-32s%-24s%-14s\n" "${nodeName}" "${ipaddress}" "$(FormatBytes $speedtest)"
}

FormatBytes() {
	bytes=${1%.*}
	local Mbps=$( printf "%s" "$bytes" | awk '{ printf "%.2f", $0 / 1024 / 1024 * 8 } END { if (NR == 0) { print "error" } }' )
	if [[ $bytes -lt 1000 ]]; then
		printf "%8i B/s |      N/A     "  $bytes
	elif [[ $bytes -lt 1000000 ]]; then
		local KiBs=$( printf "%s" "$bytes" | awk '{ printf "%.2f", $0 / 1024 } END { if (NR == 0) { print "error" } }' )
		printf "%7s KiB/s | %7s Mbps" "$KiBs" "$Mbps"
	else
		# awk way for accuracy
		local MiBs=$( printf "%s" "$bytes" | awk '{ printf "%.2f", $0 / 1024 / 1024 } END { if (NR == 0) { print "error" } }' )
		printf "%7s MiB/s | %7s Mbps" "$MiBs" "$Mbps"
		# bash way
		# printf "%4s MiB/s | %4s Mbps""$(( bytes / 1024 / 1024 ))" "$(( bytes / 1024 / 1024 * 8 ))"
	fi
}

speed() {
	printf "%-32s%-31s%-14s\n" "Node Name:" "IP address:" "Download Speed"
#	speed_test 'http://cachefly.cachefly.net/100mb.test' 'CacheFly'
	speed_test 'http://tpdb.speed2.hinet.net/test_100m.zip' 'Hinet, Taiwan, TW'
	speed_test 'http://http.speed.hinet.net/test_1024m.zip' 'Hinet-1GB, Taiwan, TW'
#    	speed_test 'http://speedtest.tokyo.linode.com/100MB-tokyo.bin' 'Linode, Tokyo, JP'
	speed_test 'http://speedtest.tokyo2.linode.com/100MB-tokyo2.bin' 'Linode, Tokyo, JP'
	speed_test 'http://speedtest.singapore.linode.com/100MB-singapore.bin' 'Linode, Singapore, SG'
	speed_test 'http://speedtest.mumbai1.linode.com/100MB-singapore.bin' 'Linode, Mumbai, ID'
	speed_test 'http://speedtest.syd1.linode.com/100MB-singapore.bin' 'Linode, Sydney, AU'
	speed_test 'http://speedtest.fremont.linode.com/100MB-fremont.bin' 'Linode, Fremont, US'
	speed_test 'http://speedtest.newark.linode.com/100MB-newark.bin' 'Linode, Newark, US'
	speed_test 'http://speedtest.toronto1.linode.com/100MB-newark.bin' 'Linode, Toronto, CA'
	speed_test 'http://speedtest.london.linode.com/100MB-london.bin' 'Linode, London, UK'
	speed_test 'http://speedtest.frankfurt.linode.com/100MB-frankfurt.bin' 'Linode, Frankfurt, DE'
	speed_test 'https://speedtest.lv.buyvm.net/100MB.test' 'BuyVM, Las Vegas, US'
	speed_test 'https://speedtest.ny.buyvm.net/100MB.test' 'BuyVM, New York, US'
	speed_test 'https://speedtest.mia.buyvm.net/100MB.test' 'BuyVM, Miami, US'
	speed_test 'https://speedtest.lu.buyvm.net/100MB.test' 'BuyVM, Luxembourg, LU'
	speed_test 'https://jnb-za-ping.vultr.com/vultr.com.100MB.bin' 'Vultr, Johannesburg, ZA'
	speed_test 'https://blr-in-ping.vultr.com/vultr.com.100MB.bin' 'Vultr, Bangalore, ID'
	speed_test 'https://del-in-ping.vultr.com/vultr.com.100MB.bin' 'Vultr, Delhi NCR, ID'
	speed_test 'https://sel-kor-ping.vultr.com/vultr.com.100MB.bin' 'Vultr, Seoul, KR'
	speed_test 'https://sgp-ping.vultr.com/vultr.com.100MB.bin' 'Vultr, Singapore, ZA'
	speed_test 'https://hnd-jp-ping.vultr.com/vultr.com.100MB.bin' 'Vultr, Tokyo, JP'
	speed_test 'https://mel-au-ping.vultr.com/vultr.com.100MB.bin' 'Vultr, Melbourne, AU'
	speed_test 'https://syd-au-ping.vultr.com/vultr.com.100MB.bin' 'Vultr, Sydney, AU'
	speed_test 'https://ams-nl-ping.vultr.com/vultr.com.100MB.bin' 'Vultr, Amsterdam, NL'
	speed_test 'https://fra-de-ping.vultr.com/vultr.com.100MB.bin' 'Vultr, Frankfurt, DE'
	speed_test 'https://lon-gb-ping.vultr.com/vultr.com.100MB.bin' 'Vultr, London, UK'
	speed_test 'https://mad-es-ping.vultr.com/vultr.com.100MB.bin' 'Vultr, Madrid, ES'
	speed_test 'https://par-fr-ping.vultr.com/vultr.com.100MB.bin' 'Vultr, Paris, FR'
	speed_test 'https://sto-se-ping.vultr.com/vultr.com.100MB.bin' 'Vultr, Stockholm, SE'
	speed_test 'https://waw-pl-ping.vultr.com/vultr.com.100MB.bin' 'Vultr, Warsaw, PL'
	speed_test 'https://ga-us-ping.vultr.com/vultr.com.100MB.bin' 'Vultr, Atlanta, US'
	speed_test 'https://il-us-ping.vultr.com/vultr.com.100MB.bin' 'Vultr, Chicago, US'
	speed_test 'https://tx-us-ping.vultr.com/vultr.com.100MB.bin' 'Vultr, Dallas, US'
	speed_test 'https://hon-hi-us-ping.vultr.com/vultr.com.100MB.bin' 'Vultr, Honolulu, US'
	speed_test 'https://lax-ca-us-ping.vultr.com/vultr.com.100MB.bin' 'Vultr, Los Angeles, US'
	speed_test 'https://fl-us-ping.vultr.com/vultr.com.100MB.bin' 'Vultr, Miami, US'
	speed_test 'https://nj-us-ping.vultr.com/vultr.com.100MB.bin' 'Vultr, New Jersey, US'
	speed_test 'https://wa-us-ping.vultr.com/vultr.com.100MB.bin' 'Vultr, Seattle, US'
	speed_test 'https://sjo-ca-us-ping.vultr.com/vultr.com.100MB.bin' 'Vultr, Silicon Valley, US'
	speed_test 'https://mex-mx-ping.vultr.com/vultr.com.100MB.bin' 'Vultr, Mexico City, MX'
	speed_test 'https://tor-ca-ping.vultr.com/vultr.com.100MB.bin' 'Vultr, Toronto, CA'
	speed_test 'https://sao-br-ping.vultr.com/vultr.com.100MB.bin' 'Vultr, São Paulo, BR'
	speed_test 'http://speedtest.tok02.softlayer.com/downloads/test100.zip' 'Softlayer, Tokyo, JP'
	speed_test 'http://speedtest.sng01.softlayer.com/downloads/test100.zip' 'Softlayer, Singapore, SG'
	speed_test 'http://speedtest.sng01.softlayer.com/downloads/test100.zip' 'Softlayer, Seoul, KR'
#	speed_test 'http://speedtest.hkg02.softlayer.com/downloads/test100.zip' 'Softlayer, HongKong, HK'
	speed_test 'http://speedtest.dal13.softlayer.com/downloads/test100.zip' 'Softlayer, Dallas, TX'
#	speed_test 'http://speedtest.sea01.softlayer.com/downloads/test100.zip' 'Softlayer, Seattle, US'
	speed_test 'http://speedtest.fra02.softlayer.com/downloads/test100.zip' 'Softlayer, Frankfurt, DE'
	speed_test 'http://speedtest.par01.softlayer.com/downloads/test100.zip' 'Softlayer, Paris, FR'
	speed_test 'http://mirror.hk.leaseweb.net/speedtest/100mb.bin' 'Leaseweb, HongKong, CN'
	speed_test 'http://mirror.sg.leaseweb.net/speedtest/100mb.bin' 'Leaseweb, Singapore, SG'
	speed_test 'http://mirror.wdc1.us.leaseweb.net/speedtest/100mb.bin' 'Leaseweb, Washington D.C., US'
	speed_test 'http://mirror.sfo12.us.leaseweb.net/speedtest/100mb.bin' 'Leaseweb, San Francisco, US'
	speed_test 'http://mirror.nl.leaseweb.net/speedtest/100mb.bin' 'Leaseweb, Netherlands, NL'
#	speed_test 'http://proof.ovh.ca/files/100Mio.dat' 'OVH, Montreal, CA'
	# next
}

speed
