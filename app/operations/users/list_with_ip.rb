# frozen_string_literal: true

module Users::ListWithIP
  def self.call(limit)
    return [] if limit.zero?

    ips_with_array_of_logins = {}
    logins_with_ips(limit).each do |hash|
      ips_with_array_of_logins[hash[:ip]] ||= []
      ips_with_array_of_logins[hash[:ip]] << hash[:login]
    end

    ips_with_array_of_logins
  end

  def self.logins_with_ips(limit)
    users = User.includes(:posts).select("users.id", "users.login").limit(limit)

    result = users.map do |user|
      user.posts.map do |post|
        { login: user.login, ip: post.ip.to_s }
      end
    end

    result.flatten
  end

  private_class_method :logins_with_ips
end
