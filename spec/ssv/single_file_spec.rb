require 'spec_helper'
fixture_path = 'spec/fixtures'

describe SSV do

  context 'when given single csv file' do
    file = "#{fixture_path}/basic.csv"
    output = SSV.read(file: file, headers: 'last_name,first_name,city,color,date').return

    it 'loads file content' do
      expect(output).to_not be_empty
    end
  end

  context 'when retrieving last_name from single csv file' do
    file = "#{fixture_path}/basic.csv"
    output = SSV.read(file: file, headers: 'last_name,first_name,city,color,date').return('last_name')

    it 'returns last_name' do
      expect(output).to include("Kirlin")
    end

    it 'does not return first_name' do
      expect(output).to_not include("Mckayla")
    end
  end

  context 'when retrieving last_name from single csv file with headers' do
    file = "#{fixture_path}/with_headers.csv"
    output = SSV.read(file: file).return('last_name')

    it 'returns last_name' do
      expect(output).to include("Kirlin")
    end

    it 'does not return first_name' do
      expect(output).to_not include("Mckayla")
    end
  end

end