
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
			toc = fare['toc']
			colour = toc ? ("%06x" % (toc.hash & 0xFFFFFF)) : '000'
		end
		x = (v[:lon]+6)*100
		y = 1500-(v[:lat]-50)*150
		svg.circle( x, y, 2, { :fill => "##{colour}" } )
		svg.text(x, y, crs, 0, 0, { :font_size => 3 } )
	end
	svg.close
	File.write('output.svg', svg.output)
