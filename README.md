# Add SwiftUI View For UIKit Project
A sample project demonstrate 3 methods to present a SwiftUI View on an existing UIKit project using UIViewControllers 

## Video Demo
<p align="center">
<img src="https://user-images.githubusercontent.com/31250006/130022854-48e401c3-3ecb-471c-9286-c96b97d5977e.gif" width="300" height="600"/>
</p>

#Using SwiftUI with UIKit
* UIHostingController 
* Bridging data 
* SwiftUI in cells 
* Data flow for cells

### UIHostingController

- UIHostingController is a UIViewController that contains a SwiftUI view hierarchy. 
- We can use a hosting controller anywhere we can use a view controller in UIKit.
- Structure of UIHostingController: UIHostingController is a view controller, which means it has a UIView stored in its view property, and inside that view is where the SwiftUI content is rendered.

<p align="center">
<img src="./Images/UIHostingController.png" width="600" height="600"/>
</p>

- How to use UIHostingController

a. Presenting a UIHostingController as a modal view controller:

```swift
let swiftUIView = SwiftUIView()
let hostingController = UIHostingController(rootView: swiftUIView)

// Present the hosting controller modally
self.present(hostingController, animated: true, completion: nil)
```

b. Present a hosting view controller as an embedded view onto the UIKit view





