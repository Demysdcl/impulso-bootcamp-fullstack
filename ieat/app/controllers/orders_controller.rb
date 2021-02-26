class OrdersController < ApplicationController
  def create
    # binding.pry
    @order = Order.new(order_params)
    @order.user_id = current_user.id
    @order.status = :pending
    if @order.save
      flash[:notice] = 'Pedido criado com sucesso'
      RestaurantNotifierJob.perform_later
    else
      flash[:notice] = 'Erro ao criar pedido'
    end

    redirect_to root_path
  end

  private

  def order_params
    params.permit(:product_id)
  end
end