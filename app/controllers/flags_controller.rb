class FlagsController < PrivateController

  before_filter :authorize, :except => [:show]

  def index
    @flags = Flag.all
  end

  def show
    @flag = Flag.find(params[:id])
  end

  def new
    @flag = Flag.new
  end

  def create
    @flag = Flag.new(params[:flag])
    if @flag.save
      flash[:notice] = "Successfully created flag."
      redirect_to flags_path
    else
      render :action => 'new'
    end
  end

  def edit
    @flag = Flag.find(params[:id])
  end

  def update
    @flag = Flag.find(params[:id])
    if @flag.update_attributes(params[:flag])
      expire_page :action => "show", :id => params[:id]
      flash[:notice] = "Successfully updated flag."
      redirect_to flags_path
    else
      render :action => 'edit'
    end
  end

  def destroy
    @flag = Flag.find(params[:id])
    @flag.destroy
    flash[:notice] = "Successfully destroyed flag."
    redirect_to flags_url
  end
end

