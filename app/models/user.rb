class User < ApplicationRecord
  has_secure_password
  #これを入れることで、suthenticatedメソッドが使用できるようになる。

  validates :name ,presence: true
  validates :email , presence: true, uniqueness: true

  has_many :tasks
end
