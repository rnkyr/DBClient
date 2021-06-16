Pod::Spec.new do |s|
  s.name             = 'DBClient'
  s.version          = '3.0.4'
  s.requires_arc = true
  s.summary          = 'CoreData & Realm wrapper written on Swift'
  s.homepage         = ''
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Yalantis' => 'mail@yalantis.com' }
  s.source           = { :git => 'https://github.com/rnkyr/DBClient.git', :tag => s.version }
  s.social_media_url = 'https://yalantis.com/'
  s.homepage = 'https://yalantis.com/'
  s.ios.deployment_target = '10.0'
  s.default_subspec = 'CoreData'

  s.subspec 'Core' do |spec|
	spec.source_files = ['DBClient/Core/*.swift']
  end

  s.subspec 'CoreData' do |spec|
  	spec.dependency 'DBClient/Core'
    spec.source_files = ['DBClient/CoreData/*.swift']
    spec.frameworks = ['CoreData']
  end

  s.subspec 'Realm' do  |spec|
  	spec.dependency 'DBClient/Core'
    spec.source_files = ['DBClient/Realm/*.swift']
    spec.dependency 'RealmSwift', '~> 5.0.1'
  end
end
