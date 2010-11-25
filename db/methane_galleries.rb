g1 = Gallery.create :name => 'Methane gas hydrates and human activities', :body => "Research on methane gas hydrates has been progressin for decades. Subjects of interest include global distribution, geohazards linked to human activities, ecosystems associated to near surface occurrences, technology issues linkted to possible production and future scenarios about methane gas hydrates in the global energy mix.\nThe following gallery places methane gas hydrates in the context of current human activities such as exploration and production research and scientific field and laboratory studies."

# Create images from doc/images/human-activities
# And add them to the new gallery
# dir = "#{Rails.root}/doc/images/human-activities"
# Dir.foreach(dir) do |file|
#   next if file == '.' || file == '..'
#   image_path = "#{dir}/#{file}"
#   image = Image.create :image => File.open("#{image_path}", 'rb')
#   g1.gallery_entries.create :name => "Image #{file}", :image_id => image.id
# end

g2 = Gallery.create :name => 'Methane gas hydrates in the natural system',
                    :body => "Methane gas hydrates occur in a number of locations around the world.\nGeologically, methane gas hydrates are found both in oceanic/lacustrine and permafrost environments.\nThis gallery presents a glimpse of methane gas hydrates in their natural environment."

g3 = Gallery.create :name => "Hydrate samples and field activities from Lake Baikal.",
                    :body => "<a href=\"http://en.wikipedia.org/wiki/Lake_Baikal\">Lake Baikal</a>, in southern Siberia is the largest freshwater lake in the world. Come see first hand the activites of scientists looking at freshwater methane gas hydrates."

g4 = Gallery.create :name => "Hydrate samples and field activities from the eastern Pacific Ocean",
                    :body => "Methane gas hydrates occur at many sites in the eastern Pacific Ocean. International teams collaborate on various types of research and invite you to join them."

g5 = Gallery.create :name => "Hydrate samples and field activities in the Arctic",
                    :body => "Methane gas hydrates occur both on land and in offshore areas of the Arctic. Major research on methane gas hydrates in this region is being conducted by Canada, Japan, the United States, Norway and Germany. Let's take a look at some activities."

g6 = Gallery.create :name => "Hydrate samples and field activites in the East Sea",
                    :body => "The <a href=\"http://en.wikipedia.org/wiki/Sea_of_Japan\">East Sea</a> (Sea of Japan) is a marginal sea of the western Pacific Ocean. Recent field activities have succesfully located occurrences of methane gas hydrates. International collaborative efforts use the latest techniques to identify and evaluate methane gas hydrates deposits. Come sail with the researchers."

g7 = Gallery.create :name => "Fire in the Ice",
                    :body => "Methane gas hydrates might look like pieces of snow or ice, but locked within their crystalline structure is a flammable gas. Although methane gas hydrates are unstable at lower pressures and higher temperatures, they are not spontaneously combustible. All the pictures in this gallery represent disassociating methane gas hydrates that were artificially ignited. Burning of methane gas hydrates releases carbon dioxide and melt water."

g8 = Gallery.create :name => "Hydrate samples and field activities in the Gulf of Mexico",
                    :body => "The Gulf of Mexico is the world's 11th largest body of water. It is one of North America's largest reservoirs of developed conventional hydrocarbon production. Methane gas hydrates occur throughout the Gulf. Come see some of the work being done."