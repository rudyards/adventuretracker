class Game < ApplicationRecord
    has_many :memberships
    has_many :requests
    has_many :users, through: :memberships
    
    validates :name, presence: true, length: { maximum: 50 }, uniqueness: true
    validates :description, presence: true, length: { maximum: 200 }, uniqueness: false

end
