//
//  CAMediaTimingFunctions+Extensions.swift
//  TheCatApp
//
//  Created by Frédéric ASTIC on 04/10/2018.
//  Copyright © 2018 Fouinasse. All rights reserved.
//

import Foundation
import QuartzCore

enum BezierType {
    case Default
    case Linear
    
    case EaseIn
    case EaseOut
    case EaseInOut
    
    case SineIn
    case SineOut
    case SineInOut
    
    case QuadIn
    case QuadOut
    case QuadInOut
    
    case CubicIn
    case CubicOut
    case CubicInOut
    
    case QuartIn
    case QuartOut
    case QuartInOut
    
    case QuintIn
    case QuintOut
    case QuintInOut
    
    case ExpoIn
    case ExpoOut
    case ExpoInOut
    case ExpoOutCustom
    
    case CircIn
    case CircOut
    case CircInOut
    
    case BackIn
    case BackOut
    case BackInOut
}

extension CAMediaTimingFunction {
    convenience init(type: BezierType) {
        switch type {
        case .Default: self.init(name: CAMediaTimingFunctionName.default)
        case .Linear: self.init(name: CAMediaTimingFunctionName.linear)
            
        case .EaseIn: self.init(name: CAMediaTimingFunctionName.easeIn)
        case .EaseOut: self.init(name: CAMediaTimingFunctionName.easeOut)
        case .EaseInOut: self.init(name: CAMediaTimingFunctionName.easeInEaseOut)
            
        case .SineIn: self.init(controlPoints: 0.45, 0, 1, 1)
        case .SineOut: self.init(controlPoints: 0, 0, 0.55, 1)
        case .SineInOut: self.init(controlPoints: 0.45, 0, 0.55, 1)
            
        case .QuadIn: self.init(controlPoints: 0.43, 0, 0.82, 0.60)
        case .QuadOut: self.init(controlPoints: 0.18, 0.4, 0.57, 1)
        case .QuadInOut: self.init(controlPoints: 0.43, 0, 0.57, 1)
            
        case .CubicIn: self.init(controlPoints: 0.67, 0, 0.84, 0.54)
        case .CubicOut: self.init(controlPoints: 0.16, 0.46, 0.33, 1)
        case .CubicInOut: self.init(controlPoints: 0.65, 0, 0.35, 1)
            
        case .QuartIn: self.init(controlPoints: 0.81, 0, 0.77, 0.34)
        case .QuartOut: self.init(controlPoints: 0.23, 0.66, 0.19, 1)
        case .QuartInOut: self.init(controlPoints: 0.81, 0, 0.19, 1)
            
        case .QuintIn: self.init(controlPoints: 0.89, 0, 0.81, 0.27)
        case .QuintOut: self.init(controlPoints: 0.19, 0.73, 0.11, 1)
        case .QuintInOut: self.init(controlPoints: 0.9, 0, 0.1, 1)
            
        case .ExpoIn: self.init(controlPoints: 1.04, 0, 0.88, 0.49)
        case .ExpoOut: self.init(controlPoints: 0.12, 0.51, -0.4, 1)
        case .ExpoInOut: self.init(controlPoints: 0.95, 0, 0.05, 1)
        case .ExpoOutCustom: self.init(controlPoints: 5/6, 0.2, 2/6, 0.9)
            
            
        case .CircIn: self.init(controlPoints: 0.6, 0, 1, 0.45)
        case .CircOut: self.init(controlPoints: 1, 0.55, 0.4, 1)
        case .CircInOut: self.init(controlPoints: 0.82, 0, 0.18, 1)
            
        case .BackIn: self.init(controlPoints: 0.77, -0.63, 1, 1)
        case .BackOut: self.init(controlPoints: 0, 0, 0.23, 1.37)
        case .BackInOut: self.init(controlPoints: 0.77, -0.63, 0.23, 1.37)
        }
    }
}
