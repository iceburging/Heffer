class MenuEntriesController < PrivateController
  def index
    @menu_entries = MenuEntry.all
  end

  def show
    @menu_entry = MenuEntry.find(params[:id])
  end

  def new
    @menu_entry = MenuEntry.new
  end

  def create
    @menu_entry = MenuEntry.new(params[:menu_entry])
    if @menu_entry.save
      flash[:notice] = "Successfully created menu entry."
      redirect_to menu_entries_path
    else
      render :action => 'new'
    end
  end

  def edit
    @menu_entry = MenuEntry.find(params[:id])
  end

  def update
    @menu_entry = MenuEntry.find(params[:id])
    if @menu_entry.update_attributes(params[:menu_entry])
      flash[:notice] = "Successfully updated menu entry."
      redirect_to menu_entries_path
    else
      render :action => 'edit'
    end
  end

  def destroy
    @menu_entry = MenuEntry.find(params[:id])
    @menu_entry.destroy
    flash[:notice] = "Successfully destroyed menu entry."
    redirect_to menu_entries_url
  end
end

