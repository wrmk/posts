# frozen_string_literal: true

module Posts::Add
  def self.call(post_params:, user_params:)
    post = initialize_post(post_params:, user_params:)

    return post if post.errors.present?

    ActiveRecord::Base.transaction do
      post.user = User.find_or_create_by(login: user_params[:login])

      post.save

      raise ActiveRecord::Rollback unless post.persisted?
    end

    post
  end

  def self.initialize_post(post_params:, user_params:)
    post = Post.new(post_params)

    post.errors.add(:login, "can't be blank") if user_params[:login].blank?

    post.errors.add(:ip, "invalid format") if post_params[:ip].present? && post.ip.blank?

    post
  end

  private_class_method :initialize_post
end
