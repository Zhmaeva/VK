//
//  LoginWKWebViewController.swift
//  VK_Client | Zhmaeva_Ekaterina
//
//  Created by Catherine on 10.08.2021.
//

import UIKit
import WebKit
import RealmSwift

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

        let size1 = PhotoSizesRealm(height: 200, width: 200, url: "size1200/200")
        let size2 = PhotoSizesRealm(height: 300, width: 300, url: "size2300/300")
        let size3 = PhotoSizesRealm(height: 400, width: 200, url: "size3400/200")

        let photo1 = PhotoRealm(id: 7878, sizes: [size1])
        let photo2 = PhotoRealm(id: 9494, sizes: [size2, size3])

        let test = UserRealm(id: 3, firstName: "first", lastName: "last", photo: "photo", photos: [photo1, photo2])
        let test2 = UserRealm(id: 23, firstName: "first2", lastName: "last2", photo: "photo2", photos: [])
        let group1 = GroupRealm(id: 46, name: "group1", photo: "gr1")
        let group2 = GroupRealm(id: 5, name: "group2", photo: "gr2")


        guard let realm = try? Realm() else { return }
        print(realm.configuration.fileURL)

        try? realm.write {
            realm.add([test, test2], update: .modified)
            realm.add([group1,group2], update: .modified)
        }

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

