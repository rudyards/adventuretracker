class User < ApplicationRecord
    attr_accessor :remember_token, :reset_token
    before_save   :downcase_email

    has_many :memberships
    has_many :meetings, through: :games
    has_many :games, through: :memberships

    before_save { self.email = email.downcase }
    validates :username,  presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: false }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 },
        format: { with: VALID_EMAIL_REGEX },
        uniqueness: { case_sensitive: false }
    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }

    def self.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end


    def self.new_token
        SecureRandom.urlsafe_base64
    end


    def remember
        self.remember_token = User.new_token
        update_attribute(:remember_digest, User.digest(remember_token))
    end


    def forget
        update_attribute(:remember_digest, nil)
    end

    def gm_list
        return self.games.where(gm_id: self.id)
    end

    def play_list
        return self.games.where.not(gm_id: self.id)
    end
    
    def create_reset_digest
        self.reset_token = User.new_token
        update_attribute(:reset_digest,  User.digest(reset_token))
        update_attribute(:reset_sent_at, Time.zone.now)
      end

    def send_password_reset_email
      UserMailer.password_reset(self).deliver_now
    end

    def password_reset_expired?
      reset_sent_at < 2.hours.ago
    end

    private
        def downcase_email
          self.email = email.downcase
        end

end
