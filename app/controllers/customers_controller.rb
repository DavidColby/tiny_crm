class CustomersController < ApplicationController
  include CableReady::Broadcaster
  before_action :set_customer, only: [:show, :edit, :update, :destroy]

  # GET /customers
  def index
    @customers = Customer.all
  end

  # GET /customers/1
  def show
  end

  # GET /customers/new
  def new
    html = render_to_string(partial: 'form', locals: { customer: Customer.new })
    render operations: cable_car
      .outer_html('#customer_form', html: html)
      .dispatch_event(name: 'modal:loaded')
  end

  # GET /customers/1/edit
  def edit
    html = render_to_string(partial: 'form', locals: { customer: @customer })
    render operations: cable_car
      .outer_html('#customer_form', html: html)
      .dispatch_event(name: 'modal:loaded')
  end
  # POST /customers
  def create
    @customer = Customer.new(customer_params)

    if @customer.save
      html = render_to_string(partial: 'customer', locals: { customer: @customer })
      render operations: cable_car
        .append('#customers', html: html)
        .dispatch_event(name: 'submit:success')
    else
      html = render_to_string(partial: 'form', locals: { customer: @customer })
      render operations: cable_car
        .inner_html('#customer_form', html: html), status: :unprocessable_entity
    end
  end

  # PATCH/PUT /customers/1
  def update
    if @customer.update(customer_params)
      html = render_to_string(partial: 'customer', locals: { customer: @customer })
      render operations: cable_car
        .replace("#customer-#{@customer.id}", html: html)
        .dispatch_event(name: 'submit:success')
    else
      html = render_to_string(partial: 'form', locals: { customer: @customer })
      render operations: cable_car
        .inner_html('#customer_form', html: html), status: :unprocessable_entity
    end
  end

  # DELETE /customers/1
  def destroy
    @customer.destroy
    redirect_to customers_url, notice: 'Customer was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = Customer.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def customer_params
      params.require(:customer).permit(:name)
    end
end
