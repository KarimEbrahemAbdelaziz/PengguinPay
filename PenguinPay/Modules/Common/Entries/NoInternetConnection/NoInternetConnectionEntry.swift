//
//  NoInternetConnectionEntry.swift
//  PenguinPay
//
//  Created by Karim Ebrahem on 03/08/2021.
//

import Foundation
import UIKit
import SwiftEntryKit

class NoInternetConnectionEntry: UIView {

    static var attributes: EKAttributes {
        var customAttributes = EKAttributes()
        customAttributes = EKAttributes.centerFloat
        customAttributes.hapticFeedbackType = .success
        customAttributes.displayDuration = .infinity
        customAttributes.entryBackground = .color(color: .white)
        customAttributes.screenBackground = .color(color: EKColor(light:  UIColor(white: 50.0/255.0, alpha: 0.3), dark: UIColor(white: 0, alpha: 0.5)))
        customAttributes.shadow = .active(
            with: .init(
                color: .black,
                opacity: 0.3,
                radius: 8
            )
        )
        customAttributes.screenInteraction = .absorbTouches
        customAttributes.entryInteraction = .absorbTouches
        customAttributes.scroll = .enabled(
            swipeable: false,
            pullbackAnimation: .jolt
        )
        customAttributes.roundCorners = .all(radius: 8)
        customAttributes.entranceAnimation = .init(
            translate: .init(
                duration: 0.7,
                spring: .init(damping: 0.7, initialVelocity: 0)
            ),
            scale: .init(
                from: 0.7,
                to: 1,
                duration: 0.4,
                spring: .init(damping: 1, initialVelocity: 0)
            )
        )
        customAttributes.exitAnimation = .init(
            translate: .init(duration: 0.2)
        )
        customAttributes.popBehavior = .animated(
            animation: .init(
                translate: .init(duration: 0.35)
            )
        )
        customAttributes.positionConstraints.size = .init(
            width: .offset(value: 20),
            height: .intrinsic
        )
        customAttributes.positionConstraints.maxSize = .init(
            width: .constant(value: UIScreen.main.minEdge),
            height: .intrinsic
        )
        customAttributes.statusBar = .dark
        return customAttributes
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setupUI()
    }

    init() {
        super.init(frame: .zero)

        setupUI()
    }

    private func setupUI() {
        fromNib()
        clipsToBounds = true
        layer.cornerRadius = 16
    }
}
