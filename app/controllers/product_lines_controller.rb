class ProductLinesController < PrivateController
  def index
    @product_lines = ProductLine.all(:order => 'prod_no')
  end

  def show
    @product_line = ProductLine.find(params[:id])
  end

  def new
    @product_line = ProductLine.new
  end

  def create
    @product_line = ProductLine.new(params[:product_line])
    case params[:commit]
    when 'Add Options'
      @product_line.options
      generate_options(params[:generator]).each do |option|
        @product_line.options << option
      end
      flash[:notice] = "New options added."
      render :action => 'new'
    when 'Replace Options'
      @product_line.options = generate_options(params[:generator])
      flash[:notice] = "Options ammended."
      render :action => 'new'
    else
      @product_line.options.each do |option|
        @product_line.options.delete(option) if option.remove?
      end
      if @product_line.save
        flash[:notice] = "Successfully created product line."
        redirect_to product_lines_path
      else
        render :action => 'new'
      end
    end
  end

  def edit
    @product_line = ProductLine.find(params[:id])
  end

  def update
    @product_line = ProductLine.find(params[:id])
    case params[:commit]
    when 'Add Options'
      generate_options(params[:generator]).each do |option|
        @product_line.options << option
      end
      flash[:notice] = "New options added."
      render :action => 'edit'
    when 'Replace Options'
      @product_line.options = generate_options(params[:generator])
      flash[:notice] = "Options ammended."
      render :action => 'edit'
    else
      if params.has_key?(:product_line)
        params[:product_line][:options_attributes].each_pair do |id,hash|
          hash[:_destroy] = '1' if hash[:remove] == '1'
        end
      end
      if @product_line.update_attributes(params[:product_line])
        flash[:notice] = "Successfully updated product line."
        redirect_to product_lines_path
      else
        render :action => 'edit'
      end
    end
  end

  def destroy
    @product_line = ProductLine.find(params[:id])
    @product_line.destroy
    flash[:notice] = "Successfully destroyed product line."
    redirect_to product_lines_url
  end

private

  def generate_options(hash) # takes hash of generator_ keys
    hash.delete_if {|key,value| value.blank?}
    array_of_arrays = Array.new
    options = Array.new
    hash.each do |k,v|
      kvp = Array.new
      v.split(' ').each do |sv|
        kvp << [k,sv]
      end
      array_of_arrays << kvp
    end
    combine(array_of_arrays).each do |a|
      h = Hash[a]
      if h.key?('size_a') && h.key?('size_b')
        h['size'] = "#{h['size_a']} #{h['size_b']}"
        h.delete('size_a')
        h.delete('size_b')
      elsif h.key?('size_a')
        h['size'] = h['size_a']
        h.delete('size_a')
      end
      options << Option.new(h)
    end
    return options
  end

  def combine(array_of_arrays)
    combos = Array.new
    _combine(array_of_arrays, combos, [], 0)
    combos
  end

  def _combine(array_of_arrays, combos, combo, index)
    current = array_of_arrays.slice(index)
    if current
      current.each{|a|
        _combo = combo.dup
        _combo << a
        _combine(array_of_arrays, combos, _combo, index+1)
      }
    else
      combos << combo
    end
  end

end

