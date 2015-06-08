# Bluedart Gem

The Gem provides an interface to Bluedart APIs. Currently under development. FYI This gem is neither built nor promoted by Bluedart. To experiment with the code, run `bin/console` for an interactive prompt.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'bluedart'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bluedart

## Usage

### Pincode API

```ruby
pincode_details = {pincode: 411028, mode: 'development', creds: {license_key: '', login_id: ''}}

p = Bluedart::PincodeService.new(pincode_details)
p.response
```

### Shipment API

```ruby
shipment_details = {mode: 'prod'}

shipment_details[:creds] = {license_key: '', login_id: ''}}

shipment_details[:shipper_details] = {customer_code:"", :customer_name:"J Bieber", :address:"ABC ABC", customer_pincode:"499999",customer_telephone:nil, customer_mobile:"", customer_email_id:"someone@me.com", sender:'', vendor_code:"", isToPayCustomer:false, origin_area:'AAA'}

shipment_details[:consignee_details] = {consignee_name:"Ninja", address:"hogsmeade station", consignee_pincode:"999999", consignee_telephone:"000000000", :consignee_mobile:"0000000000", consignee_attention:""}

shipment_details[:services] = {piece_count:1, actual_weight:0.1, pack_type:"", invoice_no:"", special_instruction:"", declared_value:9999, credit_reference_no:"9999", dimensions:"", pickup_date:'2015-12-12', pickup_time:"1313", commodities:['Crack'], product_type:"Dutiables", collectable_amount:5050, product_code:"A", sub_product_code:"C", p_d_f_output_not_required:false}

b = Bluedart::Shipment.new(shipment_details)
b.response
```

### Tracking API

```ruby

tracking_details = {creds: {license_key: '', login_id: ''}, scans: 0}

tracking_details[:numbers] = ['123456798']

t = Bluedart::Tracking.new(tracking_details)
t.request

```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/chirag7jain/bluedart/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
