class RailsKisyuPcktsController < ApplicationController
  before_action :set_rails_kisyu_pckt, only: %i[ show edit update destroy ]

  # GET /rails_kisyu_pckts or /rails_kisyu_pckts.json
  def index
    @rails_kisyu_pckts = RailsKisyuPckt.all
  end

  # GET /rails_kisyu_pckts/1 or /rails_kisyu_pckts/1.json
  def show
  end

  # GET /rails_kisyu_pckts/new
  def new
    @rails_kisyu_pckt = RailsKisyuPckt.new
  end

  # GET /rails_kisyu_pckts/1/edit
  def edit
  end

  # POST /rails_kisyu_pckts or /rails_kisyu_pckts.json
  def create
    @rails_kisyu_pckt = RailsKisyuPckt.new(rails_kisyu_pckt_params)

    respond_to do |format|
      if @rails_kisyu_pckt.save
        format.html { redirect_to @rails_kisyu_pckt, notice: "Rails kisyu pckt was successfully created." }
        format.json { render :show, status: :created, location: @rails_kisyu_pckt }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @rails_kisyu_pckt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rails_kisyu_pckts/1 or /rails_kisyu_pckts/1.json
  def update
    respond_to do |format|
      if @rails_kisyu_pckt.update(rails_kisyu_pckt_params)
        format.html { redirect_to @rails_kisyu_pckt, notice: "Rails kisyu pckt was successfully updated." }
        format.json { render :show, status: :ok, location: @rails_kisyu_pckt }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @rails_kisyu_pckt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rails_kisyu_pckts/1 or /rails_kisyu_pckts/1.json
  def destroy
    @rails_kisyu_pckt.destroy
    respond_to do |format|
      format.html { redirect_to rails_kisyu_pckts_url, notice: "Rails kisyu pckt was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rails_kisyu_pckt
      @rails_kisyu_pckt = RailsKisyuPckt.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def rails_kisyu_pckt_params
      params.require(:rails_kisyu_pckt).permit(:kisyumei)
    end
end
