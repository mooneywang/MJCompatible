//
//  MJWebViewController.swift
//  MJCompatible
//
//  Created by Panda on 2017/10/20.
//  Copyright © 2017年 MooneyWang. All rights reserved.
//

import UIKit
import WebKit

class MJWebViewController: UIViewController {

    fileprivate let webView: WKWebView = WKWebView(frame: CGRect(x: 0, y: 64, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 64))
    fileprivate let progressView = UIProgressView(frame: CGRect(x: 0, y: 64, width: UIScreen.main.bounds.width, height: 0))

    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false

        // 添加web view
        webView.navigationDelegate = self
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: NSKeyValueObservingOptions.new, context: nil)
        view.addSubview(webView)

        // 添加进度条
        progressView.transform = CGAffineTransform(scaleX: 1.0, y: 1.5)
        progressView.progressViewStyle = UIProgressViewStyle.default
        progressView.tintColor = .green
        progressView.trackTintColor = .white
        progressView.isHidden = true
        view.addSubview(progressView)

        // 发送请求
        loadData("https://www.baidu.com")
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let object = object as? WKWebView {
            if object === webView {
                if keyPath == "estimatedProgress" {
                    progressView.setProgress(Float(webView.estimatedProgress), animated: true)
                }
            }
        } else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }

    private func loadData(_ urlString: String) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }

    deinit {
        webView.removeObserver(self, forKeyPath: "estimatedProgress", context: nil)
    }
}

extension MJWebViewController: WKNavigationDelegate {

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        progressView.isHidden = false
        view.bringSubview(toFront: progressView)
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
            self.progressView.isHidden = true
            self.progressView.setProgress(0.0, animated: false)
        }
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
            self.progressView.isHidden = true
            self.progressView.setProgress(0.0, animated: false)
        }
    }

    func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        print("webViewWebContentProcessDidTerminate")
    }
}
