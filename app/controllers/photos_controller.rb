class PhotosController < PrivateController

  before_filter :authorize, :except => [:thumb, :polaroid, :standard]
  caches_page :thumb, :polaroid, :standard

  def index
    @photos = Photo.find(:all,:order => "product_line_id, position")
  end

  def show
    @photo = Photo.find((params[:id]))
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.new(params[:photo])
    if @photo.save
      flash[:notice] = "Successfully added photo."
      redirect_to photos_path
    else
      render :action => 'new'
    end
  end

  def edit
    @photo = Photo.find(params[:id])
  end

  def update
    @photo = Photo.find(params[:id])
    if @photo.update_attributes(params[:photo])
      expire_page thumb_photo_path(@photo, :jpg)
      expire_page polaroid_photo_path(@photo, :jpg)
      expire_page standard_photo_path(@photo, :jpg)
      expire_page photo_path(@photo, :jpg)
      flash[:notice] = "Successfully updated photo."
      redirect_to photos_path
    else
      render :action => 'edit'
    end
  end

  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy
    flash[:notice] = "Successfully destroyed photo."
    redirect_to photos_url
  end

# image display methods

  def thumb
    @photo = Photo.find((params[:id]))
  end

  def polaroid
    @photo = Photo.find((params[:id]))
  end

  def standard
    @photo = Photo.find((params[:id]))
  end

end

