platform :ios, '13.0'

post_install do |installer|
  installer.generated_projects.each do |project|
    project.targets.each do |target|
      target.build_configurations.each do |config|
          config.build_settings['CLANG_WARN_QUOTED_INCLUDE_IN_FRAMEWORK_HEADER'] = 'NO'
      end
    end
  end
end

target 'EmpikTestWeatherApp' do
	use_frameworks!

	pod 'RxSwift', '6.6.0'
	pod 'RxCocoa', '6.6.0'
	pod 'Swinject'
	
end
