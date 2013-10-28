class Fila < ActiveRecord::Base

  belongs_to :user

  before_create :gerar_link

  protected

  def gerar_link
    if new_record?
      self.link = loop do
        random_token = SecureRandom.urlsafe_base64(nil, false)
        break random_token unless Fila.exists?(link: random_token)
      end
    end
  end


end
