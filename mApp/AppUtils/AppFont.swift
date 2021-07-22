//
//  AppFont.swift
//  mApp
//
//  Created by Bahadır Enes Atay on 19.07.2021.
//

import UIKit

struct Font  {
    
    enum name: CustomStringConvertible {
        
        case iMedium
        case iRegular
        case iBold
        case iSemibold
        
        var description : String {
            switch self {
            case .iMedium:      return "Inter-Medium"
            case .iRegular:     return  "Inter-Regular"
            case .iBold:        return "Inter-Bold"
            case .iSemibold:    return "Inter-Semibold"
            }
        }
    }
    
    enum size {
        case small12
        case normal14
        case medium16
        case big18
        case big20
        case large26
        case large30
        case large32
        case large40
        
        var value : CGFloat {
            switch self {
            case .small12:    return 12
            case .normal14:   return 14
            case .medium16:   return 16
            case .big18:      return 18
            case .big20:      return 20
            case .large26:    return 26
            case .large30:    return 30
            case .large32:    return 32
            case .large40:    return 40
            }
        }
    }
}
