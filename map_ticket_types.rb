
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
		colour = nil
		next unless fares[crs]
		codes = []
		fares[crs].each do |fare|
			codes << fare['ticket']['code']+fare['toc']
#			puts "#{v[:name]}, #{rc}, #{colour}"
		end
		next if codes.empty?
		colour = "%06x" % (codes.sort.join.hash & 0xFFFFFF)
		x = (v[:lon]+6)*100
		y = 1500-(v[:lat]-50)*150
		svg.circle( x, y, 1, { :fill => "##{colour}" } )
		svg.text(x, y, crs, { :font_size => 2,  :fill => "##{colour}" } )
	end
	svg.close
	File.write('map_ticket_types.svg', svg.output)
