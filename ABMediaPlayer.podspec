Pod::Spec.new do |s|

  s.name = 'ABMediaPlayer'
  s.version = '0.7'
  s.license = 'MIT'
  s.summary = 'A media player which allows youtube and vimeo videos along with files'
  s.author = { 'Andrey Belonogov' => 'abelon.dev@gmail.com' }
  s.platform = :ios, '7.1'
  s.source_files = 'Source/**/*'
  s.exclude_files = 'Source/ABWebViewPlayer.{h,m}'
  s.requires_arc = true
  s.homepage = 'https://github.com/abelondev/ABMediaPlayer'
  s.source = { :git => 'https://github.com/abelondev/ABMediaPlayer', :path => './' }
  s.frameworks = 'ImageIO', 'QuartzCore', 'AssetsLibrary', 'MediaPlayer'
  s.weak_frameworks = 'Photos'
  s.public_header_files = 'Pod/Classes/**/*.h'

  s.dependency 'HCYoutubeParser', '~> 0.0'

end
