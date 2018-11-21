class Game < ApplicationRecord
    has_many :memberships, -> { order(:created_at)}, :dependent => :destroy
    has_many :knocks, -> { order(:created_at)}, :dependent => :destroy
    has_many :users, through: :memberships
    
    validates :name, presence: true, length: { maximum: 50 }, uniqueness: true
    validates :description, presence: true, length: { maximum: 200 }, uniqueness: false

end
