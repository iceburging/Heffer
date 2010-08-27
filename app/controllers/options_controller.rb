class OptionsController < PrivateController
  def index
    @options = Option.all
  end

  def show
    @option = Option.find(params[:id])
  end

  def new
    @option = Option.new
  end

  def create
    @option = Option.new(params[:option])
    if @option.save
      flash[:notice] = "Successfully created option."
      redirect_to @option
    else
      render :action => 'new'
    end
  end

  def edit
    @option = Option.find(params[:id])
  end

  def update
    @option = Option.find(params[:id])
    if @option.update_attributes(params[:option])
      flash[:notice] = "Successfully updated option."
      redirect_to @option
    else
      render :action => 'edit'
    end
  end

  def destroy
    @option = Option.find(params[:id])
    @option.destroy
    flash[:notice] = "Successfully destroyed option."
    redirect_to options_url
  end
end

