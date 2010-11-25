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
videos = []
# Create 3 videos
1.upto(3) do |i|
  videos << Image.create(:image => File.open("#{Rails.root}/db/env_seeds/v#{i}.jpg", 'rb'))
end
video_desc = []
video_desc[0] = "http://vimeo.com/16566024"
video_desc[1] = "http://vimeo.com/15925400"
video_desc[2] = "http://vimeo.com/14309120"

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
  i = rand(images.size - 4)
  j = rand(videos.size - 1)
  gallery.gallery_entries.create :name => "Image for gallery #{gallery.name} #{i}",   :image_id => images[i].id
  gallery.gallery_entries.create :name => "Video for gallery #{gallery.name} #{j}",   :image_id => videos[j].id,   :entry_type => 1, :body => video_desc[j]
  gallery.gallery_entries.create :name => "Image for gallery #{gallery.name} #{i+1}", :image_id => images[i+1].id
  gallery.gallery_entries.create :name => "Image for gallery #{gallery.name} #{i+2}", :image_id => images[i+2].id
  gallery.gallery_entries.create :name => "Image for gallery #{gallery.name} #{i+3}", :image_id => images[i+3].id
  gallery.gallery_entries.create :name => "Video for gallery #{gallery.name} #{j+1}", :image_id => videos[j+1].id, :entry_type => 1, :body => video_desc[j+1]
end
