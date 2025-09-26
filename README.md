# PostNord Ruby Gem

A Ruby wrapper for the PostNord API that provides simple access to booking return and tracking shipment.

## Features

- **Return Booking**: Create return shipment using EDI formatting
- **Shipment Tracking**: Track shipment by identifier

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'post_nord_api'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install post_nord_api

## Usage

### Intialize a Postnord API client

- For production usage:

```ruby
client = PostNordAPI::Client.new(api_key: "api_key")
```

- For development usage:

```ruby
client = PostNordAPI::Client.new(api_key: "api_key", test_mode: true)
```

### Create Return Shipmemt

```ruby
begin
   client = PostNordAPI::Client.new(api_key: "api_key")
   params = {
      "message_date": '2025-09-23T11:40:52Z',
      "message_function": 'Instruction',
      "message_id": 'msg-18272155',
      "application": {
        "application_id": 1438,
        "name": 'PostNord',
        "version": '1.0'
      },
      "language": 'EN',
      "update_indicator": 'Original',
      "shipment": [
        {
          "shipment_identification": {
            "shipment_id": '0'
          },
          "date_and_times": {
            "loading_date": '2020-11-29T11:13:00'
          },
          "service": {
            "basic_service_code": '24',
            "additional_service_code": []
          },
          "number_of_packages": {
            "value": 1
          },
          "total_gross_weight": {
            "value": 5.23,
            "unit": 'KGM'
          },
          "references": [
            {
              "reference_no": '61G33IGAPTVZPY5',
              "reference_type": 'CU'
            }
          ],
          "parties": {
            "consignor": {
              "issuer_code": 'Z12',
              "party_identification": {
                "party_id": '1111111111',
                "party_id_type": '160'
              },
              "party": {
                "name_identification": {
                  "name": 'CONSIGNOR'
                },
                "address": {
                  "streets": [
                    'Terminalvägen 14'
                  ],
                  "postal_code": '17173',
                  "city": 'solna',
                  "country_code": 'SE'
                },
                "contact": {
                  "contact_name": 'Consignor',
                  "email_address": 'Consignor@me.com',
                  "phone_no": '+46071111111',
                  "sms_no": '+46071111111'
                }
              }
            },
            "consignee": {
              "party": {
                "name_identification": {
                  "name": 'Consignee'
                },
                "address": {
                  "streets": [
                    'Östermalmsgatan 87D'
                  ],
                  "postal_code": '11459',
                  "city": 'STOCKHOLM',
                  "country_code": 'SE'
                },
                "contact": {
                  "contact_name": 'Consignee',
                  "email_address": 'Consignee@me.com',
                  "phone_no": '+46071111111',
                  "sms_no": '+46071111111'
                }
              }
            }
          },
          "goods_item": [
            {
              "marking": 'Description of the commodities',
              "goods_description": 'goodsDescription',
              "package_type_code": 'PC',
              "items": [
                {
                  "item_identification": {
                    "item_id": '0'
                  }
                }
              ]
            }
          ]
        }
      ]
    }

  client.shipment.create_return_label(params)
  # The result contains the label data, QR code data and tracking URL.

rescue PostNordAPI::Error => e
  puts "Error creating return shipment: #{e.message}"
end
```

### Track Shipment

```ruby
begin
  # Track shipment by identifier
  client.shipment.track("1234567890")

rescue PostNordAPI::APIError => e
  puts "Tracking failed: #{e.message}"
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/PostCo/post_nord_api. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/post_nord_api/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the PostnordApi project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/post_nord_api/blob/main/CODE_OF_CONDUCT.md).
