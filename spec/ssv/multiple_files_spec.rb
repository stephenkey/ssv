require 'spec_helper'
fixture_path = 'spec/fixtures'

describe SSV do
  context 'when given multiple files' do
    files = [
      {file: "#{fixture_path}/basic.csv", col_sep: ',', headers: 'last_name,first_name,city,color,date'},
      {file: "#{fixture_path}/basic.txt", col_sep: '$', headers: 'last_name,first_name,middle_init,city,date,color'}
    ]
    output = SSV.load(files).return('last_name')
    
    it 'load files' do
      expect(output).to_not be_empty
    end

    it 'contain data from all files' do
      expect(output).to include("Kirlin")
      expect(output).to include("Bruen")
    end
  end

  context 'when retrieving last_name ascending from multiple files' do
    files = [
      {file: "#{fixture_path}/basic.csv", col_sep: ',', headers: 'last_name,first_name,city,color,date'},
      {file: "#{fixture_path}/basic.txt", col_sep: '$', headers: 'last_name,first_name,middle_init,city,date,color'}
    ]
    output = SSV.load(files).asc('last_name').return('last_name')

    it 'returns last_name in ascending order' do
      expect(output).to eq(["Bruen", "Cummerata", "Kirlin", "Kirlin", "Kirlin", "Nolan", "Parker", "Wilkinson"])
    end
  end
end