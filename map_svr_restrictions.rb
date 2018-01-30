
	require 'json'
	require 'csv'
	require 'pp'
	require 'rasem'

	stations = {}
	CSV.read("stations.csv").each do |line|
		stations[line[0]] = { lat: line[2].to_f, lon: line[3].to_f, name: line[1] }
	end
	fares = JSON.parse(File.read('output.json'))

	svg = Rasem::SVGImage.new(1000,1500)
	stations.each do |crs,v|
		colour = 'EEE'
		next unless fares[crs]
		fares[crs].each do |fare|
			next unless fare['ticket']['code']=='SVR'
			rc = fare['restriction_code']
			colour = rc ? ("%06x" % (rc['id'].hash & 0xFFFFFF)) : '000'
#			puts "#{v[:name]}, #{rc}, #{colour}"
		end
		x = (v[:lon]+6)*100
		y = 1500-(v[:lat]-50)*150
		svg.circle( x, y, 1, { :fill => "##{colour}" } )
		svg.text(x, y, crs, { :font_size => 2, :fill => "##{colour}" } )
	end
	svg.close
	File.write('map_svr_restrictions.svg', svg.output)
