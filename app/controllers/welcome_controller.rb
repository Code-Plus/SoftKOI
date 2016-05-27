class WelcomeController < ApplicationController
  layout "welcome"

  def index
    @sale_totals = Sale.all.count
    @produt_totals = Product.all.count
    @customer_totals = Customer.all.count
    @reserve_totals = Reservation.all.count
  end

end
