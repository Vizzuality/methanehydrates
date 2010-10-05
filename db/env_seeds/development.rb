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