##
# $Id$
##

##
# This file is part of the Metasploit Framework and may be subject to
# redistribution and commercial restrictions. Please see the Metasploit
# Framework web site for more information on licensing and terms of use.
# http://metasploit.com/framework/
##


require 'msf/core'


class Metasploit3 < Msf::Auxiliary

	include Msf::Auxiliary::Report
	include Msf::Auxiliary::Scanner

	def initialize
		super(
			'Name'        => 'UDP Service Prober',
			'Version'     => '$Revision$',
			'Description' => 'Detect common UDP services using sequential probes',
			'Author'      => 'hdm',
			'License'     => MSF_LICENSE
		)

		register_options(
			[
				Opt::CHOST,
				OptBool.new('VERBOSE', [false, 'Enable verbose output', false])
			], self.class)

		register_advanced_options(
			[
				OptBool.new('RANDOMIZE_PORTS', [false, 'Randomize the order the ports are probed', true])
			], self.class)

		# Intialize the probes array
		@probes = []

		# Add the UDP probe method names
		@probes << 'probe_pkt_dns'
		@probes << 'probe_pkt_netbios'
		@probes << 'probe_pkt_portmap'
		@probes << 'probe_pkt_mssql'
		@probes << 'probe_pkt_ntp'
		@probes << 'probe_pkt_snmp1'
		@probes << 'probe_pkt_snmp2'
		@probes << 'probe_pkt_sentinel'
		@probes << 'probe_pkt_db2disco'
		@probes << 'probe_pkt_citrix'

	end

	def setup
		super

		if datastore['RANDOMIZE_PORTS']
			@probes = @probes.sort_by { rand }
		end
	end

	# Fingerprint a single host
	def run_host(ip)

		@thost = ip

		begin
			udp_sock = nil

			@probes.each do |probe|

			# Send each probe to each host

				begin
					data, port = self.send(probe, ip)
					@tport = port

					# Create an unbound UDP socket if no CHOST is specified, otherwise
					# create a UDP socket bound to CHOST (in order to avail of pivoting)
					udp_sock = Rex::Socket::Udp.create( {
						'LocalHost' => datastore['CHOST'] || nil,
						'PeerHost'  => ip, 'PeerPort' => port,
						'Context' => {'Msf' => framework, 'MsfExploit' => self}
					})

					udp_sock.put(data)

					r = udp_sock.recvfrom(65535, 0.1) and r[1]
					parse_reply(r) if r

				rescue ::Interrupt
					raise $!
				rescue ::Rex::HostUnreachable, ::Rex::ConnectionTimeout, ::Rex::ConnectionRefused, ::IOError
					nil
				ensure
					udp_sock.close if udp_sock
				end

			end
		rescue ::Interrupt
			raise $!
		rescue ::Exception => e
			print_status("Unknown error: #{@thost}:#{@tport} #{e.class} #{e}")
		end
	end


	#
	# The response parsers
	#
	def parse_reply(pkt)

		@results ||= {}

		# Ignore "empty" packets
		return if not pkt[1]

		if(pkt[1] =~ /^::ffff:/)
			pkt[1] = pkt[1].sub(/^::ffff:/, '')
		end

		# Ignore duplicates
		hkey = "#{pkt[1]}:#{pkt[2]}"
		return if @results[hkey]

		app = 'unknown'
		inf = ''
		maddr = nil
		hname = nil

		case pkt[2]
			when 53
				app = 'DNS'
				ver = nil

				if (not ver and pkt[0] =~ /([6789]\.[\w\.\-_\:\(\)\[\]\/\=\+\|\{\}]+)/i)
					ver = 'BIND ' + $1
				end

				ver = 'Microsoft DNS' if (not ver and pkt[0][2,4] == "\x81\x04\x00\x01")
				ver = 'TinyDNS'       if (not ver and pkt[0][2,4] == "\x81\x81\x00\x01")

				ver = pkt[0].unpack('H*')[0] if not ver
				inf = ver if ver
			when 137
				app = 'NetBIOS'

				data = pkt[0]

				head = data.slice!(0,12)

				xid, flags, quests, answers, auths, adds = head.unpack('n6')
				return if quests != 0
				return if answers == 0

				qname = data.slice!(0,34)
				rtype,rclass,rttl,rlen = data.slice!(0,10).unpack('nnNn')
				buff = data.slice!(0,rlen)

				names = []

				case rtype
				when 0x21
					rcnt = buff.slice!(0,1).unpack("C")[0]
					1.upto(rcnt) do
						tname = buff.slice!(0,15).gsub(/\x00.*/, '').strip
						ttype = buff.slice!(0,1).unpack("C")[0]
						tflag = buff.slice!(0,2).unpack('n')[0]
						names << [ tname, ttype, tflag ]
					end
					maddr = buff.slice!(0,6).unpack("C*").map{|c| "%.2x" % c }.join(":")

					names.each do |name|
						inf << name[0]
						inf << ":<%.2x>" % name[1]
						if (name[2] & 0x8000 == 0)
							inf << ":U :"
						else
							inf << ":G :"
						end
					end
					inf << maddr

					if(names.length > 0)
						hname = names[0][0]
					end
				end

			when 111
				app = 'Portmap'
				buf = pkt[0]
				inf = ""
				hed = buf.slice!(0,24)
				svc = []
				while(buf.length >= 20)
					rec = buf.slice!(0,20).unpack("N5")
					svc << "#{rec[1]} v#{rec[2]} #{rec[3] == 0x06 ? "TCP" : "UDP"}(#{rec[4]})"
					report_service(
						:host => pkt[1],
						:port => rec[4],
						:proto => (rec[3] == 0x06 ? "tcp" : "udp"),
						:name => "sunrpc",
						:info => "#{rec[1]} v#{rec[2]}"
					)
				end
				inf = svc.join(", ")

			when 123
				app = 'NTP'
				ver = nil
				ver = pkt[0].unpack('H*')[0]
				ver = 'NTP v3'                  if (ver =~ /^1c06|^1c05/)
				ver = 'NTP v4'                  if (ver =~ /^240304/)
				ver = 'NTP v4 (unsynchronized)' if (ver =~ /^e40/)
				ver = 'Microsoft NTP'           if (ver =~ /^dc00|^dc0f/)
				inf = ver if ver
			when 1434
				app = 'MSSQL'
				mssql_ping_parse(pkt[0]).each_pair { |k,v|
					inf += k+'='+v+' '
				}

			when 161
				app = 'SNMP'
				begin
					asn = ASNData.new(pkt[0])
					inf = asn.access("L0.L0.L0.L0.V1.value")
					if (inf)
						inf.gsub!(/\r|\n/, ' ')
						inf.gsub!(/\s+/, ' ')
					end
				rescue ::Exception
				end
			when 5093
				app = 'Sentinel'

			when 523
				app = 'ibm-db2'
				inf = db2disco_parse(pkt[0])

			when 1604
				app = 'citrix-ica'
				return unless citrix_parse(pkt[0])

		end

		report_service(
			:host  => pkt[1],
			:host_mac  => (maddr and maddr != '00:00:00:00:00:00') ? maddr : nil,
			:host_name => (hname) ? hname.downcase : nil,
			:port  => pkt[2],
			:proto => 'udp',
			:name  => app,
			:info  => inf
		)

		print_status("Discovered #{app} on #{pkt[1]}:#{pkt[2]} (#{inf})")

	end

	#
	# Parse a asn1 buffer into a hash tree
	#

	class ASNData < ::Hash

		def initialize(data)
			_parse_asn1(data, self)
		end

		def _parse_asn1(data, tree)
			x = 0
			while (data.length > 0)
				t,l = data[0,2].unpack('CC')
				i = 2

				if (l > 0x7f)
					lb = l - 0x80
					l = (("\x00" * (4-lb)) + data[i, lb]).unpack('N')[0]
					i += lb
				end

				buff = data[i, l]

				tree[:v] ||= []
				tree[:l] ||= []
				case t
					when 0x00...0x29
						tree[:v] << [t, buff]
					else
						tree[:l][x] ||= ASNData.new(buff)
						x += 1
				end
				data = data[i + l, data.length - l]
			end
		end

		def access(desc)
			path = desc.split('.')
			node = self
			path.each_index do |i|
				case path[i]
					when /^V(\d+)$/
						if (node[:v] and node[:v][$1.to_i])
							node = node[:v][$1.to_i]
							next
						else
							return nil
						end
					when /^L(\d+)$/
						if (node[:l] and node[:l][$1.to_i])
							node = node[:l][$1.to_i]
							next
						else
							return nil
						end
					when 'type'
						return (node and node[0]) ? node[0] : nil
					when 'value'
						return (node and node[1]) ? node[1] : nil
					else
						return nil
				end
			end
			return node
		end
	end

	#
	# Parse a db2disco packet.
	#
	def db2disco_parse(data)
		res = data.split("\x00")
		"#{res[2]}_#{res[1]}"
	end

	#
	# Validate this is truly Citrix ICA; returns true or false.
	#
	def citrix_parse(data)
		server_response = "\x30\x00\x02\x31\x02\xfd\xa8\xe3\x02\x00\x06\x44" # Server hello response
		data =~ /^#{server_response}/
	end

	#
	# Parse a 'ping' response and format as a hash
	#
	def mssql_ping_parse(data)
		res = {}
		var = nil
		idx = data.index('ServerName')
		return res if not idx

		data[idx, data.length-idx].split(';').each do |d|
			if (not var)
				var = d
			else
				if (var.length > 0)
					res[var] = d
					var = nil
				end
			end
		end

		return res
	end

	#
	# The probe definitions
	#

	def probe_pkt_dns(ip)
		data = [rand(0xffff)].pack('n') +
		"\x01\x00\x00\x01\x00\x00\x00\x00\x00\x00"+
		"\x07"+ "VERSION"+
		"\x04"+ "BIND"+
		"\x00\x00\x10\x00\x03"

		return [data, 53]
	end

	def probe_pkt_netbios(ip)
		data =
		[rand(0xffff)].pack('n')+
		"\x00\x00\x00\x01\x00\x00\x00\x00"+
		"\x00\x00\x20\x43\x4b\x41\x41\x41"+
		"\x41\x41\x41\x41\x41\x41\x41\x41"+
		"\x41\x41\x41\x41\x41\x41\x41\x41"+
		"\x41\x41\x41\x41\x41\x41\x41\x41"+
		"\x41\x41\x41\x00\x00\x21\x00\x01"

		return [data, 137]
	end

	def probe_pkt_portmap(ip)
		data =
		[
			rand(0xffffffff), # XID
			0,              # Type
			2,              # RPC Version
			100000,         # Program ID
			2,              # Program Version
			4,              # Procedure
			0, 0,   # Credentials
			0, 0,   # Verifier
		].pack('N*')

		return [data, 111]
	end

	def probe_pkt_mssql(ip)
		return ["\x02", 1434]
	end

	def probe_pkt_ntp(ip)
		data =
			"\xe3\x00\x04\xfa\x00\x01\x00\x00\x00\x01\x00\x00\x00" +
			"\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00" +
			"\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00" +
			"\x00\xc5\x4f\x23\x4b\x71\xb1\x52\xf3"
		return [data, 123]
	end


	def probe_pkt_sentinel(ip)
		return ["\x7a\x00\x00\x00\x00\x00", 5093]
	end

	def probe_pkt_snmp1(ip)
		name = 'public'
		xid = rand(0x100000000)
		pdu =
			"\x02\x01\x00" +
			"\x04" + [name.length].pack('c') + name +
			"\xa0\x1c" +
			"\x02\x04" + [xid].pack('N') +
			"\x02\x01\x00" +
			"\x02\x01\x00" +
			"\x30\x0e\x30\x0c\x06\x08\x2b\x06\x01\x02\x01" +
			"\x01\x01\x00\x05\x00"
		head = "\x30" + [pdu.length].pack('C')
		data = head + pdu
		[data, 161]
	end

	def probe_pkt_snmp2(ip)
		name = 'public'
		xid = rand(0x100000000)
		pdu =
			"\x02\x01\x01" +
			"\x04" + [name.length].pack('c') + name +
			"\xa1\x19" +
			"\x02\x04" + [xid].pack('N') +
			"\x02\x01\x00" +
			"\x02\x01\x00" +
			"\x30\x0b\x30\x09\x06\x05\x2b\x06\x01\x02\x01" +
			"\x05\x00"
		head = "\x30" + [pdu.length].pack('C')
		data = head + pdu
		[data, 161]
	end

	def probe_pkt_db2disco(ip)
		data = "DB2GETADDR\x00SQL05000\x00"
		[data, 523]
	end

	def probe_pkt_citrix(ip) # Server hello packet from citrix_published_bruteforce
		data =
			"\x1e\x00\x01\x30\x02\xfd\xa8\xe3\x00\x00\x00\x00\x00" +
			"\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00" +
			"\x00\x00\x00\x00"
		return [data, 1604]
	end


end

