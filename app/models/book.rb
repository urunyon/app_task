class Book < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user
  has_many :book_comments, dependent: :destroy
  has_many :view_counts, dependent: :destroy
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}
  validates :tag,presence:true
  
  #投稿カウント共用
  scope :created_today, -> { where(created_at: Time.zone.now.all_day) } 
    scope :created_yesterday, -> { where(created_at: 1.day.ago.all_day) } 
    #グラフ用
    scope :created_2days, -> { where(created_at: 2.days.ago.all_day) } 
    scope :created_3days, -> { where(created_at: 3.days.ago.all_day) } 
    scope :created_4days, -> { where(created_at: 4.days.ago.all_day) } 
    scope :created_5days, -> { where(created_at: 5.days.ago.all_day) } 
    scope :created_6days, -> { where(created_at: 6.days.ago.all_day) } 
    #リスト用
    scope :created_this_week, -> { where(created_at: 6.day.ago.beginning_of_day..Time.zone.now.end_of_day) } 
    scope :created_last_week, -> { where(created_at: 2.week.ago.beginning_of_day..1.week.ago.end_of_day) } 
  
  scope :latest, -> {order(created_at: :desc)}
  scope :old, -> {order(created_at: :asc)}
  scope :star_count, -> {order(star: :desc)}
  
  def self.search_for(content, method)
    if method == 'perfect'
      Book.where(title: content)
    elsif method == 'forward'
      Book.where('title LIKE ?', content + '%')
    elsif method == 'backward'
      Book.where('title LIKE ?', '%' + content)
    else
      Book.where('title LIKE ?', '%' + content + '%')
    end
  end

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end
  
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
end
