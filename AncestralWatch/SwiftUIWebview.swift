//
//  SwiftUIWebview.swift
//  AncestralWatch
//
//  Created by Jakob Hartman on 12/20/22.
//

import Foundation
import SwiftUI
import WebKit

struct SwiftUIWebView: UIViewRepresentable {
    typealias UIViewType = WKWebView
    
    let webView: WKWebView
    
    init(url: String, callback: @escaping () -> Void) {
        webView = WKWebView(frame: .zero)
        webView.isLoaded = callback
        webView.navigationDelegate = self.webView
        webView.load(URLRequest(url: URL(string: url)!))
    }
    
    func getUrl() -> String {
       return webView.getUrl()
    }
    
    func makeUIView(context: Context) -> WKWebView {
        webView
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {
    }

}

extension WKWebView: WKNavigationDelegate {
    
    struct Holder {
        static var callback: () -> Void = {}
    }
    
    var isLoaded: () -> Void {
        set(callback){
            Holder.callback = callback
        }
        
        get{
            return Holder.callback
        }
    }
    
    private var httpCookieStore: WKHTTPCookieStore  { return WKWebsiteDataStore.default().httpCookieStore}
    
    func getCookies(for domain: String? = nil, completion: @escaping ([String : Any])->())  {
        var cookieDict = [String : AnyObject]()
        httpCookieStore.getAllCookies { cookies in
            for cookie in cookies {
                if let domain = domain {
                    if cookie.domain.contains(domain) {
                        cookieDict[cookie.name] = cookie.properties as AnyObject?
                    }
                } else {
                    cookieDict[cookie.name] = cookie.properties as AnyObject?
                }
            }
            completion(cookieDict)
        }
    }
    
    func getUrl() -> String {
        if let url = self.url?.absoluteString {
            return url
        }
        return ""
    }
    
    public func webView(_ webView: WKWebView,  didFinish: WKNavigation){
        let ts = Date().timeIntervalSince1970
        if(getUrl().contains("familysearch.org")){
            webView.configuration.websiteDataStore.httpCookieStore.getAllCookies { cookies in
                let defaults = UserDefaults.standard
                for cookie in cookies {
                    switch(cookie.name){
                        case "fssessionid":
                            defaults.set(cookie.value, forKey: "AccessToken")
                            //ten mins from now although realistally its about 15mins according to my sources
                            defaults.set(ts + (1000 * 10 * 60 * 10), forKey: "Expiration")
                            Holder.callback()
                            break;
                        default:
                            continue;
                    }
                }
            }
        }
    }
    
    public func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        decisionHandler(.allow)
    }
}



