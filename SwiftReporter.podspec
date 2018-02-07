Pod::Spec.new do |s|
  s.name = 'SwiftReporter'
  s.version = '0.1.0'
  s.license = 'ZLIB'
  s.summary = 'SwiftReporter provides simple reporting functionality'
  s.homepage = 'https://github.com/kornerr/SwiftReporter'
  s.authors = { 'Michael Kapelko' => 'kornerr@gmail.com' }

  s.source = { :git => 'https://github.com/kornerr/SwiftReporter.git', :tag => s.version }
  s.source_files = 'SwiftReporter.swift'

  s.ios.deployment_target = '9.0'
  #s.osx.deployment_target = '10.10'
  #s.tvos.deployment_target = '9.0'
  #s.watchos.deployment_target = '2.0'
end
