//
//  AppLocalization.swift
//  mApp
//
//  Created by Bahadır Enes Atay on 19.07.2021.
//

import UIKit
import Localize_Swift

class AppLocalization {
    
    enum Key: String {
        case DETAIL_GENRE_TITLE
        case DETAIL_DIRECTOR_TITLE
        case DETAIL_WRITER_TITLE
        case DETAIL_PLOT_TITLE
        case DETAIL_YEAR_TITLE
        case DETAIL_RATING_TITLE
        case DETAIL_TYPE_TITLE
        case DETAIL_RUNTIME_TITLE
        case DETAIL_AWARDS_TITLE
        case DETAIL_PRODUCTION_TITLE
        case HOME_NO_RESULT_ALERT_TEXT
        case HOME_EMPTY_SEARCH_BAR_ALERT_TEXT
        case GLOBAL_SEARCH_BAR_PLACEHOLDER
        case GLOBAL_CANCEL_BUTTON_TITLE
        var value: String {
            return self.rawValue
        }
    }
    
    class func text(_ key: Key) -> String {
        if key.value.localized().isEmpty {
            return key.rawValue
        }
        return key.value.localized()
    }
    
//    class func currentLang() {
//        AppRoot.selectedLang = Language.init(rawValue: Localize.currentLanguage()) ?? .tr
//    }
    
    
}

enum Language: String {
    case tr = "tr"
    case en = "en"
    var code: Int {
        switch self {
        case .tr:
            return 1
        case .en:
            return 2
        }
    }
    static let list: [Language] = [.tr, .en]
}

