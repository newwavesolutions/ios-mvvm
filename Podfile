# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

def shared_pods
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  
  # Pods for BaseMVVM
  #Load image
  pod 'Kingfisher'
  #Keyboard
  pod 'IQKeyboardManagerSwift'
  # Network
  pod 'Moya/RxSwift'
  #pod 'RxAlamofire'
  #Parser
  pod 'ObjectMapper'
  # Reactive
  #pod 'RxSwift'
  pod 'RxCocoa'
  # Auto Layout
  pod 'SnapKit'
  # Dialog
  pod 'MBProgressHUD'
  # Logger
  pod 'SwiftyBeaver'
  # Keychain
  pod 'KeychainAccess'
end

target 'BaseMVVM' do
  shared_pods
end

target 'BaseMVVM_prod' do
  shared_pods
end

post_install do |installer|
    installer.generated_projects.each do |project|
        project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
            end
        end
    end
end
