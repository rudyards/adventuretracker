class Meeting < ApplicationRecord
    belongs_to :game

    validates :place, presence: true, length: { maximum: 50 }

end
