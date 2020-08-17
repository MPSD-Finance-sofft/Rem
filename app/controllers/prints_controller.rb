class PrintsController < ApplicationController
  before_action :find_accord

  def delivery_notes
    @clients = @accord.clients
    @realty_adres = @accord.realty.first.address
    respond_to do |format|
      format.pdf do
        render  pdf: "dorucenka", :page_height => '4.9in', :page_width => '6.9in', :encoding => 'UTF-8', :margin => { :top => 0, :bottom => 0, :left => 0, :right => 0}
      end
    end
  end


  def find_accord
      @accord = Accord.find(params[:accord_id])
  end
end
