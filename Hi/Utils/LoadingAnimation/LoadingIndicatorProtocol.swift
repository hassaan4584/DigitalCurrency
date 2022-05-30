//
//  LoadingIndicatorProtocol.swift
//  Hi
//
//  Created by Hassaan Fayyaz Ahmed on 5/31/22.
//

import Foundation
import UIKit

protocol LoadingIndicatorProtocol: AnyObject {

    // MARK: Properties

    /// The imageview that contains png sequence to be played
    var indicatorImageView: UIImageView { get }
    /// The weak reference to view in which indicator is being shown
    var currentContaingView: UIView? { get set }
    /// frame for the `indicatorImageView`
    var frame: CGRect { get }
    /// The constraints to be applied on the indicatorImageView
    var indicatorViewConstraints: [NSLayoutConstraint]? { get set }

    // MARK: Methods
    func setupViews()
    func show(inView parentView: UIView)
    func hide(from view: UIView)
}

extension LoadingIndicatorProtocol {
    // MARK: Default Method definitions
    /// if the parentView is passed as nil, the indicator gets added to the rootVC of window
    func show(inView parentView: UIView) {
        if let containerView = currentContaingView, containerView == parentView {
            return
        } else if currentContaingView != nil {
            // if the loading indicator is already present
            self.indicatorImageView.removeFromSuperview()
            self.currentContaingView = nil
        }

        self.setupViews()

        // add indicator to that parentView view and keep track of it
        self.currentContaingView = parentView

        self.addIndicatorTo(view: parentView)
    }

    /// removes the indicator from the container view. If the passed view is nil, this forces the indicator to hide, no matter what
    func hide(from view: UIView) {
        if let currentView = self.currentContaingView, view == currentView {
            // if indicator hiding request is generated from the same view that contains the indicator, we will hide the indicator
            self.stop()
        }
        // other wise if the indicator hiding request is generated from a view that does not currently contain the indicator, that request will be ignored
    }

    // MARK: Helper functions
    private func stop() {
        self.indicatorImageView.stopAnimating()
        if var constraint = self.indicatorViewConstraints {
            NSLayoutConstraint.deactivate(constraint)
            constraint.removeAll()
        }
        self.indicatorImageView.removeFromSuperview()
        self.currentContaingView = nil
    }

    private func addIndicatorTo(view: UIView) {
        self.indicatorImageView.frame = frame
        view.addSubview(self.indicatorImageView)

        self.addConstraints(for: view)
        self.indicatorImageView.startAnimating()
    }

    private func addConstraints(for view: UIView) {

        self.indicatorImageView.translatesAutoresizingMaskIntoConstraints = false
        let constraint = [
            indicatorImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicatorImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            indicatorImageView.widthAnchor.constraint(equalToConstant: CGFloat(frame.width)),
            indicatorImageView.heightAnchor.constraint(equalToConstant: frame.height)
        ]
        NSLayoutConstraint.activate(constraint)
        self.indicatorViewConstraints = constraint
    }

}
