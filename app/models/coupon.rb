class Coupon < ActiveRecord::Base
  attr_reader :sale_id
  has_many :item_coupons
  before_create :set_date
	before_update :set_updated_at


  validates :amount, presence: true

  include AASM
    aasm column: "state" do

      state :noUtilizado, :initial => true
      state :utilizado


      event :utilizado do
        transitions from: :noUtilizado, to: :utilizado
      end
    end

  def name
    usuario  = User.where(id: self.user_id)
    usuario.each do |user_create_coupon|
      usuario = user_create_coupon.name
    end
    return usuario
  end
  private
  def set_date
    self.created_at = Time.now.in_time_zone("Bogota")
    self.updated_at = Time.now.in_time_zone("Bogota")
  end

  def set_updated_at
    self.updated_at = Time.now.in_time_zone("Bogota")
  end

end
