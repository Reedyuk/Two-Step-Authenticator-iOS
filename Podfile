source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '11.0'
use_frameworks!
inhibit_all_warnings!

def required_pods

pod 'Texture'
pod 'OneTimePassword', git: 'git@github.com:Reedyuk/OneTimePassword.git'
#pod 'OneTimePassword', path: '../OneTimePassword'
pod 'Base32'

end

target "Two Step Authenticator" do
    required_pods
end

target "TSAKeyboard" do
    required_pods
end
