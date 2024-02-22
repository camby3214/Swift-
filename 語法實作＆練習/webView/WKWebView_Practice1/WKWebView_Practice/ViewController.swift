//
//  ViewController.swift
//  WKWebView_Practice
//
//  Created by 李韋辰 on 2023/3/21.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var toolView: UIView!
    
    @IBOutlet weak var forwardBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    var postUrl = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        setUrl()
    }
    
    private func setUrl() {
        postUrl = "http://10.1.23.32/pgcompetition/votepage?movieId=277"
        loadURL(urlString: postUrl)
    }
    
    private func loadURL(urlString: String) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
        
        
    }
    
    @IBAction func forwardAction(_ sender: Any) {
        if webView.goForward() == nil {
            print("No more page to forward")
        }
    }
    @IBAction func backAction(_ sender: Any) {
        if webView.goBack() == nil {
            print("No more page to back")
        }
    }
    
}

extension ViewController: WKNavigationDelegate {
    // 載入網頁失敗
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print(error.localizedDescription)
    }
    // 載入網頁成功,網頁會慢慢顯示出來
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("Strat to load")
        print(webView.url?.absoluteString)
    }
    // 網頁載入完成
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("finish to load")
        forwardBtn.isEnabled = webView.canGoForward
        backBtn.isEnabled = webView.canGoBack
    }
    
    
    
    
    // The certificate for this server is invalid. You might be connecting to a server that is pretending to be “10.1.23.40” which could put your confidential information at risk. 證書無效的網站開啟方式
//    func webView(_ webView: WKWebView,
//        didReceive challenge: URLAuthenticationChallenge,
//        completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void)
//    {
//        if(challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust)
//        {
//            let cred = URLCredential(trust: challenge.protectionSpace.serverTrust!)
//            completionHandler(.useCredential, cred)
//        }
//        else
//        {
//            completionHandler(.performDefaultHandling, nil)
//        }
//    }
    
}
