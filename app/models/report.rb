class Report 
  attr_reader :date_from, :date_to

  def initialize(params)
    params ||={}
    @date_from = parsed_date(params[:date_from], 7.days.ago.to_datetime.to_s)
    @date_to = parsed_date(params[:date_to], DateTime.now.to_s)
  end

  def search_date_products
    puts @date_from
    puts @date_to
    Product.where('created_at BETWEEN ? AND ?',@date_from,@date_to)
  end


  private

  def parsed_date(date_string, default)
    DateTime.parse(date_string)
  rescue ArgumentError, TypeError
    default
  end
end
