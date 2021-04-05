class RailsBuhinsController < ApplicationController


  ##before_action :set_rails_buhin, only: %i[ show edit update destroy ]
  @@update_id
  # GET /rails_buhins or /rails_buhins.json
  def index

  end

######################################################################
#
#     　　 マスタ設定選択
#
######################################################################
  def select

     if params[:targets] == 'buhin_master' then

        redirect_to rails_buhins_show_path
        return
     end
     if params[:targets] == 'buhin_kousei' then

        redirect_to rails_buhin_kouseis_path
        return
     end
     if params[:targets] == 'kisyu_group' then

        redirect_to rails_kisyu_groups_path
        return
     end
  end

  # GET /rails_buhins/1 or /rails_buhins/1.json
  def show
    ####@rails_buhins = RailsBuhin.all
    @rails_buhins = RailsBuhin.all.order(updated_at: :DESC)
    ####@jibu = RailsJibu.all
    @start_day_pckt=RailsKisyuPckt.select(:start_day_pckt).distinct.order(start_day_pckt: :ASC)
  end

  # GET /rails_buhins/new
  def new
  
    @rails_buhin = RailsBuhin.new
    
    # 事部
    @jibu = RailsJibu.all
    
    #####@hinmeis = ActiveRecord::Base.connection.select_all('select distinct hinmei from rails_boms order by hinmei').to_hash
    #####@hinmei=[]
    #####@hinmeis.each do |h|
        #####@hinmei << h.fetch("hinmei").slice(0..15)
    #####end
    
    # パケット
    @start_day_pckt = RailsKisyuPckt.select(:start_day_pckt).distinct.order(start_day_pckt: :ASC)
  end

  # GET /rails_buhins/1/edit
  def edit
  
    @rails_buhin = RailsBuhin.find_by(id: params[:format])
    
    ##@jibu = RailsJibu.all
    
    ##@hinmeis = ActiveRecord::Base.connection.select_all('select distinct hinmei from rails_boms order by hinmei').to_hash
    ##@hinmei=[]
    ##@hinmeis.each do |h|
        ##@hinmei << h.fetch("hinmei").slice(0..15)
    ###end
    
    @start_day_pckt = RailsKisyuPckt.select(:start_day_pckt).distinct.order(start_day_pckt: :ASC)
     
  end

  # POST /rails_buhins or /rails_buhins.json
  def create
    #RailsBuhin.create(jibu: params[:rails_buhin][:jibu],
                      #buhin: params[:rails_buhin][:buhin],
                      #ruisin: params[:rails_buhin][:ruisin],
                      #ryakumei: params[:rails_buhin][:ryakumei],
                      #anzen_start: params[:rails_buhin][:anzen_start],
                      #anzen_pckt: params[:rails_buhin][:n_pckt],
                      #hoju_lt: params[:rails_buhin][:hoju_lt])

    @rails_buhin = RailsBuhin.new(rails_buhin_params)
    @rails_buhin.save!

    ######  累進のＮＵＬＬ対応：累進のＮＵＬＬ値を空白２文字に変換（ＳＡＰ材料表の累進に合わせる）
    update_ruisin
    
    ###### 品名をＢＯＭから取得する
    get_hinmei

    redirect_to rails_buhins_show_path,notice:"#{params[:rails_buhin][:buhin]}を登録しました。"

  end

  # PATCH/PUT /rails_buhins/1 or /rails_buhins/1.json
  def update
    @rails_buhin = RailsBuhin.find(params[:id])
    @rails_buhin.update!(rails_buhin_params)
    ######  累進のＮＵＬＬ対応：累進のＮＵＬＬ値を空白２文字に変換（ＳＡＰ材料表の累進に合わせる）
    update_ruisin

    redirect_to rails_buhins_show_path,notice:"更新しました。"
  end

  # DELETE /rails_buhins/1 or /rails_buhins/1.json
  def destroy
    rails_buhin = RailsBuhin.find(params[:id])
    rails_buhin.destroy
    redirect_to rails_buhins_show_path, notice: "「#{rails_buhin.buhin}」を削除しました。"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rails_buhin
      @rails_buhin = RailsBuhin.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def rails_buhin_params
      params.require(:rails_buhin).permit(:id,:jibu, :buhin, :ruisin, :hoju_lt, :start_anzen_zaiko, :start_day_pckt)
    end

    #
    # 累進のＮＵＬＬ値を空白２文字に変換する
    # 01_UPDATE_rails_buhins_for_ruisin_is_blank
    #
    def update_ruisin
       sql=""
       file=File.open("./sql/10_マスタ生成/01_UPDATE_from_bom_to_rails_buhins_for_ruisin_is_blank.sql")
       sql = file.read
       file.close

       ActiveRecord::Base.connection.execute(sql)

    end

    def get_hinmei
       sql=""
       file=File.open("./sql/10_マスタ生成/03_UPDATE_from_bom_to_rails_buhins_for_hinmei.sql")
       sql = file.read
       file.close

       ActiveRecord::Base.connection.execute(sql)

    end




end
