Pod::Spec.new do |s|
  s.name = "YXYBaseViewController"
  s.version = "0.1.4"
  s.summary = "VC\u57FA\u7C7B\u548C\u5E38\u7528\u7684category"
  s.license = {"type"=>"MIT", "file"=>"LICENSE"}
  s.authors = {"YXYCareFree"=>"576842121@qq.com"}
  s.homepage = "https://github.com/YXYCareFree/YXYBaseViewController"
  s.description = "\u57FA\u7C7BVC\u548C\u5E38\u7528\u7684category"
  s.source = { :path => '.' }

  s.ios.deployment_target    = '9.0'
  s.ios.vendored_framework   = 'ios/YXYBaseViewController.framework'
end
