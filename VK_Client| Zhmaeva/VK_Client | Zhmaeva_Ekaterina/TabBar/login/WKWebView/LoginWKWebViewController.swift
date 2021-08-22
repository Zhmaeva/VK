//
//  LoginWKWebViewController.swift
//  VK_Client | Zhmaeva_Ekaterina
//
//  Created by Catherine on 10.08.2021.
//

import UIKit
import WebKit

// MARK: - LoginWKWebViewController

final class LoginWKWebViewController: UIViewController {

    @IBOutlet weak var loginWebView: WKWebView! {
        didSet {
            loginWebView.navigationDelegate = self  // отслеживаем переходы между страницами
        }
    }

    let segueToTabBar = "fromLoginWebViewToTabBarController"

    private let apiClient = VkClient()
    private let network = NetworkLayer()

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let url = apiClient.getAuthUrl() else { return }

        loginWebView.load(URLRequest(url: url))
        
    }
}

extension LoginWKWebViewController: WKNavigationDelegate {

    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {  // перехват ответов сервера при переходе

        guard let url = navigationResponse.response.url,    // проверяем url
              url.path == "/blank.html",     // если url содержит /blank.html приступим к обработке
              let fragment = url.fragment else { decisionHandler(.allow)  // разрешаем перейти на другую страницу
            return
        }

        let params = fragment  // всё что после # это фрагмент
            .components(separatedBy: "&") // делим url на части по знаку &
            .map { $0.components(separatedBy: "=") } //делим url на части по знаку =
            .reduce([String: String]()) { result, param in  // сохраняем результат в словарь с параметрами
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict // возвращаем полученный словарь
            }

        Session.shared.token = params["access_token"] ?? ""  // записываем полученные параметры в наш синглтон
        Session.shared.userId = params["user_id"] ?? ""

        performSegue(withIdentifier: self.segueToTabBar, sender: nil)

        decisionHandler(.cancel)
    }
}

