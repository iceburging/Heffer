class HelpController < PublicController
  def verified_by_visa
    render :action => 'verified_by_visa', :layout => false
  end

  def secure_code
    render :action => 'secure_code', :layout => false
  end
end

