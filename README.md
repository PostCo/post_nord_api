# PostNord Ruby Gem

A Ruby wrapper for the PostNord API that provides simple access to booking return and tracking shipment.

## Features

- **Return Booking**: Create return shipment using EDI formatting
- **Shipment Tracking**: Track shipment by identifier

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'postnord_api'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install postnord_api

## Usage

### Intialize a Postnord API client

- For production usage:

```ruby
client = PostnordAPI::Client.new(api_key: "api_key")
```

- For development usage:

```ruby
client = PostnordAPI::Client.new(api_key: "api_key", test_mode: true)
```

### Create Return Shipmemt

```ruby
begin
   client = PostnordAPI::Client.new(api_key: "api_key")
   params = {
      "messageDate": '2025-09-23T11:40:52Z',
      "messageFunction": 'Instruction',
      "messageId": 'msg-18272155',
      "application": {
        "applicationId": 1438,
        "name": 'PostNord',
        "version": '1.0'
      },
      "language": 'EN',
      "updateIndicator": 'Original',
      "shipment": [
        {
          "shipmentIdentification": {
            "shipmentId": '0'
          },
          "dateAndTimes": {
            "loadingDate": '2020-11-29T11:13:00'
          },
          "service": {
            "basicServiceCode": '24',
            "additionalServiceCode": []
          },
          "numberOfPackages": {
            "value": 1
          },
          "totalGrossWeight": {
            "value": 5.23,
            "unit": 'KGM'
          },
          "references": [
            {
              "referenceNo": '61G33IGAPTVZPY5',
              "referenceType": 'CU'
            }
          ],
          "parties": {
            "consignor": {
              "issuerCode": 'Z12',
              "partyIdentification": {
                "partyId": '1111111111',
                "partyIdType": '160'
              },
              "party": {
                "nameIdentification": {
                  "name": 'CONSIGNOR'
                },
                "address": {
                  "streets": [
                    'Terminalvägen 14'
                  ],
                  "postalCode": '17173',
                  "city": 'solna',
                  "countryCode": 'SE'
                },
                "contact": {
                  "contactName": 'Consignor',
                  "emailAddress": 'Consignor@me.com',
                  "phoneNo": '+46071111111',
                  "smsNo": '+46071111111'
                }
              }
            },
            "consignee": {
              "party": {
                "nameIdentification": {
                  "name": 'Consignee'
                },
                "address": {
                  "streets": [
                    'Östermalmsgatan 87D'
                  ],
                  "postalCode": '11459',
                  "city": 'STOCKHOLM',
                  "countryCode": 'SE'
                },
                "contact": {
                  "contactName": 'Consignee',
                  "emailAddress": 'Consignee@me.com',
                  "phoneNo": '+46071111111',
                  "smsNo": '+46071111111'
                }
              }
            }
          },
          "goodsItem": [
            {
              "marking": 'Description of the commodities',
              "goodsDescription": 'goodsDescription',
              "packageTypeCode": 'PC',
              "items": [
                {
                  "itemIdentification": {
                    "itemId": '0'
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

rescue PostnordAPI::Error => e
  puts "Error creating return shipment: #{e.message}"
end
```

### Track Shipment

```ruby
begin
  # Track shipment by identifier
  client.shipment.track("1234567890")

rescue PostnordAPI::APIError => e
  puts "Tracking failed: #{e.message}"
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/PostCo/postnord_api. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/postnord_api/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the PostnordApi project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/postnord_api/blob/main/CODE_OF_CONDUCT.md).
