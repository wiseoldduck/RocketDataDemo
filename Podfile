# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'RocketDataDemo' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

	pod 'RocketData', '~> 4.0.1'
	pod 'PINCache', :git => 'https://github.com/pinterest/PINCache.git', :commit => '58635e4ff8d00fcd25084259a625c0615e9d071a'
	
  # Pods for RocketDataDemo

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.0'
    end
  end
end