Pod::Spec.new do |s|  
  s.name         = "Platformaly"
  s.version      = "0.1.0"
  s.summary      = "Short Description"

  s.description  = <<-DESC
                   Long Description
                   DESC

  s.homepage     = "https://platformaly.ru"
  s.license      = 'MIT (example)'
  s.author       = { "Platformaly" => "hello@platformaly.ru" }
  s.platform     = :ios, '7.0'
  s.source_files  = 'Platformaly', 'Platformaly/**/*.{h,m}'
  s.public_header_files = 'Platformaly/**/*.h'
  s.resources    = "Platformaly/**/*.xib", "Platformaly/**/*.png", "Platformaly/**/*.storyboard"
  s.requires_arc = true

  s.dependency 'JTHamburgerButton'

end 