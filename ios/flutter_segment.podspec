#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'flutter_segment'
  s.version          = '4.0.0'
  s.summary          = 'A new flutter plugin project.'

  s.requires_arc = true
  s.static_framework = true

  s.description      = <<-DESC
A new flutter plugin project.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.dependency 'Analytics', '4.1.5'
  s.dependency 'Segment-Amplitude', '3.3.1'
  s.ios.deployment_target = '10.0'

end

