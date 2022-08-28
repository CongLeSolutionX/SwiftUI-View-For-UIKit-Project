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
        button.addTarget(self, action: #selector(addSwiftUIViewViaExtension), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        navigationItem.title = "UIViewController Title"
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.backgroundColor = .green
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
    
    /// Preseting a SwiftUI view in UIKit View Controller
    @objc func presentSwiftUIView() {
        let swiftUIView = SwiftUIView()
        let hostingController = UIHostingController(rootView: swiftUIView)
  
        hostingController.modalTransitionStyle = .crossDissolve
        hostingController.modalPresentationStyle = .popover
        
        // Present the hosting controller modally
        present(hostingController, animated: true, completion: nil)
    }
    
    /// Add a SwiftUI view to a UIKit View
    @objc func addSwiftUIView() {
        let swiftUIView = SwiftUIView()
        let hostingController = UIHostingController(rootView: swiftUIView)
    
        navigationController?.pushViewController(hostingController, animated: true)
    }
    
    @objc func addSwiftUIViewViaExtension() {
        let swiftUIVIew = SwiftUIView()
        self.addSubSwiftUIView(swiftUIVIew, to: view)
    }
}

//MARK: - UIViewController Extension
extension UIViewController {
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
}
