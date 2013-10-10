class FilasController < ApplicationController
  before_action :set_fila, only: [:show, :edit, :update, :acessar_atualizar_senha]
  before_filter :authenticate_user!, except: [:acompanhar_fila, :acessar_acompanhamento_fila]

  @@filas_hash = Hash.new

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

        @fila.link = (Digest::MD5.hexdigest @fila.id.to_s << @fila.nome)
        @fila.save

        format.html { redirect_to action: 'index' }
        format.json { render action: 'show', status: :created, location: @fila }
      else
        format.html { render action: 'new' }
        format.json { render json: @fila.errors, status: :unprocessable_entity }
      end
    end
  end

  def acessar_atualizar_senha

    if @fila.user != current_user
      redirect_to action: 'index'
    end

  end

  def atualizar_senha

    fila = Fila.find(params[:id])

    if fila.user == current_user

      fila.posicao_atual = params[:posicao_atual]
      fila.save

      @@filas_hash[fila.link] = fila.posicao_atual
    end

    render :json => {:status => :ok}
  end

  def acessar_acompanhamento_fila

    @fila = Fila.where(link: params[:id]).take!

    render :layout => false

  end

  def acompanhar_fila

    render :json => {:status => :ok, :posicao => @@filas_hash[params[:id]].to_json}

  end

  private
  def set_fila
    @fila = Fila.find(params[:id])
  end

  def fila_params
    params.require(:fila).permit(:nome)
  end
end