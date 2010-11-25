# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20101014144833) do

  create_table "blog_categories", :force => true do |t|
    t.column "title", :string
    t.column "created_at", :datetime
    t.column "updated_at", :datetime
  end

  add_index "blog_categories", ["id"], :name => "index_blog_categories_on_id"

  create_table "blog_categories_blog_posts", :id => false, :force => true do |t|
    t.column "blog_category_id", :integer
    t.column "blog_post_id", :integer
  end

  create_table "blog_comments", :force => true do |t|
    t.column "blog_post_id", :integer
    t.column "spam", :boolean
    t.column "name", :string
    t.column "email", :string
    t.column "body", :text
    t.column "state", :string
    t.column "created_at", :datetime
    t.column "updated_at", :datetime
  end

  add_index "blog_comments", ["id"], :name => "index_blog_comments_on_id"

  create_table "blog_posts", :force => true do |t|
    t.column "title", :string
    t.column "body", :text
    t.column "draft", :boolean
    t.column "published_at", :datetime
    t.column "created_at", :datetime
    t.column "updated_at", :datetime
  end

  add_index "blog_posts", ["id"], :name => "index_blog_posts_on_id"

  create_table "events", :force => true do |t|
    t.column "title", :string
    t.column "description", :text
    t.column "location", :string
    t.column "from", :datetime
    t.column "to", :datetime
    t.column "position", :integer
    t.column "url", :string
    t.column "created_at", :datetime
    t.column "updated_at", :datetime
  end

  add_index "events", ["id"], :name => "index_events_on_id"

  create_table "features", :force => true do |t|
    t.column "title", :string
    t.column "description", :text
    t.column "gallery_id", :integer
    t.column "position", :integer
    t.column "meta", :text
    t.column "created_at", :datetime
    t.column "updated_at", :datetime
    t.column "the_geom", :geometry, :srid => 4326, :null => false
  end

  add_index "features", ["id"], :name => "index_features_on_id"

  create_table "galleries", :force => true do |t|
    t.column "name", :string
    t.column "body", :text
    t.column "position", :integer
    t.column "created_at", :datetime
    t.column "updated_at", :datetime
  end

  add_index "galleries", ["id"], :name => "index_galleries_on_id"

  create_table "gallery_entries", :force => true do |t|
    t.column "name", :string
    t.column "body", :text
    t.column "image_id", :integer
    t.column "position", :integer
    t.column "gallery_id", :integer
    t.column "entry_type", :integer, :default => 0
    t.column "created_at", :datetime
    t.column "updated_at", :datetime
  end

  add_index "gallery_entries", ["id"], :name => "index_gallery_entries_on_id"

