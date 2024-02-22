//
//  ViewController.swift
//  WKWebView_Practice
//
//  Created by 李韋辰 on 2023/3/21.
//

import UIKit
import WebKit
import SnapKit

class ViewController: UIViewController {

    @IBOutlet weak var toolView: UIView!
    
    @IBOutlet weak var forwardBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    
    @IBOutlet weak var sendMsgToJsBtn: UIButton!
    
    var webView = WKWebView()
    var postUrl = String()
    var HTML = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setWebView()
        setUrl()
    }
    
    private func setWebView() {
        let configuration = WKWebViewConfiguration()
        configuration.userContentController = WKUserContentController()
        configuration.userContentController.add(self, name: "ToApp")
        
        webView = WKWebView(frame: self.view.frame, configuration: configuration)
        webView.navigationDelegate = self
        self.view.addSubview(webView)
        webView.snp.makeConstraints { make in
            make.top.left.right.equalTo(self.view)
            make.bottom.equalTo(toolView.snp_topMargin)
        }
    }
    
    
    
    private func setUrl() {
        HTML = try! String(contentsOfFile: Bundle.main.path(forResource: "demo", ofType: "html")!, encoding: String.Encoding.utf8)
        loadURL(urlString: HTML)
    }
    
    
    private func loadURL(urlString: String) {
        webView.loadHTMLString(HTML, baseURL: nil)

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
    @IBAction func sendMsgToJS(_ sender: Any) {
        webView.evaluateJavaScript("sendMessage('swift message')") { (result, err) in
            print(result ?? "", err ?? "")
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
    }
    // 網頁載入完成
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("finish to load")
        forwardBtn.isEnabled = webView.canGoForward
        backBtn.isEnabled = webView.canGoBack
    }
    
    
}

extension ViewController: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print(message.body)
    }
}
