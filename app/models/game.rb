class Game < ApplicationRecord
    has_many :memberships, -> { order(:created_at)}, :dependent => :destroy
    has_many :meetings
    has_many :knocks, -> { order(:created_at)}, :dependent => :destroy
    has_many :users, through: :memberships
    has_many :comments, -> { order 'created_at desc'}
    
    validates :name, presence: true, length: { maximum: 50 }, uniqueness: true
    validates :description, presence: true, length: { maximum: 200 }, uniqueness: false

end
