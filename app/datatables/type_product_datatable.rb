class TypeProductDatatable < AjaxDatatablesRails::Base

  include AjaxDatatablesRails::Extensions::WillPaginate

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= ['type_products.name', 'type_products.description', 'type_products.state']
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= ['type_products.name', 'type_products.description', 'type_products.state']
  end

  private

  def data
    records.map do |record|
      [
        record.name,
        record.description,
        record.state
      ]
    end
  end

  def get_raw_records
    TypeProduct.all
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
