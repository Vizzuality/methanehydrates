namespace :methane do
  desc 'Sync wikipedia articles'
  task :wikipedia => :environment do
    Feature.all.each do |feature|
      next if feature.wiki_url.blank?
      puts "Syncinc Feature #{feature.title}"

      doc = Nokogiri::HTML(open(URI.encode(feature.wiki_url), 'User-Agent' => 'Methanegashydrates.org'), nil, 'UTF-8')

      article = doc.css('#bodyContent p')
      article.css('sup').each{|sup| sup.remove}
      feature.description = article
      feature.save
      feature.reload
      feature.description = feature.description.gsub(/href=\"\//,'rel="nofollow" href="http://en.wikipedia.org/')
      feature.save
    end
  end
end