
class ProdudctsController < ApplicationController
  before_action :set_produdct,
    only: [:show, :edit, :update, :destroy]

  # GET /produdcts
  def index
    @produdcts = Produdct.all
    respond_with(@produdcts)
  end

  # GET /produdcts/1
  def show
    respond_with(@produdct)
  end

  # GET /produdcts/new
  def new
    @produdct = Produdct.new
    respond_with(@produdct)
  end

  # GET /produdcts/1/edit
  def edit
  end

  # POST /produdcts
  def create
    @produdct = Produdct.new(produdct_params)
    @produdct.save
    respond_with(@produdct)
  end

  # PATCH/PUT /produdcts/1
  def update
    @produdct.update(produdct_params)
    respond_with(@produdct)
  end

  # DELETE /produdcts/1
  def destroy
    @produdct.destroy
    respond_with(@produdct)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_produdct
    @produdct = Produdct.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def produdct_params
    params.require(:produdct).
      permit(:name)
  end
end
