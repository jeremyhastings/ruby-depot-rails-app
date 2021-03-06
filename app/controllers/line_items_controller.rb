class LineItemsController < ApplicationController
  skip_before_action :authorize, only: :create

  # Uses CurrentCart module from concerns.  Added Cart on December 9th, 2019.
  include CurrentCart
  before_action :set_cart, only: [:create]

  before_action :set_line_item, only: [:show, :edit, :update, :destroy]

  # GET /line_items
  # GET /line_items.json
  def index
    @line_items = LineItem.all
  end

  # GET /line_items/1
  # GET /line_items/1.json
  def show
  end

  # GET /line_items/new
  def new
    @line_item = LineItem.new
  end

  # GET /line_items/1/edit
  def edit
  end

  # POST /line_items
  # POST /line_items.json
  def create
    # Use params object to get product_id and get product.  December 9th, 2019.
    product = Product.find(params[:product_id])
    # Make the line_item with add_product method from cart. December 9th, 2019.
    @line_item = @cart.add_product(product)
    # Pass product into @cart.line_items.build to establish relationship between product and cart.  December 9th, 2019.
    #@line_item = @cart.line_items.build(product: product)
    #@line_item = LineItem.new(line_item_params)

    respond_to do |format|
      if @line_item.save
        # Modified line to redirect to @line_item.cart instead of @line_item.  December 9th, 2019.
        # Modified to redirect to store index after Cart was moved to sidebar.  December 9th, 2019.
        format.html { redirect_to store_index_url } #, notice: 'Line item was successfully created.' } Removed 12/9/19.
        # Added for Ajax.  December 9th, 2019 TODO: Look up more on Ajax js.
        format.js { @current_item = @line_item } # Added so controller knows which item is most recent for animation.
        format.json { render :show, status: :created, location: @line_item }
      else
        format.html { render :new }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /line_items/1
  # PATCH/PUT /line_items/1.json
  def update
    respond_to do |format|
      if @line_item.update(line_item_params)
        format.html { redirect_to @line_item, notice: 'Line item was successfully updated.' }
        format.json { render :show, status: :ok, location: @line_item }
      else
        format.html { render :edit }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /line_items/1
  # DELETE /line_items/1.json
  def destroy
    @line_item.destroy
    respond_to do |format|
      format.html { redirect_to line_items_url, notice: 'Line item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_line_item
      @line_item = LineItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def line_item_params
      # Removed cart_id from permitted line items.  Protect access to carts.  Added December 9th, 2019.
      params.require(:line_item).permit(:product_id)
    end
end
