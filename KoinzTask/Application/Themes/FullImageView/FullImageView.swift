//
//  FullImageView.swift
//  KoinzTask
//
//  Created by Rowaad on 19/05/2022.
//

import Foundation
import UIKit

/// SwifterSwift: Open image on Full screen
///
/// - Parameter style: full screen
/// - Returns: .
@IBDesignable
class FullImageView: UIImageView {
    //Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        fullScreenWhenTapped()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fullScreenWhenTapped()
    }

    // MARK: - FUNCTIONS
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    override func draw(_ rect: CGRect) {
        if clipsToBounds {
            layer.masksToBounds = true
            layer.cornerRadius = 8
            // Outer UIView to hold the Shadow
            let shadow = UIView(frame: rect)
            shadow.layer.cornerRadius = 8
            shadow.layer.masksToBounds = false
            shadow.addSubview(self)
        }
    }
    override func awakeFromNib() {
    }

    //open Full screen
    fileprivate func fullScreenWhenTapped() {
        self.isUserInteractionEnabled = true
        let tap1: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.imageClicked))
        self.addGestureRecognizer(tap1)
    }
    //image on Full screen when clicked
    @objc fileprivate func imageClicked() {
        let scene = FullImageViewController(image: self.image)
        scene.modalPresentationStyle = .overFullScreen
        scene.modalTransitionStyle = .crossDissolve
        UIApplication.topViewController()?.present(scene, animated: false, completion: nil)
    }
}


class FullImageViewController: UIViewController {
    lazy var mainView: UIView = {
        let view = UIView(frame: self.view.frame)
        view.backgroundColor = .black
        return view
    }()
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 6.0
        return scrollView
    }()
    lazy var displayImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        return imageView
    }()
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "close"), for: .normal)
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(self.closeBtnClicked(_:)), for: .touchUpInside)
        return button
    }()
    var image: UIImage?

    init(image: UIImage?) {
        self.image = image
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func loadView() {
        super.loadView()
        view = mainView
    }
    override func viewDidLoad() {
        mainView.addSubview(scrollView)
        scrollView.addSubview(displayImage)
        mainView.addSubview(backButton)
        addScrollViewConstraint()
        addDisplayImageConstraint()
        addBackButtonConstraint()
        setupGesture()
        displayImage.image = image
    }
    fileprivate func addScrollViewConstraint() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo:view.trailingAnchor),
        ])
    }
    fileprivate func addDisplayImageConstraint() {
        NSLayoutConstraint.activate([
            displayImage.topAnchor.constraint(equalTo: scrollView.topAnchor),
            displayImage.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            displayImage.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            displayImage.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            displayImage.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1),
            displayImage.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 1)
        ])
    }
    fileprivate func addBackButtonConstraint() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            backButton.widthAnchor.constraint(equalToConstant: 80),
            backButton.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    fileprivate func setupGesture() {
        let single = UITapGestureRecognizer(target: self, action: #selector(singleTap))
        let double = UITapGestureRecognizer(target: self, action: #selector(doubleTap(_:)))
        double.numberOfTapsRequired = 2
        single.require(toFail: double)
        scrollView.addGestureRecognizer(single)
        scrollView.addGestureRecognizer(double)
    }
    // MARK: Gesture
    @objc fileprivate func singleTap() {
        dismiss(animated: true, completion: nil)
    }
    @objc fileprivate func doubleTap(_ gesture: UITapGestureRecognizer) {
        let point = gesture.location(in: scrollView)
        if scrollView.zoomScale == 1.0 {
            scrollView.zoom(to: CGRect(x: point.x-40, y: point.y-40, width: 80, height: 80), animated: true)
        } else {
            scrollView.setZoomScale(1.0, animated: true)
        }
    }
    @objc fileprivate func closeBtnClicked(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

extension FullImageViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return displayImage
    }
}
