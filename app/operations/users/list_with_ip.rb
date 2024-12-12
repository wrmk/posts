# frozen_string_literal: true

module Users::ListWithIP
  def self.call(limit)
    return [] if limit.zero?

    users = User.includes(:posts).select("users.id", "users.login").limit(limit)

    ips_with_array_of_logins = {}
    users.each do |user|
      user.posts.each do |post|
        ip = post.ip.to_s
        ips_with_array_of_logins[ip] ||= []
        ips_with_array_of_logins[ip] |= [user.login]
      end
    end

    ips_with_array_of_logins
  end
end
