# Uncomment the next line to define a global platform for your project
platform :ios, '11.0'

target 'ReactorKitTestsExample' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  def development_pods
    pod 'RxSwift'
    pod 'ReactorKit'
  end

  def testing_pods
    pod 'RxBlocking'
    pod 'Quick'
    pod 'Nimble'
    pod 'Stubber'
  end

  development_pods

  target 'ReactorKitTestsExampleTests' do
    inherit! :search_paths
    testing_pods
  end

end
