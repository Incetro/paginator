Pod::Spec.new do |spec|
  spec.name          = 'incetro-paginator'
  spec.module_name   = 'Paginator'
  spec.version       = '1.0.0'
  spec.license       = 'MIT'
  spec.authors       = { 'incetro' => 'incetro@ya.ru' }
  spec.homepage      = "https://github.com/Incetro/paginator.git"
  spec.summary       = 'Swift data paginator'
  spec.swift_version = '5.0'
  spec.source        = { git: "https://github.com/Incetro/paginator.git", tag: "#{spec.version}" }
  spec.source_files  = "Sources/Paginator/**/*.{h,swift}"
  spec.ios.deployment_target = "12.0"
  spec.osx.deployment_target = "10.9"
  spec.watchos.deployment_target = "4.0"
end