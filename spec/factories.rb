FactoryBot.define do
  sequence :aname do |n|
    "aname_#{n}"
  end

  sequence :amail do |n|
    "mail_#{n}@example.net"
  end

  factory :alert do
    server
    channel
    type { "alert" }
    message { "some text" }
  end

  factory :server do
    name { generate(:aname) }
    trait :with_uid do
      uid { `uuid -v 4` }
    end
  end

  factory :channel do
    server
    uid { `uuid -v 4` }
  end

  factory :channel_counter do
    channel
    server
  end

  factory :channel_statistic do
    server
    channel
    server_uid { `uuid -v 4` }
    channel_uid { `uuid -v 4` }
  end
end
