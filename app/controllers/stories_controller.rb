class StoriesController < ApplicationController
  def index
    @stories = Story.all
    respond_to do |format|
      format.html { render :index }
      format.json { render json: @stories }
    end
  end

  def show
    @story = Story.find(params[:id])
    @food = @story.food
    @comment = Comment.new
    if current_user
      @comment = current_user.comments.build(story: @story)
    end
    respond_to do |format|
      format.html { render :show }
      format.json { render json:  @story }
    end
  end

  def next_story
    @story = Story.find(params[:id])
    @next_story = @story.next
    render json: @next_story
  end

  def previous_story
    @story = Story.find(params[:id])
    @previous_story = @story.previous
    render json: @previous_story
  end

  def new
    @story ||= Story.new
    @story.build_food
  end

  def create
    @story = Story.new(story_params)
    @story.user = current_user
    
    @food = Food.new
    @food.name = params[:story][:food][:name]
    @food.category = params[:story][:food][:category]

    @food.save
    
    @story.food = @food
    
    if @story.save
      redirect_to story_path(@story)
    else
      redirect_to new_story_path, alert: "You must add a title, content and location in order to create a story."
    end
  end

  def edit
    @story = Story.find(params[:id])
  end

  def update
    @story = Story.find(params[:id])
    if !current_user
      redirect_to new_user_session_path, alert: "You must be the author in order to edit a story."
    elsif current_user != @story.user
      redirect_to :back, alert: "You must be the author in order to edit a story."
    else
      @story.update(story_params)
      redirect_to story_path(@story)
    end
  end

  def destroy
    @story = Story.find(params[:id])
    if !current_user
      redirect_to new_user_session_path, alert: "You must be the author in order to delete a story."
    elsif current_user != @story.user
      redirect_to :back, alert: "You must be the author in order to delete a story."
    else
      @story.destroy
      redirect_to stories_path
    end
  end

  # def story_indexes
  #   respond_to do |format|
  #     format.html { render :show }
  #     format.json { render json: story.all.map{|dest| dest.id}}
  #   end
  # end

  private

  def story_params
    params.require(:story).permit(:title, :location, :content, :image, :recommendation, :food_id, :food_attributes => [:name, :category])
  end

end