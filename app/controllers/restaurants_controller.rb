class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: [:show, :edit, :update, :destroy]

  #definition
  $dataCount  = 0
  $nowShowCount  = 0
  $maxShowCount = 3
  $nowChoice = nil
 # $price = 4000

  # GET /restaurants
  # GET /restaurants.json
  def index
    @restaurants = []
    if params['choice'] == nil then
    @restaurants = Restaurant.order("rank DESC").limit($maxShowCount)
   else
    cond = params['choice'];
    choiceCond cond,false
   end
  end
  # GET /restaurants/1
  # GET /restaurants/1.json

  def choiceCond  cond,isNext
    case  cond
     when 'date'
      if isNext != "true" then clearDataCount end
      getDateData
      when 'fever'
      if isNext != "true" then clearDataCount end
      getfeverData
      when 'rich'
      if isNext != "true" then clearDataCount end
      getRichData
      when 'poor'
      if isNext != "true" then clearDataCount end
      getPoorData
      when 'conpa'
      if isNext != "true" then clearDataCount end
      getConpaData
      when 'shuffle'
      if isNext != "true" then clearDataCount end
      getShuffleData
      when 'next'
       $nowShowCount = $nowShowCount +  $maxShowCount
       choiceCond $nowChoice,true
      else
       @restaurants = Restaurant.all
     end
     if @restaurants_count  == 0 then
     @restaurants = Restaurant.all end
  end

  def getDateData
   @restaurants = Restaurant.where(:sdate =>"1").order("rank DESC").limit($maxShowCount)
   showCountUp
   $nowChoice = 'date'
  end
  def getfeverData
    @restaurants = Restaurant.where(:sfever =>"1").order("rank DESC").limit($maxShowCount)
    showCountUp
    $nowChoice = 'fever'
  end
  def getRichData
    changePrice 'up'
    topPrice   = $price + 1000
    underPrice = $price - 1000
    @restaurants = Restaurant.where("price >= ?  and price <= ? ", underPrice, topPrice).order("rank DESC").limit($maxShowCount)
    @restaurants_count = Restaurant.where("price >= ?  and price <= ? ", underPrice, topPrice).count
    showCountUp
    $nowChoice = 'rich'
  end
  def getPoorData
    changePrice 'down'
    topPrice   = $price + 1000
    underPrice = $price - 1000
    @restaurants = Restaurant.where("price >= ?  and price <= ? ", underPrice, topPrice).order("rank DESC").limit($maxShowCount)
    @restaurants_count = Restaurant.where("price >= ?  and price <= ? ", underPrice, topPrice).count
    showCountUp
    $nowChoice = 'poor'
  end
  def getConpaData
    @restaurants = Restaurant.where(:sconpa =>"1").order("rank DESC").limit($maxShowCount)
    showCountUp
    $nowChoice = 'fever'
  end
  def getShuffleData
    @restaurants = Restaurant.find(Restaurant.pluck(:id).shuffle[0..$maxShowCount-1])
    showCountUp
    $nowChoice = 'shuffle'
  end

  def show
  end

  #価格帯を変更する
def changePrice updown
  if $price == nil
    then $price  = 4000
   end
  if  updown == "up" then
    $price =  $price + 1000
    else
    $price =  $price - 1000
       if $price <= 0  then
          $price = 1000 ;
        end
    end
  end

#変数初期化
def clearDataCount
  $dataCount  = 0
  $nowShowCount  = 0
end

def showCountUp
  $nowShowCount  = $nowShowCount + $maxShowCount
end

def nextData data
  data  = data + $maxShowCount
return data
end



  # GET /restaurants/new
  def new
    @restaurant = Restaurant.new
  end

  # GET /restaurants/1/edit
  def edit
  end

  # POST /restaurants
  # POST /restaurants.json
  def create
    @restaurant = Restaurant.new(restaurant_params)

    respond_to do |format|
      if @restaurant.save
        format.html { redirect_to @restaurant, notice: 'Restaurant was successfully created.' }
        format.json { render :show, status: :created, location: @restaurant }
      else
        format.html { render :new }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /restaurants/1
  # PATCH/PUT /restaurants/1.json
  def update
    respond_to do |format|
      if @restaurant.update(restaurant_params)
        format.html { redirect_to @restaurant, notice: 'Restaurant was successfully updated.' }
        format.json { render :show, status: :ok, location: @restaurant }
      else
        format.html { render :edit }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /restaurants/1
  # DELETE /restaurants/1.json
  def destroy
    @restaurant.destroy
    respond_to do |format|
      format.html { redirect_to restaurants_url, notice: 'Restaurant was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_restaurant
      @restaurant = Restaurant.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def restaurant_params
      params.require(:restaurant).permit(:name, :address, :rank, :URL, :TEL, :price, :fjpn, :fchina, :fitarian,:ffranch,:fspanish, :fother, :sdate, :sconpa, :sfever, :sother, :extraText1, :extraText2, :extraText3)
    end
end
