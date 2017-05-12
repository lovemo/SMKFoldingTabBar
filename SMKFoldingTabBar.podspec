Pod::Spec.new do |s|
    s.name                  = 'SMKFoldingTabBar'
    s.version      = '0.0.1'
    s.summary               = 'SMKFoldingTabBar - An Awesome Folding Custom View '
    s.homepage              = 'https://github.com/lovemo/SMKFoldingTabBar'
    s.platform     = :ios, '7.0'
    s.license               = 'MIT'
    s.author                = { 'lovemo' => 'lovemomoyulin@qq.com' }
    s.source                = { :git => 'https://github.com/lovemo/SMKFoldingTabBar',:tag => '0.0.1' }
    s.requires_arc          = true
    s.source_files = 'SMKFoldingTabBar/*'
    s.framework             = 'Foundation','UIKit'

    s.subspec 'SMKFoldingTabBar' do |ss|
    ss.dependency 'Masonry'
    end

end
