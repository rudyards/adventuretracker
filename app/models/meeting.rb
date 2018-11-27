class Meeting < ApplicationRecord
    belongs_to :game

    validates :place, presence: true, length: { maximum: 50 }

    scope :future, -> { where("time + interval '1 second'*duration*3600 > clock_timestamp()").order('time desc')}
end
