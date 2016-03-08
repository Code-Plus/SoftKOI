class OutputProduct < ActiveRecord::Base

   belongs_to :product
   validates :product_id, :stock, presence: true
   before_validation :update_stock


   def product=(value)
      @product=value
   end


   private
   def update_stock
      stock_product= product.stock
      stock_out=self.stock

      if (stock_product-stock_out)<0
         self.errors.add(:stock ,"--->No hay suficientes productos para dar de baja")
      else
         product.update(stock: stock_product - stock_out)
      end
   end




end
