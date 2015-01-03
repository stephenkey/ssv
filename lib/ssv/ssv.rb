module SSV
	class << self

	  def load(*args)
	  	files = args.flatten
	  	@data = []
	  	files.each do |hash|
	  		col_sep = (hash.has_key?(:col_sep)) ? hash[:col_sep] : ','
        write_headers = (hash.has_key?(:headers)) ? true : false
        headers = (hash.has_key?(:headers)) ? hash[:headers].split(',') : true
        date_format = (hash.has_key?(:date_format)) ? hash[:date_format] : '%m-%d-%Y'
	  		csv_options = { 
		  		col_sep: col_sep, 
		  		write_headers: write_headers, 
		  		headers: headers, 
		  		header_converters: lambda {|f| f.strip},
		  		converters: lambda {|f| (date = valid_date?(f, date_format)) ? date : f.strip }
		  	}
	  		CSV.foreach(hash[:file], csv_options) do |csv_obj|
	        @data << csv_obj
	      end
	  	end
	  	self
	  end 

	  def return(*cols)
	  	return @data if cols.empty?

	  	cols_selected = cols.map {|col| '#{'+"hash['#{col.strip}']"+'}'}
	  	cols_str = cols_selected.join(' ')
	  	@data.map {|hash| eval("\"#{cols_str}\"") }
	  end

	  def asc(*cols)
	  	raise ArgumentError, 'You must pass columns to order by, SSV.load(files).asc(\'last_name\')' if cols.empty?

	  	a_array = cols.map {|col| "a['#{col.strip}']"}
	  	b_array = cols.map {|col| "b['#{col.strip}']"}
	  	@data.sort! { |a, b| eval("[#{a_array.join(',')}]") <=> eval("[#{b_array.join(',')}]") }
	  	self
	  end

	  def desc(*cols)
	  	raise ArgumentError, 'You must pass columns to order by, SSV.load(files).asc(\'last_name\')' if cols.empty?
	  	
	  	a_array = cols.map {|col| "a['#{col.strip}']"}
	  	b_array = cols.map {|col| "b['#{col.strip}']"}
	  	@data.sort! { |a, b| eval("[#{b_array.join(',')}]") <=> eval("[#{a_array.join(',')}]") }
	    self
	  end

	  def valid_date?(str, format)
	  	Date.strptime(str.to_s.strip, format.strip) rescue false
	  end

  end

end