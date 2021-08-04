//
//  ViewController.swift
//  VK_Client | Zhmaeva_Ekaterina
//
//  Created by Catherine on 18.06.2021.
//
import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var titleImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var circleOne: UIImageView!
    @IBOutlet weak var circleTwo: UIImageView!
    @IBOutlet weak var circleThree: UIImageView!
    @IBOutlet weak var backViewCircle: UIView!
    
    
    let toTabBarSegueIdentifier = "fromLoginToTabBarController"
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        animateTitleLabel()
        animateLoginPasswordTextField()
        animateIcon()
        animateButton()
        
        backViewCircle.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        gradientView()
        super.viewWillAppear(animated)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: - Появление/скрытие клавиатуры
        
        // Подписываемся на уведомления о появлении/скрытии клавиатуры
        
        NotificationCenter.default.addObserver(self, selector: #selector(kbWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(kbWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        // Распознаем нажатие на экран
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(kbRemove))
        backView.addGestureRecognizer(gestureRecognizer)
    }
    
    // Метод при появлении клавиатуры
    
    @objc func kbWillShow(_ notification: Notification) {
        let userInfo = notification.userInfo
        let kbFrameSize = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        scrollView.contentOffset = CGPoint(x: 0, y: kbFrameSize.height)
    }
    
    // Метод при скрытии клавиатуры
    
    @objc func kbWillHide() {
        scrollView.contentOffset = CGPoint.zero
    }
    
    // Метод скрытия клавиатуры
    
    @objc func kbRemove() {
        self.scrollView.endEditing(true)
    }
    
    // Отписываемся от уведомлений о появлении/скрытии клавиатуры
    func removeKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    
    deinit {
        removeKeyboardNotifications()
    }
    
    //MARK: - Проверяем логин и пароль на правильность ввода.
    
    func showAlert(notice: String, completion: @escaping (UIAlertAction) -> Void) {
        let alertController = UIAlertController(title: "Alert", message: notice, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: completion)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func pressLoginButton(_ sender: Any) {
        if let login = loginTextField.text,
           let password = passwordTextField.text,
           !login.isEmpty,
           !password.isEmpty,
           login == "a",
           password == "1" {
          
            startFakeNetworkCall()
            
        } else {
            showAlert(notice: "Error login or password") {
                _ in return
            }
        }
    }
}

