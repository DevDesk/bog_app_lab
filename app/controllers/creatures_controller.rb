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
    # redirect_to @creature.id
  end

  def creature_params
    creature_params = params.require(:creature).permit(:name, :description)
  end

  def creature_id
    creature_id = @creatures.find id=2
  end

  def show

  end

end