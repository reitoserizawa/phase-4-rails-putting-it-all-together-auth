class User < ApplicationRecord
    has_secure_password
    has_many :recipes

    validates :username, presence: true, uniqueness: true
    # validate the user's username to ensure that it is present and unique (no two users can have the same username)

end
