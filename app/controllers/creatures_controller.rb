class CreaturesController < ApplicationController

  def index
    @creatures = Creature.all
  end

  def new
    @creature = Creature.new
    @tags = Tag.all
    # redirect_to @creature
  end

  def create
    if @creature = Creature.create(creature_params)
      @tags = Tag.all
       # Creature.create(creature_params)
      flash[:success] = "Your creature has been added"

      @creature.tags.clear                 #or below?
      tags = params[:creature][:tag_ids]
      tags.each do |tag_id|
        @creature.tags << Tag.find(tag_id) unless tag_id.blank?
      end

      redirect_to creatures_path

      # redirect_to '/'
      # redirect_to '/' + @creature.id
    else
      @tags = Tag.all  #or above?
      render :new
    #  @creature.tags.clear                 #or above?
    # tags = params[:creature][:tags_ids]
    # tags.each do |tag_id|
    #   @creature.tags << Tag.find(tag_id) unless tag_id.blank?
    # end

    end
  end

  def creature_params
    creature_params = params.require(:creature).permit(:name, :description)
  end

  # def creature_id
  #   creature_id = @creatures.find id=2
  # end

  def show
    @creature = Creature.find_by_id(params[:id])
    # return render :plain => "error no creature" unless @creature
    # @tags = @creature.tags.map do |tag|
    #   tag.name
    # end

    not_found unless @creature

    @search = Creature.find(params[:id]).name
        list = flickr.photos.search :text => @search, :sort => "relevance"
    @results = list.map do |photo|
      FlickRaw.url_s(photo)
    end

    @response = RestClient.get 'http://www.reddit.com/search.json', {:params => {:q => @creature.name, :limit => 10}}
    @response_object = JSON.parse(@response)
    @reddit_posts = @response_object['data']['children']

    # @tags = @creature.tags.inspect
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
    @tags = Tag.all
  end

  def update
    # return render json: params[:creature][:tags_id]
    @creature = Creature.find(params[:id])
    @creature.update_attributes(creature_params)

    @creature.tags.clear
    tags = params[:creature][:tag_ids]
    tags.each do |tag_id|
      @creature.tags << Tag.find(tag_id) unless tag_id.blank?
    end


    redirect_to "/creatures/#{params[:id]}"
  end

  def tag
    tag = Tag.find_by_name(params[:tag])
    if tag
      @creatures = tag.creatures
    else
      @creatures = []
    end
  end

  def destroy
    @creature = Creature.find(params[:id]).destroy
    redirect_to '/'
  end

end