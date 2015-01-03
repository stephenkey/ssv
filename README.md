# Ssv

SSV is a Ruby Gem to import and sort symbol delimited files.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ssv'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ssv


## Usage

Return a single CSV
```ruby
SSV.load(file: 'path/to/file.csv').return
```

Return a multiple CSV's
```ruby
files = [
  {file: "#{fixture_path}/file.csv"},
  {file: "#{fixture_path}/file2.csv"}
]
SSV.load(files).return
```

Return a symbol separated file
```ruby
SSV.load(file: 'path/to/file.csv', col_sep: '$').return
```

Return a symbol separated file and set headers
```ruby
SSV.load(file: 'path/to/file.csv', col_sep: '$', headers: 'last_name, first_name, middle_initial').return
```

Return a symbol separated file and set date format (Defaults to '%m-%d-%Y')
```ruby
SSV.load(file: 'path/to/file.csv', col_sep: '$', date_format: '%m/%d/%Y').return
```

Return a SSV file and sort by column
```ruby
# Ascending order
SSV.load(file: 'path/to/file.csv', col_sep: '$').asc('last_name', 'first_name').return
# Descending order
SSV.load(file: 'path/to/file.csv', col_sep: '$').desc('last_name', 'first_name').return
```

Return specific columns and sort
```ruby
SSV.load(file: 'path/to/file.csv').asc('last_name', 'first_name').return('first_name', 'last_name', 'city')
```


## Testing

```console
bundle exec rspec spec
```

## Contributing

1. Fork it ( https://github.com/stephenkey/ssv/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
