# frozen_string_literal: true

FactoryBot.define do
  sequence :aname do |n|
    "aname_#{n}"
  end

  sequence :lid do |n|
    "L#{n}"
  end

  sequence :amail do |n|
    "mail_#{n}@example.net"
  end

  sequence :url do |n|
    "tcp://#{Faker::Internet.ip_v4_address}:#{n}"
  end

  factory :alert do
    server
    type { 'alert' }
    message { 'some text' }
  end

  factory :channel do
    server
    uid { `uuid -v 4` }
  end

  factory :channel_counter do
    channel
    server
    channel_statistic
  end

  factory :channel_statistic do
    association :server
    association :channel
    server_uid { `uuid -v 4` }
    channel_uid { `uuid -v 4` }
    condition { 'ok' }
  end

  factory :interface_connector do
    software_interface
    name { generate(:aname) }
    type { 'TxConnector' } 
    url { 'tcp://1.2.3.4:5678' }
  end

  factory :location do
    lid { generate(:lid) }
    name { generate(:aname) }
  end

  factory :note do
    association :server
    association :channel
    association :user
    type { 'acknowledge' }
    message { 'some text' }
  end

  factory :server do
    location
    name { generate(:aname) }
    trait :with_uid do
      uid { `uuid -v 4` }
    end
  end

  factory :server_configuration do
    server
  end

  factory :software do
    location
    name { generate(:aname) }
  end

  factory :software_connection do
    location
    source_url { generate(:url) }
    destination_url { generate(:url) }
  end

  factory :software_interface do
    software
    name { generate(:aname) }
  end

end
