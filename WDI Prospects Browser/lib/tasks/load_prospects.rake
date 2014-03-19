require 'csv'

def replChar(amount)
  if amount.strip.length!=0
    amount=amount.strip
    amount.gsub!('$','')
    amount.gsub!(',','')
  end
  return amount
end

namespace :load_prospects do
  desc "Load WDI Prosepects from CSV file into database"
  task :load => :environment do
    n=0
    srcCsvDir = "/home/pavan/Downloads/irs_csv_data/temp"
    csvs = Dir.entries(srcCsvDir)
    csvs.each{|file|
      if file!="." && file!=".."
        puts "Parsing #{file}..."
        srcFile=srcCsvDir + "/" + file
        CSV.foreach(srcFile, :headers => true) do |row|
          WdiProspect.create({
            :e_i_n => row[0],
            :name => row[1],
            :in_care_of_name => row[2],
            :address => row[3],
            :city => row[4],
            :state => row[5],
            :zip_code => row[6],
            :asset_amount => replChar(row[25]),
            :income_amount => replChar(row[26]),
            :form_990_revenue_amount => replChar(row[28])
          })
          n=n+1
        end
      end
    }
    puts "CSV Import Successful,  #{n} new prospects added to data base"
  end

end
