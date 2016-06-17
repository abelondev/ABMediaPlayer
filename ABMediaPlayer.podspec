Pod::Spec.new do |s|

  s.name = 'ABMediaPlayer'
  s.version = '0.6'
  s.license = 'MIT'
  s.summary = 'A simple media player which allows youtube and vimeo videos along with files'
  s.author = { 'Andrey Belonogov' => 'abelon.dev@gmail.com' }
  s.social_media_url = 'https://twitter.com/gosubits'
  s.platform = :ios, '7.1'
  s.source_files = 'Pod/Classes/**/*'
  s.exclude_files = 'Pod/Classes/ABWebViewPlayer.{h,m}'
  s.requires_arc = true
  s.homepage = 'http://gosubits.com'
  s.source = { :path => './' }
  s.frameworks = 'ImageIO', 'QuartzCore', 'AssetsLibrary', 'MediaPlayer'
  s.weak_frameworks = 'Photos'
  s.public_header_files = 'Pod/Classes/**/*.h'

  s.dependency 'HCYoutubeParser', '~> 0.0'

end
