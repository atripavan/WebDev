class WdiProspect < ActiveRecord::Base
  attr_accessible :address, :asset_amount, :city, :e_i_n, :form_990_revenue_amount, :in_care_of_name, :income_amount, :name, :state, :zip_code

  validates :e_i_n, :presence => true
  validates_uniqueness_of :e_i_n
  #def self.search(params = {})
  def self.search(srchName, srchEin, srchInCareOfName, srchAddr, srchCity, srchState, srchZipCode, srchAstAmnt, srchIncAmnt, srchFrm990RvnAmnt, recLimit)
    if srchName || srchEin || srchInCareOfName || srchAddr || srchCity || srchState || srchZipCode || srchAstAmnt || srchIncAmnt || srchFrm990RvnAmnt
      
      query = String.new

      if srchName!=""
        query = "name LIKE ? AND "
      else
        query ="(name LIKE ? or name IS NULL) AND "
      end
      
      if srchEin!=""
        query = query + "e_i_n LIKE ? AND "
      else
        query = query + "(e_i_n LIKE ? or e_i_n IS NULL) AND "
      end
      
      if srchInCareOfName!=""
        query = query + "in_care_of_name LIKE ? AND "
      else
        query = query + "(in_care_of_name LIKE ? or in_care_of_name IS NULL) AND "
      end
      
      if srchAddr!=""
        query = query + "address LIKE ? AND "
      else
        query = query + "(address LIKE ? or address IS NULL) AND "
      end
      
      if srchCity!=""
        query = query + "city LIKE ? AND "
      else
        query = query + "(city LIKE ? or city IS NULL) AND "
      end
      
      if srchState!=""
        query = query + "state LIKE ? AND "
      else
        query = query + "(state LIKE ? or state IS NULL) AND "
      end
      
      if srchZipCode!=""
        query = query + "zip_code LIKE ? AND "
      else
        query = query + "(zip_code LIKE ? or zip_code IS NULL) AND "
      end
            
      #Check if amount related fields have > or < signs in them
      #If so use them in the query as it is
      if srchAstAmnt!=""
        if (srchAstAmnt.include? ">") || (srchAstAmnt.include? "<")
          query = query + "asset_amount #{srchAstAmnt} AND "
        end
      else
        query = query + "(asset_amount LIKE '%%' or asset_amount IS NULL) AND "
      end

      if srchIncAmnt!=""
        if (srchIncAmnt.include? ">") || (srchIncAmnt.include? "<")
          query = query + "income_amount #{srchIncAmnt} AND "
        end
      else
        query = query + "(income_amount LIKE '%%' or income_amount IS NULL) AND "
      end

      if srchFrm990RvnAmnt!=""
        if (srchFrm990RvnAmnt.include? ">") || (srchFrm990RvnAmnt.include? "<")
          query = query + "form_990_revenue_amount #{srchFrm990RvnAmnt}"
        end
      else
        query = query + "(form_990_revenue_amount LIKE '%%' or form_990_revenue_amount IS NULL)"
      end
      
      if recLimit!=""
        find(:all, :conditions => [query,
            "%#{srchName}%", "%#{srchEin}%", "%#{srchInCareOfName}%", "%#{srchAddr}%", "%#{srchCity}%", 
              "%#{srchState}%", "%#{srchZipCode}%"], :limit => Integer(recLimit))
      else
        find(:all, :conditions => [query,
            "%#{srchName}%", "%#{srchEin}%", "%#{srchInCareOfName}%", "%#{srchAddr}%", "%#{srchCity}%", 
              "%#{srchState}%", "%#{srchZipCode}%"])
      end
        
             
    end
  end

end
