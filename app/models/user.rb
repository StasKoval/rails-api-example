class User < ActiveRecord::Base
  enum role: [ :guest, :user, :admin ]

  has_many :article
  before_create :generate_token

  def generate_token
    self.token = Digest::SHA1.hexdigest([Time.now, rand].join)
  end

end
