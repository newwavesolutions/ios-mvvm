//
//  Configs.swift
//  BaseMVVM
//
//  Created by Lê Thọ Sơn on 3/29/20.
//  Copyright © 2020 thoson.it. All rights reserved.
//

import UIKit


// All keys are demonstrative and used for the test.
enum Keys {
    case github, mixpanel, adMob

    var apiKey: String {
        switch self {
        case .github: return "5a39979251c0452a9476bd45c82a14d8e98c3fb3"
        case .mixpanel: return "7e428bc407e3612f6d3a4c8f50fd4643"
        case .adMob: return "ca-app-pub-3940256099942544/2934735716"
        }
    }

    var appId: String {
        switch self {
        case .github: return "00cbdbffb01ec72e280a"
        case .mixpanel: return ""
        case .adMob: return ""  // See GADApplicationIdentifier in Info.plist
        }
    }
}

struct Configs {

    struct App {
        static let bundleIdentifier = "thoson.it"
    }

    struct Network {
        static let apiBaseUrl = "https://api.themoviedb.org"
        static let apiKey = "26763d7bf2e94098192e629eb975dab0"
    }

    struct BaseDimensions {
        static let inset: CGFloat = 10
        static let tabBarHeight: CGFloat = 58
        static let toolBarHeight: CGFloat = 66
        static let navBarWithStatusBarHeight: CGFloat = 64
        static let cornerRadius: CGFloat = 5
        static let borderWidth: CGFloat = 1
        static let buttonHeight: CGFloat = 40
        static let textFieldHeight: CGFloat = 40
        static let tableRowHeight: CGFloat = 40
        static let segmentedControlHeight: CGFloat = 40
    }

    struct Path {
        static let Documents = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        static let Tmp = NSTemporaryDirectory()
    }

    struct UserDefaultsKeys {
        static let OAuthToken = "OAuthToken"
        static let CurrentUser = "CurrentUser"
    }
    
    struct DateFormart {
        static let date = "dd/MM/yyyy"
        static let time = "HH:mm"
        static let dateTime = "dd/MM/yyyy HH:mm"
    }
}
