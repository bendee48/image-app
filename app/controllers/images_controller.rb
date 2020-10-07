class ImagesController < ApplicationController
  def index
    @images = Image.all
  end

  def new
    @image = Image.new
  end

  def create
    user = User.find(current_user.id)
    @image = user.images.build(name: params[:image][:name],
                               picture: params[:image][:picture]) 

    if @image.save
      flash.notice = 'Image was successfully created.'
      redirect_to @image
    else
      flash.now.alert = "Something went wrong."
      render :new
    end
  end

  def show
    @image = Image.find(params[:id])
  end

  private

  def image_params
    params.require(:image).permit(:name, :picture, :user_id)
  end
end
