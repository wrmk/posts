# frozen_string_literal: true

module Posts::Add
  def self.call(post_params:, user_params:)
    post = Post.new(post_params)

    if user_params[:login].blank?
      post.errors.add(:login, "can't be blank")
      return post
    end

    ActiveRecord::Base.transaction do
      post.user = User.find_or_create_by(login: user_params[:login])

      post.save

      raise ActiveRecord::Rollback unless post.persisted?
    end

    post
  end
end
