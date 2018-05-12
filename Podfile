# Uncomment the next line to define a global platform for your project
platform :ios, '11.0'
use_frameworks!
inhibit_all_warnings!

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

target 'ReactorKitTestsExample' do
  development_pods

  target 'ReactorKitTestsExampleTests' do
    inherit! :complete
    testing_pods
  end

end
