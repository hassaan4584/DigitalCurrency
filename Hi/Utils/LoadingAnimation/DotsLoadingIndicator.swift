//
//  DotsLoadingIndicator.swift
//  Hi
//
//  Created by Hassaan Fayyaz Ahmed on 5/31/22.
//

import Foundation
import UIKit

private let indicatorAnimationDuration: TimeInterval = 1.0
private var dotsImageNameFormat: String { return "dots_black_00%03d" }
private let indicatorWidth: CGFloat = 120
private let indicatorHeight: CGFloat = 120

private var loadingIndicatorFrame: CGRect { return CGRect(x: 0, y: 0, width: indicatorWidth, height: indicatorHeight) }

final class DotsLoadingIndicator: NSObject {

    static var indicator = DotsLoadingIndicator()

    fileprivate var loadingIndicatorImageView: UIImageView = UIImageView.init(frame: loadingIndicatorFrame)
    fileprivate var constraints: [NSLayoutConstraint]?
    /// The weak reference to view in which `DotsIndicators` are being shown
    fileprivate weak var currentContainerView: UIView?

    override init() {
        super.init()

        self.setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    fileprivate func createImages() -> [UIImage]? {
        let intArr = [Int].init((10...45))
        let imgs = intArr.map { (value) -> UIImage? in
            let imageName: String = String(format: dotsImageNameFormat, value)
            let image = UIImage.init(named: imageName)
            return image
        }
        return imgs.compactMap { return $0 }
    }
}

extension DotsLoadingIndicator: LoadingIndicatorProtocol {

    var indicatorImageView: UIImageView { return self.loadingIndicatorImageView }

    var frame: CGRect { return loadingIndicatorFrame }

    var currentContaingView: UIView? {
        get { return self.currentContainerView }
        set { self.currentContainerView = newValue }
    }

    var indicatorViewConstraints: [NSLayoutConstraint]? {
        get { return self.constraints }
        set { self.constraints = newValue }
    }

    func setupViews() {
        self.loadingIndicatorImageView.backgroundColor = UIColor.gray.withAlphaComponent(0.3)
        self.loadingIndicatorImageView.layer.cornerRadius = 8.0

        self.loadingIndicatorImageView.animationImages = self.createImages()
        self.loadingIndicatorImageView.animationDuration = indicatorAnimationDuration
    }
}
