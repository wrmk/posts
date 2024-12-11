# frozen_string_literal: true

ip_addresses = []
logins = []
50.times { ip_addresses << Faker::Internet.ip_v4_address }
100.times { logins << Faker::Internet.username }

200.times do # set 200_000
  json = {
    post: { title: Faker::Book.title,
            body: Faker::Lorem.paragraph,
            ip: ip_addresses.sample,
            login: logins.sample }
  }.to_json
  escaped_json = json.tr('"', '"')

  system "curl -X POST -H 'Content-Type: application/json' " \
         "-d '#{escaped_json}' http://localhost:3000/api/v1/posts"
end
