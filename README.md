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

- How to use UIHostingController:

a. Presenting a UIHostingController as a modal view controller:

```swift
let swiftUIView = SwiftUIView()
let hostingController = UIHostingController(rootView: swiftUIView)

hostingController.modalTransitionStyle = .crossDissolve
hostingController.modalPresentationStyle = .popover

// Present the hosting controller modally
self.present(hostingController, animated: true, completion: nil)
```

For **modalTransitionsStyle**, we have options like `flipHorizontal`, `coverVertical`, `crossDissolve`, and `partialCurl`.

For **modalPresentationStyle**, we have options like `fullScreen`, `formSheet`, `popover`, `automatic`, `currentContext`, `custom`, `overCurrentContext`, `overFullScreen`, `pageSheet`, and `none`

**modalTransitionStyle** option as `partialCurl`must go with **modalPresentationStyle** as `.fullScreen` to demo the effect. Otherwise, we will receive an error similar to the following one from compiler:

`Thread 1: "Application tried to present UIModalTransitionStylePartialCurl to or from non-fullscreen view controller <SwiftUIViewForUIKitProject.ViewController: 0x7fb429008eb0>."`

b. Present a hosting view controller as an embedded view onto the UIKit view

- Build the following custom function:

```swift
    /// Fully add SwiftUI `view` onto the UIKit `view`
    /// - Parameters:
    ///   - swiftUIView: The SwiftUI `view` to add as a child.
    ///   - view: The `UIView` instance to which the view should be added.
    func addSubSwiftUIView<Content>(_ swiftUIView: Content, to view: UIView) where Content: View {
        let hostingController = UIHostingController(rootView: swiftUIView)
        /// Add the hosting controller as a child view controller for the current view controller
        self.addChild(hostingController)
        
        /// add the SwiftUI view to the view controller view hierarchy
        self.view.addSubview(hostingController.view)
        
        /// Setup the constraints to update the SwiftUI view boundaries
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.leftAnchor.constraint(equalTo: view.leftAnchor),
            view.bottomAnchor.constraint(equalTo: hostingController.view.bottomAnchor),
            view.rightAnchor.constraint(equalTo: hostingController.view.rightAnchor)
        ])
        
        /// Notify the hosting controller that it has been moved to the current view controller
        hostingController.didMove(toParent: self)
    }
```
- Use the custom function above to present the hosting controller

```swift
let swiftUIVIew = SwiftUIView()
self.addSubSwiftUIView(swiftUIVIew, to: view)
```


- When the SwiftUI content inside UIHostingController changes, it may cause the view to need to be resized.




