# Uncomment the next line to define a global platform for your project
platform :ios, '10.0'

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
