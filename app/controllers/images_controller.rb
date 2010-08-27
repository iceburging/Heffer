class ImagesController < PrivateController

  before_filter :authorize, :except => [:thumb, :standard]
  caches_page :thumb, :standard

  def index
    @images = Image.all
  end

  def show
    @image = Image.find(params[:id])
  end

  def new
    @image = Image.new
  end

  def create
    @image = Image.new(params[:image])
    if @image.save
      flash[:notice] = "Successfully added image."
      redirect_to images_path
    else
      render :action => 'new'
    end
  end

  def edit
    @image = Image.find(params[:id])
  end

  def update
    @image = Image.find(params[:id])
    if @image.update_attributes(params[:image])
      expire_page thumb_image_path(@image, :png)
      expire_page standard_image_path(@image, :png)
      expire_page image_path(@image, :png)
      flash[:notice] = "Successfully updated image."
      redirect_to images_path
    else
      render :action => 'edit'
    end
  end

  def destroy
    @image = Image.find(params[:id])
    @image.destroy
    flash[:notice] = "Successfully destroyed image."
    redirect_to images_url
  end

# image display methods

  def thumb
    @image = Image.find((params[:id]))
  end

  def standard
    @image = Image.find((params[:id]))
  end

end

