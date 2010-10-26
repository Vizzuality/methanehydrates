namespace :methane do
  desc 'Import features data'
  task :import_data => :environment do
    data_directory = "#{Rails.root}/doc/"
    filename = "methane.csv"
    FasterCSV.foreach(data_directory + '/' + filename) do |line|
      next if line[0] == 'Geographic Location'

      # Fields in CSV
      #   0 "Geographic Location",
      #   1 "Primary Institution",
      #   2 "Expedition",
      #   3 "Site",
      #   4 "Latitude (Deg/Min/Sec)",
      #   5 "Longitude (Deg/Min/Sec)",
      #   6 "Latitude (Decimal Degrees)",
      #   7 "Longitude (Decimal Degrees)",
      #   8 "Water Depth (m)",
      #   9 "Hydrate Depth (mbsf)",
      #   10 "Description",
      #   11 "Reference"

      # Features fields
      #   region:string
      #   country:string
      #   recorded_datafields_text:text
      #   primary_institution_name:string
      #   primary_institution_url:string
      #   expedition:string
      #   water_depth:string
      #   hydrate_depth:string
      #   hydrate_description:text
      #   data_provided_by_name:string
      #   data_provided_by_url:string

      g = Gallery.create :name => line[3], :body => ''

      f = Feature.new
      f.region = line[0]
      if ["Costa Rica", "Guatemala", "Japan", "Mexico", "Peru"].include?(f.region.split('-').last.strip)
        f.country = f.region.split('-').last.strip
        f.region = f.region.split('-')[0..-2].join('-')
      end
      f.primary_institution_name = line[1]
      f.expedition = line[2]
      f.title = line[3]
      f.the_geom = "POINT(#{line[7].gsub(/,/,'.')} #{line[6].gsub(/,/,'.')})"
      f.water_depth = line[8]
      f.hydrate_depth = line[9]
      f.hydrate_description = line[10]
      f.references = line[11]
      f.gallery_id = g.id
      if f.save
        puts " successfully created #{f.title}"
      else
        puts " errors creating feature: #{f.errors.full_messages}"
      end
    end
  end

end