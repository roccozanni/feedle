require 'kindle-feeds'
require 'mail'


# In the original class the output file can't be customized
class KindleFeeds
	def generate_html(file)
		erb = ERB.new(File.read(ERB_TEMPLATE))
    	out = erb.result(binding())
    	File.open(file, "w") { |f| f.write out }
	end
end


# Mailer class
class Mailer

	def initialize(config)
		@config = config['mailer'] || {}
	end

	def send(file)

		mail = Mail.new
		mail.from = @config['from_address']
		mail.to   = @config['to_address']
		mail.subject = 'Kindle delivery'
		mail.add_file file

		if @config['delivery_method']
			mail.delivery_method @config['delivery_method'], @config['options'].inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo} 
		end
		
		mail.deliver!
	end

end


# Feedle main class
class Feedle
	def self.run(config)

		# Create KindleFeeds configuration format
		sections = config['sections'] || []
		kfConfig = ""

		sections.each do |section|
			name  = section['name']  || 'Other feeds'
			items = section['items'] || []

			kfConfig += name + "\n"
			items.each do |item|
				kfConfig += item + "\n"
			end
			kfConfig += "\n"
		end

		# Generate feed HTML file
		puts "Reading RSS feeds"
		kfOutput = '/tmp/feeds.html'
		#kf = KindleFeeds.new(kfConfig)
		#kf.generate_html(kfOutput)

		# Send created HTML file via email
		puts "Sending content to Kindle..."
		m = Mailer.new(config)
		m.send(kfOutput)
		
		# Delete created file
		File.delete(kfOutput)

	end
end
