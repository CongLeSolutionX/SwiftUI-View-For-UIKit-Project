//
//  ViewController.swift
//  SwiftUIViewForUIKitProject
//
//  Created by Cong Le on 8/18/21.
//
// Reference: https://www.avanderlee.com/swiftui/integrating-swiftui-with-uikit

import UIKit
import SwiftUI /// contains instance `UIHostingController`

class ViewController: UIViewController {
  
  lazy var buttonToPresentSwiftUIView: UIButton = {
    let button = UIButton(type: .system)
    button.backgroundColor = .yellow
    button.setTitle("Present SwiftUI View", for: .normal)
    button.setTitleColor(.black, for: .normal)
    button.layer.cornerRadius = 5.0
    button.translatesAutoresizingMaskIntoConstraints = false
    button.addTarget(self, action: #selector(presentSwiftUIView), for: .touchUpInside)
    return button
  }()
  
  lazy var buttonToAddSwiftUIViewToUIKitView: UIButton = {
    let button = UIButton(type: .system)
    button.backgroundColor = .yellow
    button.setTitle("Add SwiftUI View", for: .normal)
    button.setTitleColor(.black, for: .normal)
    button.layer.cornerRadius = 5.0
    button.translatesAutoresizingMaskIntoConstraints = false
    button.addTarget(self, action: #selector(addSwiftUIView), for: .touchUpInside)
    return button
  }()
  
  lazy var buttonToAddSwiftUIViewToUIKitViewThroughExtension: UIButton = {
    let button = UIButton(type: .system)
    button.backgroundColor = .yellow
    button.setTitle("Add SwiftUI View via extension", for: .normal)
    button.setTitleColor(.black, for: .normal)
    button.layer.cornerRadius = 5.0
    button.translatesAutoresizingMaskIntoConstraints = false
    button.addTarget(self, action: #selector(addSwiftUIView), for: .touchUpInside)
    return button
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .red
    navigationItem.title = "UIViewController Title"
    navigationItem.largeTitleDisplayMode = .always
    
    // Button to present the SwiftUI view
    view.addSubview(buttonToPresentSwiftUIView)
    
    // Button to add SwiftUI View
    view.addSubview(buttonToAddSwiftUIViewToUIKitView)
    
    // Button to add SwiftUI view from extension of UIViewController
    view.addSubview(buttonToAddSwiftUIViewToUIKitViewThroughExtension)
    
    setupConstraints()
  }
  
  func setupConstraints() {
    NSLayoutConstraint.activate([
      buttonToPresentSwiftUIView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      buttonToPresentSwiftUIView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      buttonToAddSwiftUIViewToUIKitView.topAnchor.constraint(equalTo: buttonToPresentSwiftUIView.bottomAnchor, constant: 20),
      buttonToAddSwiftUIViewToUIKitView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      buttonToAddSwiftUIViewToUIKitViewThroughExtension.topAnchor.constraint(equalTo: buttonToAddSwiftUIViewToUIKitView.bottomAnchor, constant: 20),
      buttonToAddSwiftUIViewToUIKitViewThroughExtension.centerXAnchor.constraint(equalTo: view.centerXAnchor)
    ])
  }
}

// MARK: - Different methods to display SwiftUI view into UIKit view controller
extension ViewController {
  
  // Preseting a SwiftUI view in UIKit View Controller
  @objc func presentSwiftUIView() {
    let swiftUIView = SwiftUIView()
    let hostingController = UIHostingController(rootView: swiftUIView)
    present(hostingController, animated: true, completion: nil)
  }
  
  // Add a SwiftUI view to a UIKit View
  @objc func addSwiftUIView() {
    let swiftUIView = SwiftUIView()
    let hostingController = UIHostingController(rootView: swiftUIView)
    hostingController.modalTransitionStyle = .crossDissolve
    navigationController?.pushViewController(hostingController, animated: true)
  }
  
  @objc func addSwiftUIViewViaExtension() {
    self.addSwiftUIView()
  }
}

//MARK: - UIViewController Extension
extension UIViewController {
  // Fully add SwiftUI view onto the UIKit view
  func addSubSwiftUIView<Content>(_ swiftUIView: Content, to view: UIView) where Content: View {
    let hostingController = UIHostingController(rootView: swiftUIView)
    // add a child of the current view controller
    addChild(hostingController)
    
    // add the SwiftUI view to the view controller view hierarchy
    view.addSubview(hostingController.view)
    
    // Setup the constraints to update the SwiftUI view boundaries
    hostingController.view.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
      hostingController.view.leftAnchor.constraint(equalTo: view.leftAnchor),
      view.bottomAnchor.constraint(equalTo: hostingController.view.bottomAnchor),
      view.rightAnchor.constraint(equalTo: hostingController.view.rightAnchor)
    ])
    
    // Notify the hosting controller that it has been moved to the current view controller
    hostingController.didMove(toParent: self)
  }
}
