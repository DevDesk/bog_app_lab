class CreaturesController < ApplicationController

  def index
    @creatures = Creature.all
  end

  def new
    @creature = Creature.new
    # redirect_to @creature
  end

  def create
    @creature = Creature.create(creature_params)
    redirect_to '/'
    # redirect_to '/' + @creature.id
  end

  def creature_params
    creature_params = params.require(:creature).permit(:name, :description)
  end

  # def creature_id
  #   creature_id = @creatures.find id=2
  # end

  def show
    @creature = Creature.find(params[:id])
    @search = Creature.find(params[:id]).name
        list = flickr.photos.search :text => @search, :sort => "relevance"
      @results = list.map do |photo|
        FlickRaw.url_m(photo)
      end
  end

  def results
    @search = Creature.find(params[:id]).name
    # list = flickr.photos.search :text => @search, :sort => "relevance"
    #   @results = list.map do |photo|
    #     FlickRaw.url_m(photo)
    #   end
  end

  def edit
    @creature = Creature.find(params[:id])
  end

  def update
    @creature = Creature.find(params[:id])
    @creature.update_attributes(creature_params)

    redirect_to "/creatures/#{params[:id]}"
  end

  def destroy
    @creature = Creature.find(params[:id]).destroy
    redirect_to '/'
  end

end