class BlogPost < ApplicationRecord
    has_one_attached :cover_image
    has_rich_text :content

    belongs_to :user

    validates :title, presence: true
    validates :content, presence: true
    validates :user, presence: true
    
    scope :sorted, ->{ order(published_at: :desc, updated_at: :desc) }
    scope :draft, -> { where(published_at: nil) }
    scope :published, -> { where("published_at <= ?", Time.current) }
    scope :scheduled, -> { where("published_at > ?", Time.current) }
    scope :created_by, ->(user) { where(user:) }

    def draft?
        published_at.nil?
    end

    def published?
        published_at? && published_at <= Time.current
    end

    def scheduled?
        published_at? && published_at > Time.current
    end
end
