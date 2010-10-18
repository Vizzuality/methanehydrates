r = Role.create :title => 'Refinery'

u = User.new
u.login = 'admin'
u.email = 'change-me@example.com'
u.password = 'admin'
u.password_confirmation = 'admin'
u.save

# Refinery settings
Dir[Rails.root.join('db', 'seeds','*.rb').to_s].each do |file|
  load(file)
end

# Update plugins position
u.reload
%W{ refinery_dashboard refinery_pages features refinerycms_blog events galleries refinery_files refinery_images refinery_inquiries refinery_users refinery_settings }.each_with_index do |plugin, i|
  if p = u.plugins.find_by_name(plugin)
    p.update_attribute(:position, i)
  else
    u.plugins.create(:name => plugin, :position => i)
  end
end

u.roles << r

# Default image sizes
puts "Loading default image sizes"
RefinerySetting.set(:user_image_sizes, {
  :small =>  '100x75>',
  :medium => '235x150>',
  :large =>  '550x370>',
  :big =>    '615x400>',
  :huge =>   '930x615>',
})

puts "Setting site name"
RefinerySetting.set(:site_name, 'Frozen Heat')

# Feature attributes
attributes = <<-ATTRIBUTES
region:string
country:string
recorded_datafields_text:text
primary_institution_name:string
primary_institution_url:string
expedition:string
water_depth:string
hydrate_depth:string
hydrate_description:text
data_provided_by_name:string
data_provided_by_url:string
ATTRIBUTES

RefinerySetting.set(:feature_attributes, attributes)

# Load sample data
env_seed_file = File.join(Rails.root, 'db', 'env_seeds', "#{Rails.env}.rb")
if File.exist?(env_seed_file)
  puts "Loading seeds from #{Rails.env}"
  load(env_seed_file)
end

# Load methane hydrates pages
puts 'Loading content in default pages'
load(Rails.root.join('db', 'methane_static_pages.rb').to_s)