# Could not dump table "geography_columns" because of following StandardError
#   Unknown type 'name' for column 'f_table_catalog' /Users/vizzuality/.rvm/gems/ruby-1.8.7-p174@methan/bundler/gems/postgis_adapter-6c41a9b5c1b9/lib/postgis_adapter/common_spatial_adapter.rb:52:in `table'/Users/vizzuality/.rvm/gems/ruby-1.8.7-p174@methan/bundler/gems/postgis_adapter-6c41a9b5c1b9/lib/postgis_adapter/common_spatial_adapter.rb:50:in `each'/Users/vizzuality/.rvm/gems/ruby-1.8.7-p174@methan/bundler/gems/postgis_adapter-6c41a9b5c1b9/lib/postgis_adapter/common_spatial_adapter.rb:50:in `table'/Users/vizzuality/.rvm/gems/ruby-1.8.7-p174@methan/gems/activerecord-3.0.0/lib/active_record/schema_dumper.rb:75:in `tables'/Users/vizzuality/.rvm/gems/ruby-1.8.7-p174@methan/gems/activerecord-3.0.0/lib/active_record/schema_dumper.rb:66:in `each'/Users/vizzuality/.rvm/gems/ruby-1.8.7-p174@methan/gems/activerecord-3.0.0/lib/active_record/schema_dumper.rb:66:in `tables'/Users/vizzuality/.rvm/gems/ruby-1.8.7-p174@methan/gems/activerecord-3.0.0/lib/active_record/schema_dumper.rb:27:in `dump'/Users/vizzuality/.rvm/gems/ruby-1.8.7-p174@methan/gems/activerecord-3.0.0/lib/active_record/schema_dumper.rb:21:in `dump'/Users/vizzuality/.rvm/gems/ruby-1.8.7-p174@methan/gems/activerecord-3.0.0/lib/active_record/railties/databases.rake:327/Users/vizzuality/.rvm/gems/ruby-1.8.7-p174@methan/gems/activerecord-3.0.0/lib/active_record/railties/databases.rake:326:in `open'/Users/vizzuality/.rvm/gems/ruby-1.8.7-p174@methan/gems/activerecord-3.0.0/lib/active_record/railties/databases.rake:326/Users/vizzuality/.rvm/gems/ruby-1.8.7-p174@methan/gems/rake-0.8.7/lib/rake.rb:636:in `call'/Users/vizzuality/.rvm/gems/ruby-1.8.7-p174@methan/gems/rake-0.8.7/lib/rake.rb:636:in `execute'/Users/vizzuality/.rvm/gems/ruby-1.8.7-p174@methan/gems/rake-0.8.7/lib/rake.rb:631:in `each'/Users/vizzuality/.rvm/gems/ruby-1.8.7-p174@methan/gems/rake-0.8.7/lib/rake.rb:631:in `execute'/Users/vizzuality/.rvm/gems/ruby-1.8.7-p174@methan/gems/rake-0.8.7/lib/rake.rb:597:in `invoke_with_call_chain'/Users/vizzuality/.rvm/rubies/ruby-1.8.7-p174/lib/ruby/1.8/monitor.rb:242:in `synchronize'/Users/vizzuality/.rvm/gems/ruby-1.8.7-p174@methan/gems/rake-0.8.7/lib/rake.rb:590:in `invoke_with_call_chain'/Users/vizzuality/.rvm/gems/ruby-1.8.7-p174@methan/gems/rake-0.8.7/lib/rake.rb:583:in `invoke'/Users/vizzuality/.rvm/gems/ruby-1.8.7-p174@methan/gems/activerecord-3.0.0/lib/active_record/railties/databases.rake:143/Users/vizzuality/.rvm/gems/ruby-1.8.7-p174@methan/gems/rake-0.8.7/lib/rake.rb:636:in `call'/Users/vizzuality/.rvm/gems/ruby-1.8.7-p174@methan/gems/rake-0.8.7/lib/rake.rb:636:in `execute'/Users/vizzuality/.rvm/gems/ruby-1.8.7-p174@methan/gems/rake-0.8.7/lib/rake.rb:631:in `each'/Users/vizzuality/.rvm/gems/ruby-1.8.7-p174@methan/gems/rake-0.8.7/lib/rake.rb:631:in `execute'/Users/vizzuality/.rvm/gems/ruby-1.8.7-p174@methan/gems/rake-0.8.7/lib/rake.rb:597:in `invoke_with_call_chain'/Users/vizzuality/.rvm/rubies/ruby-1.8.7-p174/lib/ruby/1.8/monitor.rb:242:in `synchronize'/Users/vizzuality/.rvm/gems/ruby-1.8.7-p174@methan/gems/rake-0.8.7/lib/rake.rb:590:in `invoke_with_call_chain'/Users/vizzuality/.rvm/gems/ruby-1.8.7-p174@methan/gems/rake-0.8.7/lib/rake.rb:583:in `invoke'/Users/vizzuality/.rvm/gems/ruby-1.8.7-p174@methan/gems/rake-0.8.7/lib/rake.rb:2051:in `invoke_task'/Users/vizzuality/.rvm/gems/ruby-1.8.7-p174@methan/gems/rake-0.8.7/lib/rake.rb:2029:in `top_level'/Users/vizzuality/.rvm/gems/ruby-1.8.7-p174@methan/gems/rake-0.8.7/lib/rake.rb:2029:in `each'/Users/vizzuality/.rvm/gems/ruby-1.8.7-p174@methan/gems/rake-0.8.7/lib/rake.rb:2029:in `top_level'/Users/vizzuality/.rvm/gems/ruby-1.8.7-p174@methan/gems/rake-0.8.7/lib/rake.rb:2068:in `standard_exception_handling'/Users/vizzuality/.rvm/gems/ruby-1.8.7-p174@methan/gems/rake-0.8.7/lib/rake.rb:2023:in `top_level'/Users/vizzuality/.rvm/gems/ruby-1.8.7-p174@methan/gems/rake-0.8.7/lib/rake.rb:2001:in `run'/Users/vizzuality/.rvm/gems/ruby-1.8.7-p174@methan/gems/rake-0.8.7/lib/rake.rb:2068:in `standard_exception_handling'/Users/vizzuality/.rvm/gems/ruby-1.8.7-p174@methan/gems/rake-0.8.7/lib/rake.rb:1998:in `run'/Users/vizzuality/.rvm/gems/ruby-1.8.7-p174@methan/gems/rake-0.8.7/bin/rake:31/Users/vizzuality/.rvm/gems/ruby-1.8.7-p174@methan/bin/rake:19:in `load'/Users/vizzuality/.rvm/gems/ruby-1.8.7-p174@methan/bin/rake:19

  create_table "images", :force => true do |t|
    t.column "image_mime_type", :string
    t.column "image_name", :string
    t.column "image_size", :integer
    t.column "image_width", :integer
    t.column "image_height", :integer
    t.column "created_at", :datetime
    t.column "updated_at", :datetime
    t.column "image_uid", :string
    t.column "image_ext", :string
  end

  create_table "inquiries", :force => true do |t|
    t.column "name", :string
    t.column "email", :string
    t.column "phone", :string
    t.column "message", :text
    t.column "position", :integer
    t.column "open", :boolean, :default => true
    t.column "created_at", :datetime
    t.column "updated_at", :datetime
    t.column "spam", :boolean, :default => false
  end

  create_table "inquiry_settings", :force => true do |t|
    t.column "name", :string
    t.column "value", :text
    t.column "destroyable", :boolean
    t.column "created_at", :datetime
    t.column "updated_at", :datetime
  end

  create_table "page_parts", :force => true do |t|
    t.column "page_id", :integer
    t.column "title", :string
    t.column "body", :text
    t.column "position", :integer
    t.column "created_at", :datetime
    t.column "updated_at", :datetime
  end

  add_index "page_parts", ["id"], :name => "index_page_parts_on_id"
  add_index "page_parts", ["page_id"], :name => "index_page_parts_on_page_id"

  create_table "pages", :force => true do |t|
    t.column "title", :string
    t.column "parent_id", :integer
    t.column "position", :integer
    t.column "path", :string
    t.column "created_at", :datetime
    t.column "updated_at", :datetime
    t.column "meta_keywords", :string
    t.column "meta_description", :text
    t.column "show_in_menu", :boolean, :default => true
    t.column "link_url", :string
    t.column "menu_match", :string
    t.column "deletable", :boolean, :default => true
    t.column "custom_title", :string
    t.column "custom_title_type", :string, :default => "none"
    t.column "draft", :boolean, :default => false
    t.column "browser_title", :string
    t.column "skip_to_first_child", :boolean, :default => false
    t.column "lft", :integer
    t.column "rgt", :integer
    t.column "depth", :integer
    t.column "cached_slug", :string
  end

  add_index "pages", ["depth"], :name => "index_pages_on_depth"
  add_index "pages", ["id"], :name => "index_pages_on_id"
  add_index "pages", ["lft"], :name => "index_pages_on_lft"
  add_index "pages", ["parent_id"], :name => "index_pages_on_parent_id"
  add_index "pages", ["rgt"], :name => "index_pages_on_rgt"

  create_table "refinery_settings", :force => true do |t|
    t.column "name", :string
    t.column "value", :text
    t.column "destroyable", :boolean, :default => true
    t.column "created_at", :datetime
    t.column "updated_at", :datetime
    t.column "scoping", :string
    t.column "restricted", :boolean, :default => false
    t.column "callback_proc_as_string", :string
  end

  add_index "refinery_settings", ["name"], :name => "index_refinery_settings_on_name"

  create_table "resources", :force => true do |t|
    t.column "file_mime_type", :string
    t.column "file_name", :string
    t.column "file_size", :integer
    t.column "created_at", :datetime
    t.column "updated_at", :datetime
    t.column "file_uid", :string
    t.column "file_ext", :string
  end

  create_table "roles", :force => true do |t|
    t.column "title", :string
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.column "user_id", :integer
    t.column "role_id", :integer
  end

  create_table "slugs", :force => true do |t|
    t.column "name", :string
    t.column "sluggable_id", :integer
    t.column "sequence", :integer, :default => 1, :null => false
    t.column "sluggable_type", :string, :limit => 40
    t.column "scope", :string, :limit => 40
    t.column "created_at", :datetime
  end

  add_index "slugs", ["name", "sequence", "sluggable_type", "scope"], :name => "index_slugs_on_name_and_sluggable_type_and_scope_and_sequence", :unique => true
  add_index "slugs", ["sluggable_id"], :name => "index_slugs_on_sluggable_id"

  create_table "user_plugins", :force => true do |t|
    t.column "user_id", :integer
    t.column "name", :string
    t.column "position", :integer
  end

  add_index "user_plugins", ["user_id", "name"], :name => "index_unique_user_plugins", :unique => true
  add_index "user_plugins", ["name"], :name => "index_user_plugins_on_title"

  create_table "users", :force => true do |t|
    t.column "login", :string, :null => false
    t.column "email", :string, :null => false
    t.column "crypted_password", :string, :null => false
    t.column "password_salt", :string, :null => false
    t.column "persistence_token", :string
    t.column "created_at", :datetime
    t.column "updated_at", :datetime
    t.column "perishable_token", :string
  end

  add_index "users", ["id"], :name => "index_users_on_id"

end
