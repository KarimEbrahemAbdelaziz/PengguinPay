//
//  CGRect+Extensions.swift
//  PenguinPay
//
//  Created by Karim Ebrahem on 05/08/2021.
//

import Foundation
import UIKit

extension CGRect {
    var minEdge: CGFloat {
        return min(width, height)
    }
}
