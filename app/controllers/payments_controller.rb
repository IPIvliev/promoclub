# encoding: UTF-8

class PaymentsController < ApplicationController
  include UsersHelper
  include ApplicationHelper

  def index
    profile_finish?

    @user = User.find(params[:id])
    @payment = Payment.new
    @period = Period.new

	@payments = initialize_grid(Payment, :conditions => ['user_id = ?', current_user.id])    
  end

def show
  @payment = Payment.find(params[:id])

  respond_to do |format|
    format.html
    format.pdf { render :layout => false }
  end
end

  def create
  	@payment = current_user.payments.build(params[:payment])
  	@payment.save
    if @payment.status == 1
      redirect_to payments_user_path(current_user)
    else
      redirect_to payments_user_path(current_user, :payment => @payment, :amount => @payment.amount)
    end
  end

  def create_essentials
    @payment = current_user.payments.build(params[:payment])
    @payment.save
    redirect_to payments_user_path(current_user, :payment => @payment, :amount => @payment.amount)
  end

  def destroy
    @payment = Payment.find(params[:id])
    @payment.destroy

    redirect_to payments_user_path(@payment.user)

  end

  def new_period
    @amount = params[:period][:finish_date].to_i
    @price = @amount * Settings.period_price.to_i

    if current_user.periods.last.blank?
      @finish = Date.today + @amount.months    
    else  
      if current_user.periods.last.finish_date > Date.today
        @finish = current_user.periods.last.finish_date + @amount.months
      else
        @finish = Date.today + @amount.months 
      end
    end
      

      if @price <= current_user.pocket
        @period = current_user.periods.build(:finish_date => @finish)
        flash[:success] = "Вы успешно оплатили доступ к базе данных контактов на #{@amount}
          #{Russian.pluralize(@amount, "месяц", "месяца", "месяцев")}."
        @period.save
        pay(@price)
      else
        flash[:danger] = "На вашем счёте недостаточно средств для оплаты выбранного периода.
          Рекомендуем Вам <strong><a href='/users/#{current_user.id}/payments' class='red'>пополнить счёт</a></strong>.".html_safe
      end

      redirect_to :back
  end

  def create_calculation
    @calculation = current_user.build_calculation(params[:calculation])

    if @calculation.save
      flash[:success] = "Вы успешно добавили реквизиты. Теперь Вы можете заказать счёт для оплаты."
    else
      flash[:danger] = "При добавлении реквизитов произошла ошибка. Проверьте правильность реквизитов"
    end

    redirect_to payments_user_path(current_user)
  end

end