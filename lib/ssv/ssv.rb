# SSV is a ruby CSV wrapper for reading and sorting symbol separated files.
#
# Examples
#
#   SSV.read(file: 'path/to/file.txt').return
#   # => Kirlin,Mckayla,Atlanta,Maroon,1986-05-2
module SSV
  
  # Public: Read the SSV files
  #
  # args - The files and options passed as Hashs
  #
  # Examples
  #
  #   SSV.read(file: 'path/to/file.txt').return
  #   # => 'Kirlin,Mckayla,Atlanta,Maroon,1986-05-2'
  #
  # Returns an array of CSV row objects
  def self.read(*args)
    files = args.flatten
    @data = []
    
    files.each do |hash|
      raise ArgumentError, 'Files must be passed as a hash. Example: file: \'path/to/file.txt\'' unless hash.is_a?(Hash)
      raise ArgumentError, 'Hash must contain file key. Example: file: \'path/to/file.txt\'' unless hash.has_key?(:file)

      col_sep = (hash.has_key?(:col_sep)) ? hash[:col_sep] : ','
      write_headers = (hash.has_key?(:headers)) ? true : false
      headers = (hash.has_key?(:headers)) ? hash[:headers].split(',') : true
      date_format = (hash.has_key?(:date_format)) ? hash[:date_format] : '%m-%d-%Y'

      csv_options = { 
        col_sep: col_sep, 
        write_headers: write_headers, 
        headers: headers, 
        header_converters: lambda {|f| f.strip},
        converters: lambda { |f| (date = valid_date?(f, date_format)) ? date : f.strip }
      }

      CSV.foreach(hash[:file], csv_options) do |row|
        @data << row
      end
    end
    
    self
  end 

  # Public: Return specific SSV columns
  #
  # cols - Array of columns to be returned
  #
  # Examples
  #
  #   SSV.read(file: 'path/to/file.txt').return('last_name', 'first_name')
  #   # => 'Kirlin Mckayla'
  #
  # Returns an array of CSV row objects
  def self.return(*cols)
    return @data if cols.empty?

    cols_selected = cols.map { |col| '#{'+"hash['#{col.strip}']"+'}' }
    cols_str = cols_selected.join(' ')

    @data.map { |hash| eval("\"#{cols_str}\"") }
  end

  # Public: Sort columns in ascending order
  #
  # cols - Array of columns to sort by
  #
  # Examples
  #
  #   SSV.read(file: 'path/to/file.txt').asc('last_name').return('last_name', 'first_name')
  #   # => 'Kirlin Mckayla'
  #
  # Returns an array of CSV row objects
  def self.asc(*cols)
    raise ArgumentError, 'You must pass columns to order by, SSV.load(files).asc(\'last_name\')' if cols.empty?

    col_names_a = cols.map { |col| "a['#{col.strip}']" }
    col_names_b = cols.map { |col| "b['#{col.strip}']" }
    @data.sort! { |a, b| eval("[#{col_names_a.join(',')}]") <=> eval("[#{col_names_b.join(',')}]") }
    
    self
  end

  # Public: Sort columns in descending order
  #
  # cols - Array of columns to sort by
  #
  # Examples
  #
  #   SSV.read(file: 'path/to/file.txt').desc('last_name').return('last_name', 'first_name')
  #   # => 'Kirlin Mckayla'
  #
  # Returns an array of CSV row objects
  def self.desc(*cols)
    raise ArgumentError, 'You must pass columns to order by, SSV.load(files).asc(\'last_name\')' if cols.empty?
  	
    col_names_a = cols.map { |col| "a['#{col.strip}']" }
    col_names_b = cols.map { |col| "b['#{col.strip}']" }
    @data.sort! { |a, b| eval("[#{col_names_b.join(',')}]") <=> eval("[#{col_names_a.join(',')}]") }
    
    self
  end

  # Public: Validate date format
  #
  # str    - String to test
  # format - Date format to test against
  #
  # Examples
  #
  #   SSV.valid_date?('12/4/2015', '%m/%d/%Y')
  #   # => #<Date: 2015-12-04 ((2457361j,0s,0n),+0s,2299161j)>
  #
  # Returns an array of CSV row objects
  def self.valid_date?(str, format)
    Date.strptime(str.to_s.strip, format.strip) rescue false
  end

end
