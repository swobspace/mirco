FactoryBot.define do
  sequence :aname do |n|
    "aname_#{n}"
  end

  sequence :amail do |n|
    "mail_#{n}@example.net"
  end

  factory :server do
    name { generate(:aname) }
  end

  factory :channel do
    server
    uid { `uuid -v 4` }
  end
end
