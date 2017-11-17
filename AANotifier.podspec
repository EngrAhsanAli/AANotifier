
Pod::Spec.new do |s|
s.name             = 'AANotifier'
s.version          = '0.1.1'
s.summary          = 'AANotifier allows you to create UIView based fragments to be appear on screen at runtime in iOS, written in Swift.'

s.description      = <<-DESC
AANotifier allows you to create UIView based fragments to be appear on screen at runtime. It is designed to make custom elements in UIView even from xib based to animate on screen. It can be a custom popup view, action bar, message display banner etc.
DESC

s.homepage         = 'https://github.com/EngrAhsanAli/AANotifier'
s.screenshots     = 'https://raw.githubusercontent.com/EngrAhsanAli/AANotifier/master/Screenshots/AANotifier.png'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'EngrAhsanAli' => 'hafiz.m.ahsan.ali@gmail.com' }
s.source           = { :git => 'https://github.com/EngrAhsanAli/AANotifier.git', :tag => s.version.to_s }

s.ios.deployment_target = '8.0'

s.source_files = 'AANotifier/Classes/**/*'

s.dependency 'AAViewAnimator', '~> 0.1.1'
end

