//
//  ViewController.swift
//  SwiftUIViewForUIKitProject
//
//  Created by Cong Le on 8/18/21.
//
// Reference: https://www.avanderlee.com/swiftui/integrating-swiftui-with-uikit

import UIKit
import SwiftUI /// contains instance `UIHostingController`
import Combine /// contains `AnyCancellable`

class MainUIKitViewController: UIViewController {
    private var cancellable: AnyCancellable?
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            buttonToPresentSwiftUIView,
            buttonToAddSwiftUIViewToUIKitView,
            buttonToAddSwiftUIViewToUIKitViewThroughExtension,
            buttonToPresentSwiftUIViewWithData,
            inputReceivedFromSwifUIView,
            buttonToPresentSwiftUIViewWithManuallyPassedData
        ])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var buttonToPresentSwiftUIView: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .yellow
        button.setTitle("Present SwiftUI View", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 5.0
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(presentSwiftUIView), for: .touchUpInside)
        return button
    }()
    
    private lazy var buttonToAddSwiftUIViewToUIKitView: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .yellow
        button.setTitle("Add SwiftUI View", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 5.0
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(addSwiftUIView), for: .touchUpInside)
        return button
    }()
    
    private lazy var buttonToAddSwiftUIViewToUIKitViewThroughExtension: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .yellow
        button.setTitle("Add SwiftUI View via extension", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 5.0
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(addSwiftUIViewViaExtension), for: .touchUpInside)
        return button
    }()
    
    private lazy var buttonToPresentSwiftUIViewWithData: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .yellow
        button.setTitle("Present SwiftUI View and \nsend data automatically from SwiftUI view to UIKit view", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 5.0
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.titleLabel?.textAlignment = .center
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(presentSwiftUIViewWithData), for: .touchUpInside)
        return button
    }()
    private lazy var inputReceivedFromSwifUIView: UILabel = {
        let label = UILabel()
        label.text = ""
        label.backgroundColor = .cyan
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var buttonToPresentSwiftUIViewWithManuallyPassedData: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .yellow
        button.setTitle("Present SwiftUI View and \nsend data manually from SwiftUI view to UIKit view", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 5.0
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.titleLabel?.textAlignment = .center
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(passDataManually), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
        self.view.addSubview(stackView)
        
        // Set up navigation controller
        self.navigationItem.title = "UIViewController Title"
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.backgroundColor = .green
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
        ])
    }
}

// MARK: - Different methods to display SwiftUI view into UIKit view controller
extension MainUIKitViewController {
    
    /// Preseting a SwiftUI view in UIKit View Controller
    @objc private func presentSwiftUIView() {
        let swiftUIView = SwiftUIView()
        let hostingController = UIHostingController(rootView: swiftUIView)
        
        hostingController.modalTransitionStyle = .crossDissolve
        hostingController.modalPresentationStyle = .popover
        
        if #available(iOS 16.0, *) {
            hostingController.sizingOptions = .preferredContentSize
        } else {
            // Fallback on earlier versions
        }
        // Present the hosting controller modally
        present(hostingController, animated: true, completion: nil)
    }
    
    /// Add a SwiftUI view to a UIKit View
    @objc private func addSwiftUIView() {
        let swiftUIView = SwiftUIView()
        let hostingController = UIHostingController(rootView: swiftUIView)
        
        navigationController?.pushViewController(hostingController, animated: true)
    }
    
    @objc private func addSwiftUIViewViaExtension() {
        let swiftUIView = SwiftUIView()
        self.addSubSwiftUIView(swiftUIView, to: view)
    }
    
    @objc private func presentSwiftUIViewWithData() {
        let contentViewWithData = ContentViewData()
        let swiftUIViewWithData = AutomaticBridgingDataSwiftUIView(data: contentViewWithData)
        let hostingController: UIHostingController<AutomaticBridgingDataSwiftUIView>
        
        hostingController = UIHostingController(rootView: swiftUIViewWithData)
        
        hostingController.modalTransitionStyle = .flipHorizontal
        hostingController.modalPresentationStyle = .popover
        
        self.cancellable = contentViewWithData.$name.sink { name in
            self.inputReceivedFromSwifUIView.text = name
        }
        
        self.present(hostingController, animated: true)
    }
    
    @objc private func passDataManually() {
        let hostingController: UIHostingController<ManualBridgingDataSwiftUIView>
        var beatsPerMinute: Int = 0 {
            didSet { update() }
        }
        
        func update() {
            hostingController.rootView = ManualBridgingDataSwiftUIView(beatPerMinutes: beatsPerMinute)
            
        }
        
        hostingController = UIHostingController(rootView: ManualBridgingDataSwiftUIView(beatPerMinutes: 0))
        print(beatsPerMinute)
        beatsPerMinute = 100
        print(beatsPerMinute)
        present(hostingController, animated: true)
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
