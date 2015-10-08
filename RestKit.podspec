Pod::Spec.new do |s|
  s.name         =  'RestKit'
  s.version      =  '0.10.31-alpha.1'
  s.summary      =  'RestKit is a framework for consuming and modeling RESTful web resources on iOS and OS X.'
  s.homepage     =  'http://www.restkit.org'
  s.author       =  { 'Blake Watters' => 'blakewatters@gmail.com' }
  s.source       =  { :http => "https://github.com/paperlesspost/RestKit/releases/download/0.10.31.-alpha.1/RestKit.framework.zip"}
  s.license      =  'Apache License, Version 2.0'
  s.requires_arc =  false
  s.vendored_frameworks = "RestKit.framework"

end
