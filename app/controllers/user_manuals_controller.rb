class UserManualsController < ApplicationController

  def view_manual
    File.open('ManualdeUsuarioSOFTKOI.pdf', 'r') do |f|
      send_data f.read.force_encoding('BINARY'), :filename => "ManualdeUsuarioSOFTKOI.pdf", :type => "application/pdf", :disposition => "attachment"
    end
  end

end
