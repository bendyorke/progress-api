class Token < ActiveRecord::Base
  belongs_to :user

  before_save :generate_hex!, if: Proc.new { hex.blank? }

  scope :active, -> { where(active: 1) }

  protected
    def generate_hex!
      begin
        self.hex = SecureRandom.hex
      end while self.class.exists? hex: hex
    end
end
