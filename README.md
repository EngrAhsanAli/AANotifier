# Table of Contents

- [AANotifier](#section-id-4)
  - [Description](#section-id-10)
  - [Demonstration](#section-id-16)
  - [Requirements](#section-id-26)
- [Installation](#section-id-32)
  - [CocoaPods](#section-id-37)
  - [Carthage](#section-id-63)
  - [Manual Installation](#section-id-82)
- [Getting Started](#section-id-87)
  - [Define your notifier!](#section-id-90)
  - [Show your notifier!](#section-id-104)
  - [Hide your notifier!](#section-id-132)
  - [AANotifier options](#section-id-150)
- [Contributions & License](#section-id-156)


<div id='section-id-4'/>

#AANotifier

[![Swift 4.0](https://img.shields.io/badge/Swift-4.0-orange.svg?style=flat)](https://developer.apple.com/swift/) [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage) [![CocoaPods](https://img.shields.io/cocoapods/v/AANotifier.svg)](http://cocoadocs.org/docsets/AANotifier) [![License MIT](https://img.shields.io/badge/License-MIT-blue.svg?style=flat)](https://github.com/Carthage/Carthage) [![Build Status](https://travis-ci.org/EngrAhsanAli/AANotifier.svg?branch=master)](https://travis-ci.org/EngrAhsanAli/AANotifier) 
![License MIT](https://img.shields.io/github/license/mashape/apistatus.svg) [![CocoaPods](https://img.shields.io/cocoapods/p/AANotifier.svg)]()


<div id='section-id-10'/>

##Description


AANotifier allows you to create UIView based fragments to be appear on screen at runtime. It is designed to make custom elements in UIView even from xib based views to animate on screen.


<div id='section-id-16'/>

##Demonstration

AANotifier can be a custom popup view, action bar, message display banner etc.

![](https://github.com/EngrAhsanAli/AANotifier/blob/master/Screenshots/demo.gif)


To run the example project, clone the repo, and run `pod install` from the Example directory first.


<div id='section-id-26'/>

##Requirements

- iOS 8.0+
- Xcode 8.0+
- Swift 3+

<div id='section-id-32'/>

# Installation

`AANotifier` can be installed using CocoaPods, Carthage, or manually.


<div id='section-id-37'/>

##CocoaPods

`AANotifier` is available through [CocoaPods](http://cocoapods.org). To install CocoaPods, run:

`$ gem install cocoapods`

Then create a Podfile with the following contents:

```
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

target '<Your Target Name>' do
pod 'AANotifier' , '1.0'
end

```

Finally, run the following command to install it:
```
$ pod install
```



<div id='section-id-63'/>

##Carthage

To install Carthage, run (using Homebrew):
```
$ brew update
$ brew install carthage
```
Then add the following line to your Cartfile:

```
github "EngrAhsanAli/AANotifier" "master"
```

Then import the library in all files where you use it:
```swift
import AANotifier
```


<div id='section-id-82'/>

##Manual Installation

If you prefer not to use either of the above mentioned dependency managers, you can integrate `AANotifier` into your project manually by adding the files contained in the Classes folder to your project.


<div id='section-id-87'/>

#Getting Started
----------

<div id='section-id-90'/>

##Define your notifier!

You can simply define your notifier with options as lazy initialization in your view controller.

**Usage:**
```swift
lazy var myNotifier: AANotifier = {
let notifierView = UIView.fromNib(nibName: "MyNotifier")!
let options: [AANotifierOptions] = [
.transitionA(.fromBottom, 0.9), // Show notifier animation
.transitionB(.toBottom, 0.9), // Hide notifier animation
.position(.bottom), // notifier position
.preferedHeight(50), // notifier height
.margins(H: 60, V: 40), // notifier margins
.hideStatusBar, // Hides the status bar view when animating
.hideOnTap, // Hides on tap
.deadline(2.0) // Deadline of notifier for dismissal
]
let notifier = AANotifier(notifierView, withOptions: options)
return notifier
}()

```




<div id='section-id-104'/>

##Show your notifier!
You can simply show the notifier by `show` method or `animateNotifer` for animation options.

**Usage:**
```swift
// Show simply!
myNotifier.show()

// Tap listner
notifier.didTapped = {
    notifier.hide()
}
```

<div id='section-id-132'/>

##Hide your notifier!

You can simply hide the notifier by `hide` method.

**Usage:**
```swift
// Show hide!
myNotifier.hide()

```

<div id='section-id-150'/>

##AANotifier options

You can use following notifier options for your notifier: 

|  Options	 	  |  Types	      	 	  | Description		    				       	 |
|-----------------|-----------------------|----------------------------------------------|
| `preferedHeight`| `CGFloat` 			  | AANotifier height    						 |
| `hideStatusBar` | `---` 				  | Status bar visibility if added 	 				 |
| `transitionA`   | `AAViewAnimators, TimeInterval`     | Animator for showing notifier 			     |
| `transitionB`   | `AAViewAnimators, TimeInterval`     | Animator for hiding notifier 				 |
| `position`      | `AANotifierPosition`  | AANotifier position	   						 |
| `hideOnTap` 	  | `---` 		  | Hides on tap if added	    			   	 |
| `margins`       | `(CGFloat?, CGFloat?)`| Horizontal and vertical margins respectively |

<div id='section-id-156'/>

#Contributions & License

`AANotifier` is available under the MIT license. See the [LICENSE](./LICENSE) file for more info.

Pull requests are welcome! The best contributions will consist of substitutions or configurations for classes/methods known to block the main thread during a typical app lifecycle.

I would love to know if you are using `AANotifier` in your app, send an email to [Engr. Ahsan Ali](mailto:hafiz.m.ahsan.ali@gmail.com)

