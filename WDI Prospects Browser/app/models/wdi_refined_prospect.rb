class WdiRefinedProspect < ActiveRecord::Base
  attr_accessible :address, :city, :e_i_n, :email, :first_name, :has_donation_button, :income_amount, :last_name, :name, :state, :title, :website

  validates :e_i_n, :presence => true
  validates_uniqueness_of :e_i_n
  #def self.search(params = {})
  def self.search(srchName, srchEin, srchAddr, srchCity, srchState, srchIncAmnt, srchFirstName, srchLastName,
        srchEmail, srchTitle, srchHasDonBut, srchWebsite, recLimit)
    if srchName || srchEin || srchAddr || srchCity || srchState || srchIncAmnt || srchFirstName  || srchLastName || srchEmail || srchTitle || srchHasDonBut || srchWebsite
      
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

      if srchIncAmnt!=""
        if (srchIncAmnt.include? ">") || (srchIncAmnt.include? "<")
          query = query + "income_amount #{srchIncAmnt} AND "
        end
      else
        query = query + "(income_amount LIKE '%%' or income_amount IS NULL) AND "
      end
      
      if srchFirstName!=""
        query = query + "first_name LIKE ? AND "
      else
        query = query + "(first_name LIKE ? or first_name IS NULL) AND "
      end
      
      if srchLastName!=""
        query = query + "last_name LIKE ? AND "
      else
        query = query + "(last_name LIKE ? or last_name IS NULL) AND "
      end
      
      if srchEmail!=""
        query = query + "email LIKE ? AND "
      else
        query = query + "(email LIKE ? or email IS NULL) AND "
      end
      
      if srchTitle!=""
        query = query + "title LIKE ? AND "
      else
        query = query + "(title LIKE ? or title IS NULL) AND "
      end
      
      if srchHasDonBut!=""
        query = query + "has_donation_button LIKE ? AND "
      else
        query = query + "(has_donation_button LIKE ? or has_donation_button IS NULL) AND "
      end
      
      if srchWebsite!=""
        query = query + "website LIKE ?"
      else
        query = query + "(website LIKE ? or website IS NULL)"
      end
      
      if recLimit!=""
        find(:all, :conditions => [query,
            "%#{srchName}%", "%#{srchEin}%", "%#{srchAddr}%", "%#{srchCity}%", "%#{srchState}%", "%#{srchFirstName}%", 
                "%#{srchLastName}%", "%#{srchEmail}%", "%#{srchTitle}%", "%#{srchHasDonBut}%", "%#{srchWebsite}%"], :limit => Integer(recLimit))
      else
        find(:all, :conditions => [query,
                        "%#{srchName}%", "%#{srchEin}%", "%#{srchAddr}%", "%#{srchCity}%", "%#{srchState}%", "%#{srchFirstName}%", 
                            "%#{srchLastName}%", "%#{srchEmail}%", "%#{srchTitle}%", "%#{srchHasDonBut}%", "%#{srchWebsite}%"])
      end
        
             
    end
  end



end
