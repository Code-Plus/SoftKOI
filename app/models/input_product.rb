class InputProduct < ActiveRecord::Base

   belongs_to :product  
   validates :product_id, presence: true
   validates :stock, presence: true, numericality: {greater_than: 0}
   after_save :update_stock
   validate :update_stock
   


   #Getter de los valores de productos para el stock
   def product=(value)
      @product=value
   end

   private
   
   #Actualizar el stock del producto al que se le hace la entrada
   def update_stock
      stock_product= product.stock
      if self.stock.nil?
      else 
         product.update(stock: stock_product + self.stock)
      end
   end
end
