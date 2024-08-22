//
//  Utils.swift
//  HLX Trader
//

import UIKit
import SafariServices

enum SOCIAL_LOGIN_ENUM : String{
    case Facebook = "kFacebook"
    case Twitter = "kTwitter"
    case Instagram = "kInstagram"
    case Linkedin = "kLinkedin"
    case Pintrest = "kPintrest"
    case Telegram = "kTelegram"
    case Tumblr = "kTumblr"
}

func openWebUrl(_ viewController: UIViewController, url: URL) {
    let safariVC = SFSafariViewController(url: url)
    viewController.present(safariVC, animated: true, completion: nil)
}

func openSocialApp(_ viewController: UIViewController, type: SOCIAL_LOGIN_ENUM) {
    var appUrl: URL?
    var webUrl: URL?
    switch type {
    case SOCIAL_LOGIN_ENUM.Facebook:
        appUrl = URLs.FACEBOOK_APPURL
        webUrl = URLs.FACEBOOK_WEBURL
        break
    case SOCIAL_LOGIN_ENUM.Twitter:
        appUrl = URLs.TWITTER_APPURL
        webUrl = URLs.TWITTER_WEBURL
        break
    case SOCIAL_LOGIN_ENUM.Instagram:
        appUrl = URLs.INSTAGRAM_APPURL
        webUrl = URLs.INSTAGRAM_WEBURL
        break
    case SOCIAL_LOGIN_ENUM.Telegram:
        appUrl = URLs.TELEGRAM_APPURL
        webUrl = URLs.TELEGRAM_WEBURL
        break
    default:
        break
    }
    
    let application = UIApplication.shared
    if let url = appUrl, application.canOpenURL(url) {
        application.open(url)
    } else if let url = webUrl {
        let safariVC = SFSafariViewController(url: url)
        viewController.present(safariVC, animated: true, completion: nil)
    }
}
