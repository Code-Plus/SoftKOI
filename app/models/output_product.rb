class OutputProduct < ActiveRecord::Base

   belongs_to :product
   validates :product_id, presence: true
   validates :stock, presence: true, numericality: {greater_than: 0}
   after_save :update_stock
   validate :update_stock


   def product=(value)
      @product=value
   end


   private
   def update_stock
      stock_product= product.stock

      if self.stock.nil?

      elsif (stock_product-self.stock)<0
         self.errors.add(:stock ,"--->No hay suficientes productos para dar de baja")
      else
         
         product.update(stock: stock_product - self.stock)
      end
   end




end
