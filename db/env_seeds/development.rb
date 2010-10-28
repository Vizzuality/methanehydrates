# Create 3 images and 3 posts
i1 = Image.create :image => File.open("#{Rails.root}/db/env_seeds/photo1.jpg", 'rb')
p1 = BlogPost.create :title => 'My first post', :body => "<p>Text</p><p><img src=\"#{i1.thumbnail(:large).url}\" /></p>", :draft => false, :published_at => Time.now
i2 = Image.create :image => File.open("#{Rails.root}/db/env_seeds/photo2.jpg", 'rb')
p2 = BlogPost.create :title => 'My second post', :body => "<p>Text</p><p><img src=\"#{i2.thumbnail(:large).url}\" /></p>", :draft => false, :published_at => Time.now
i3 = Image.create :image => File.open("#{Rails.root}/db/env_seeds/photo3.jpg", 'rb')
p3 = BlogPost.create :title => 'My third post', :body => "<p>Text</p><p><img src=\"#{i3.thumbnail(:large).url}\" /></p>", :draft => false, :published_at => Time.now

# Create 3 events
e1 = Event.create :title => "Meeting #1", :description => "<p>Text for the meeting #1</p><p>Other paragraph</p>", :from => Date.today, :to => Date.today, :location => 'Hortaleza st, 48, Spain'
e2 = Event.create :title => "Meeting #2", :description => "<p>Text for the meeting #2</p><p>Other paragraph</p>", :from => Date.today, :to => Date.today + 1.day, :location => 'Hortaleza st, 48, Spain'
e3 = Event.create :title => "Meeting #3", :description => "<p>Text for the meeting #3</p><p>Other paragraph</p>", :from => Date.today + 2.days, :to => Date.today + 4.days, :location => 'Hortaleza st, 48, Spain'

images = []
# Create 9 images
1.upto(9) do |i|
  images << Image.create(:image => File.open("#{Rails.root}/db/env_seeds/#{i}.jpg", 'rb'))
end

data_directory = "#{Rails.root}/doc/"
filename = "methane.csv"
FasterCSV.foreach(data_directory + '/' + filename) do |line|
  next if line[0] == 'Geographic Location'
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

Gallery.all.each do |gallery|
  i = rand(images.size - 1)
  gallery.gallery_entries.create :name => "Image for gallery #{gallery.name} #{i}", :image_id => images[i].id
  gallery.gallery_entries.create :name => "Image for gallery #{gallery.name} #{i+1}", :image_id => images[i+1].id
end



#
# %W{ North\ America South\ America Asia Europe Africa Oceania }.each_with_index do |name, i|
#
#   # Create 1 gallery
#   g = Gallery.create :name => "Middle #{name} Trench", :body => ''
#   ge = g.gallery_entries.create :name => "Image #{i}", :image_id => i1.id
#
#   # Create 1 feature
#   f = Feature.new
#   f.title = "Middle #{name} Trench"
#   f.description = "<h3>Place background in #{name}</h3>
#   <p>Methane is a chemical compound with the chemical formula CH4 #{name}</p>
#   <h3>Scientific crew</h3>
#   <p>Methane is a chemical compound with the chemical formula CH4 #{name}</p>"
#   f.region = "Central #{name}"
#   f.country = case name
#   when 'North America'
#     'Canada'
#   when 'South America'
#     'Brazil'
#   when 'Asia'
#     'China'
#   when 'Europe'
#     'Spain'
#   when 'Oceania'
#     'Australia'
#   when 'Africa'
#     'Congo'
#   end
#   f.recorded_datafields_text = "Recorded datafields #{name}"
#   f.primary_institution_name = "#{name} Deep Sea Drilling Project"
#   f.primary_institution_url = 'http://deepseadrillingproject.com'
#   f.expedition = "Leg #{rand(i)+60}"
#   f.water_depth = "#{850+(2*i)}m"
#   f.hydrate_depth = '150,156,230,123'
#   f.hydrate_description = 'Cement and Inclusions'
#   f.data_provided_by_name = 'Booth, J.S Rows,...'
#   f.data_provided_by_url = 'http://boothjsrows.com'
#   f.gallery_id = g.id
#   f.the_geom = "POINT(-#{96+i}.67968749614 #{16+i}.972465151173)"
#   f.save
#
# end