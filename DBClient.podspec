Pod::Spec.new do |s|
  s.name             = 'DBClient'
  s.version          = '3.1.2'
  s.requires_arc = true
  s.summary          = 'CoreData & Realm wrapper written on Swift'
  s.homepage         = ''
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.source           = { :git => 'https://github.com/rnkyr/DBClient.git', :tag => s.version }
  s.ios.deployment_target = '10.0'
  s.default_subspec = 'CoreData'

  s.subspec 'Core' do |spec|
	spec.source_files = ['Sources/DBClient/*.swift']
  end

  s.subspec 'CoreData' do |spec|
  	spec.dependency 'DBClient/Core'
    spec.source_files = ['Sources/DBClientCoreData/*.swift']
    spec.frameworks = ['CoreData']
  end

  s.subspec 'Realm' do  |spec|
  	spec.dependency 'DBClient/Core'
    spec.source_files = ['Sources/DBClientRealm/*.swift']
    spec.dependency 'RealmSwift', '~> 5.0.1'
  end
end
