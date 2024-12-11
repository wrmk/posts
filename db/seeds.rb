# frozen_string_literal: true

NUMBER_OF_USERS = 100
NUMBER_OF_IP_ADDRESSES = 50
NUMBER_OF_POSTS = 200_000
NUMBER_OF_RATINGS = (NUMBER_OF_POSTS * 0.75).to_i

def generate_posts
  ip_addresses = []
  logins = []
  NUMBER_OF_IP_ADDRESSES.times { ip_addresses << Faker::Internet.ip_v4_address }
  NUMBER_OF_USERS.times { logins << Faker::Internet.username }

  NUMBER_OF_POSTS.times do
    json = {
      post: { title: Faker::Lorem.word,
              body: Faker::Lorem.sentence,
              ip: ip_addresses.sample,
              login: logins.sample }
    }.to_json
    escaped_json = json.tr('"', '"')

    system "curl -X POST -H 'Content-Type: application/json' " \
           "-d '#{escaped_json}' http://localhost:3000/api/v1/posts"
  end
end

def generate_ratings
  post_count = Post.count
  user_count = User.count
  NUMBER_OF_RATINGS.times do
    json = {
      rating: { post_id: rand(1..post_count), user_id: rand(1..user_count), value: rand(1..5) }
    }.to_json
    escaped_json = json.tr('"', '"')

    system "curl -X POST -H 'Content-Type: application/json' " \
           "-d '#{escaped_json}' http://localhost:3000/api/v1/posts/rate"
  end
end

generate_posts
generate_ratings
