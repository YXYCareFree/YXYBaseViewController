#
# Be sure to run `pod lib lint YXYBaseViewController.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html

#pod lib lint YXYBaseViewController.podspec --allow-warnings --verbose  --use-libraries
#pod trunk push YXYBaseViewController.podspec --allow-warnings --verbose  --use-libraries

Pod::Spec.new do |s|
    s.name             = 'YXYBaseViewController'
    s.version          = '0.0.7'
    s.summary          = 'VC基类和常用的category'
    
    # This description is used to generate tags and improve search results.
    #   * Think: What does it do? Why did you write it? What is the focus?
    #   * Try to keep it short, snappy and to the point.
    #   * Write the description between the DESC delimiters below.
    #   * Finally, don't worry about the indent, CocoaPods strips it!
    
    s.description      = <<-DESC
    基类VC和常用的category
    DESC
    
    s.homepage         = 'https://github.com/YXYCareFree/YXYBaseViewController'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'YXYCareFree' => '576842121@qq.com' }
    s.source           = { :git => 'https://github.com/YXYCareFree/YXYBaseViewController.git', :tag => s.version.to_s }
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
    
    s.ios.deployment_target = '8.0'
    
#    s.source_files = 'YXYBaseViewController/Classes/**/*'

    s.subspec 'Category' do |category|
        category.source_files = 'YXYBaseViewController/Classes/Category/**/*'
    end

    s.subspec 'Network' do |network|
        network.source_files = 'YXYBaseViewController/Classes/Network/**/*'
        network.dependency 'YXYBaseViewController/Category'
        network.dependency 'YYCache'
    end

    s.subspec 'VC' do |vc|
        vc.source_files = 'YXYBaseViewController/Classes/VC/**/*'
        vc.dependency 'YXYBaseViewController/Category'
        vc.dependency 'YXYBaseViewController/YXYKit'
        vc.dependency 'YXYBaseViewController/View'
    end

   s.subspec 'View' do |view|
        view.source_files = 'YXYBaseViewController/Classes/View/**/*'
        view.dependency 'YXYBaseViewController/Category'
    end

    s.subspec 'YXYKit' do |yykit|
        yykit.source_files = 'YXYBaseViewController/Classes/YXYKit/**/*'
    end
    
#     s.resource_bundles = {
#       'YXYBaseViewController' => ['YXYBaseViewController/Assets/*.png']
#     }

    # s.public_header_files = 'Pod/Classes/**/*.h'
    # s.frameworks = 'UIKit', 'MapKit'
    s.dependency 'AFNetworking'
    s.dependency 'MJRefresh'
    s.dependency 'Masonry'
    s.dependency 'MBProgressHUD'
    s.dependency 'SDWebImage'
end
