//
//  LoginWKWebViewController.swift
//  VK_Client | Zhmaeva_Ekaterina
//
//  Created by Catherine on 10.08.2021.
//

import UIKit
import WebKit


class LoginWKWebViewController: UIViewController {

    @IBOutlet weak var loginWebView: WKWebView! {
        didSet {
            loginWebView.navigationDelegate = self
        }
    }

    private let network = NetworkLayer()

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let url = network.getAuthUrl() else { return }

        loginWebView.load(URLRequest(url: url))
    }
}

extension LoginWKWebViewController: WKNavigationDelegate {

    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {

        guard let url = navigationResponse.response.url,
              url.path == "/blank.html",
              let fragment = url.fragment else { decisionHandler(.allow)
            return
        }
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }
        let token = params["access_token"]
        print(token)
        decisionHandler(.cancel)
    }
}

