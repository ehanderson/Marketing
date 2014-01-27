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
    if current_user
      checkin_time = Time.now
      oauth_token = current_user.oauth_token
      Checkin.create_checkin(oauth_token, checkin_time)
      redirect_to ('/'), notice: 'Manual Checkin Complete'
    else
      redirect_to ('/'), notice: 'Please Sign in with Facebook First'
    end
  end

end

