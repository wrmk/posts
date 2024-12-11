# frozen_string_literal: true

module Posts::Top
  def self.call(limit)
    return [] if limit.zero?

    posts = Post.includes(:ratings).select("posts.id", "posts.title", "posts.body")

    posts_with_average_rating = posts.map do |post|
      { post.average_rating => post }
    end

    sorted_posts_with_average_rating =
      posts_with_average_rating.sort_by { _1.keys.first }.reverse

    sorted_posts_with_average_rating.first(limit).map { _1.values.first }
  end
end
