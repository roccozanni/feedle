Gem::Specification.new do |s|
  s.name     = 'feedle'
  s.version  = '0.0.1'
  s.date     = '2012-04-08'
  s.summary  = 'Ruby RSS to Kindle'
  s.description = <<-EOS
  EOS

  s.files = Dir['lib/**/*.rb']
  s.executables = ['feedle']
  s.add_dependency('kindle-feeds', '= 1.0.6')
  s.add_dependency('mail', '>= 2.4.0')

  s.has_rdoc = false

  s.author   = 'Rocco Zanni'
  s.email    = 'rocco.zanni@gmail.com'
  s.homepage = 'http://github.com/roccozanni/feedle'
end