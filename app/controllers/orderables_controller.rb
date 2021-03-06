class OrderablesController < ApplicationController
  before_filter :authenticate
  before_filter :admin_user,  :except => :show
  before_filter :load_order_list_and_listing
  
  # GET /orderables
  # GET /orderables.xml
  def index
    @orderables = Orderable.paginate(:page => params[:page])
    @title = "Orderables"

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @orderables }
    end
  end

  # GET /orderables/1
  # GET /orderables/1.xml
  def show
    @orderable = Orderable.find(params[:id])
    @title = @orderable.product.name

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @orderable }
    end
  end

  # GET /orderables/new
  # GET /orderables/new.xml
  def new
    @orderable = Orderable.new
    @title = "New Orderable"

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @orderable }
    end
  end

  # GET /orderables/1/edit
  def edit
    @orderable = Orderable.find(params[:id])
    @title = "Edit Orderable"
  end

  # POST /orderables
  # POST /orderables.xml
  def create
    @orderable = Orderable.new(params[:orderable])

    respond_to do |format|
      if @orderable.save
        flash[:success] = 'Orderable was successfully created.'
        format.html { redirect_to([@order_list,@product_family,@order_listing,@orderable]) }
        format.xml  { render :xml => @orderable, :status => :created, :location => @orderable }
      else
        @title = "New Orderable"
        format.html { render :action => "new" }
        format.xml  { render :xml => @orderable.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /orderables/1
  # PUT /orderables/1.xml
  def update
    @orderable = Orderable.find(params[:id])

    respond_to do |format|
      if @orderable.update_attributes(params[:orderable])
        flash[:success] = 'Orderable was successfully updated.'
        format.html { redirect_to(order_list_product_family_order_listing_orderable_path(@order_list,@product_family,@order_listing,@orderable)) }
        format.xml  { head :ok }
      else
        @title = "Edit Orderable"
        format.html { render :action => "edit" }
        format.xml  { render :xml => @orderable.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /orderables/1
  # DELETE /orderables/1.xml
  def destroy
    @orderable = Orderable.find(params[:id])
    @orderable.destroy

    respond_to do |format|
      format.html { redirect_to(order_list_product_family_order_listing_orderables_url(@order_list,@product_family,@order_listing)) }
      format.xml  { head :ok }
    end
  end
  
  private
  def load_order_list_and_listing
    @order_listing = OrderListing.find(params[:order_listing_id])
    @order_list = OrderList.find(params[:order_list_id])
    @product_family = ProductFamily.find(params[:product_family_id])
  end
end
