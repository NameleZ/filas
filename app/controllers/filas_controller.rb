class FilasController < ApplicationController
  before_action :set_fila, only: [:show, :edit, :update, :acompanhar_fila]
  before_filter :authenticate_user!

  def index
    @filas = Fila.where(user: current_user)
  end

  def new
    @fila = Fila.new
  end

  def create
    @fila = Fila.new(fila_params)

    @fila.user = current_user
    @fila.posicao_atual = 0

    respond_to do |format|
      if @fila.save
        format.html { redirect_to action: 'index' }
        format.json { render action: 'show', status: :created, location: @fila }
      else
        format.html { render action: 'new' }
        format.json { render json: @fila.errors, status: :unprocessable_entity }
      end
    end
  end

  def acompanhar_fila

    if @fila.user != current_user
      redirect_to action: 'index'
    end

  end

  def atualizar_senha

    fila = Fila.find(params[:id])

    if fila.user == current_user

      fila.posicao_atual = params[:posicao_atual]
      fila.save
    end

    render :json => {:status => :ok}
  end

  private
  def set_fila
    @fila = Fila.find(params[:id])
  end

  def fila_params
    params.require(:fila).permit(:nome)
  end
end