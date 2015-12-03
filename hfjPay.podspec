Pod::Spec.new do |s|
s.name         = 'hfjPay'
s.version      = '1.0.0'
s.summary      = 'hfjPay iOS SDK'
s.homepage     = 'http://www.silversnet.com/'
s.license      = 'MIT'
s.author       = { 'hfjflydove' => 'ioshefeijiang@163.com' }
s.ios.deployment_target = '7.0'
s.source       = { :git => 'https://github.com/hfjflydove/hfjPay.git', :tag => s.version.to_s }
s.requires_arc = true
s.source_files = 'hfjPay/SPay/*.h'
s.public_header_files = 'hfjPay/SPay/*.h'
s.vendored_libraries = 'hfjPay/SPay/*.a'
s.resources = 'hfjPay/SPay/SPayImages.bundle'
s.xcconfig = { 'OTHER_LDFLAGS' => '-lObjC' }
end