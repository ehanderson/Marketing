class CheckinsController < ApplicationController

  def show_all
    @brands = Brand.order(:name)
    @checkins = Checkin.all
  end

  def data
    @checkins = Checkin.order(:brand_id)
    respond_to do |format|
      format.html
      format.csv { send_data @checkins.to_csv }
      format.xls { send_data @checkins.to_csv(col_sep: "\t") }
    end
  end

  def destroy
    checkin = Checkin.find(params[:id])
    checkin.destroy
    redirect_to :show_checkin_data
  end

  def new
    checkin_time = Time.now
    oauth_token = current_user.oauth_token
    Checkin.create_checkin(oauth_token, checkin_time)
    render :new
  end

end

