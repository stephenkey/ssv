require 'spec_helper'
fixture_path = 'spec/fixtures'

describe SSV do
  context 'output GA files in ordered format' do
    files = [
      {file: "#{fixture_path}/comma.txt", date_format: '%m/%d/%Y', headers: 'last_name, first_name, campus, favorite_color, date'},
      {file: "#{fixture_path}/dollar.txt", col_sep: '$', headers: 'last_name, first_name, middle_initial, campus, date, favorite_color'},
      {file: "#{fixture_path}/pipe.txt", col_sep: '|', headers: 'last_name, first_name, middle_initial, campus, favorite_color, date'}
    ]
    
    puts '---------- Output 1 ----------'
    puts SSV.load(files).asc('campus', 'last_name').return('last_name', 'first_name', 'campus', 'date', 'favorite_color')
    
    puts '---------- Output 2 ----------'
    puts SSV.load(files).asc('date').return('last_name', 'first_name', 'campus', 'date', 'favorite_color')
    
    puts '---------- Output 3 ----------'
    puts SSV.load(files).desc('last_name').return('last_name', 'first_name', 'campus', 'date', 'favorite_color')
    
  end
end