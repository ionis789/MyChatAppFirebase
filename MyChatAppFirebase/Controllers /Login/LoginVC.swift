//
//  LoginVC.swift
//  MyChatAppFirebase
//
//  Created by Ion Socol on 5/30/25.
//

import UIKit

class LoginVC: UIViewController {


    private lazy var emailTextField: UITextField = {
        let v = Helpers.shared.getTextField(withPlaceHolder: "Email...")
        v.delegate = self
        v.translatesAutoresizingMaskIntoConstraints = false
        v.keyboardType = .emailAddress
        v.autocapitalizationType = .none
        return v
    }()

    private lazy var passwordTextField: UITextField = {
        let v = Helpers.shared.getTextField(withPlaceHolder: "Password...")
        v.delegate = self
        v.translatesAutoresizingMaskIntoConstraints = false
        v.autocapitalizationType = .none
        v.isSecureTextEntry = true
        return v
    }()

    private lazy var logoImageView: UIImageView = {
        let v = UIImageView(image: UIImage(named: "ChatLogo"))
        v.contentMode = .scaleAspectFit
        v.translatesAutoresizingMaskIntoConstraints = false
        v.layer.cornerRadius = v.bounds.width / 2
        return v
    }()

    private lazy var loginContainerView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        // Glass effect
        v.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        v.layer.cornerRadius = 24
        v.layer.borderWidth = 1
        v.layer.borderColor = UIColor.white.withAlphaComponent(0.2).cgColor
        // Blur effect
        let blurEffect = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = v.bounds
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurView.layer.cornerRadius = 24
        blurView.layer.masksToBounds = true
        v.addSubview(blurView)
        return v
    }()

    private lazy var textFieldStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [emailTextField, passwordTextField])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.spacing = 32
        sv.alignment = .fill
        sv.distribution = .fillEqually
        return sv
    }()



    private lazy var loginButton: UIButton = {
        let v = UIButton(type: .system)
        v.translatesAutoresizingMaskIntoConstraints = false
        v.setTitle("Log In", for: .normal)
        v.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        v.setTitleColor(.white, for: .normal)
        v.backgroundColor = .systemBlue
        v.layer.cornerRadius = 12
        v.clipsToBounds = true
        v.addTarget(self, action: #selector (didTapLoginButton), for: .touchUpInside)
        return v
    }()





    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Log In"
        setupViews()

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register", style: .done, target: self, action: #selector(didTapRegisterButton))
    }


    private func setupViews() {
        view.addSubview(loginContainerView)
        view.addSubview(logoImageView)
        loginContainerView.addSubview(textFieldStackView)
        loginContainerView.addSubview(loginButton)
        setupConsraints()
    }


    private func setupConsraints() {
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            logoImageView.heightAnchor.constraint(equalToConstant: 80),
            logoImageView.widthAnchor.constraint(equalToConstant: 80),

            loginContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            loginContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            loginContainerView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 40),



            emailTextField.leadingAnchor.constraint(equalTo: loginContainerView.leadingAnchor, constant: 10),
            emailTextField.trailingAnchor.constraint(equalTo: loginContainerView.trailingAnchor, constant: -10),
            emailTextField.topAnchor.constraint(equalTo: loginContainerView.topAnchor, constant: 40),
            emailTextField.heightAnchor.constraint(equalToConstant: 52),



            passwordTextField.leadingAnchor.constraint(equalTo: loginContainerView.leadingAnchor, constant: 10),
            passwordTextField.trailingAnchor.constraint(equalTo: loginContainerView.trailingAnchor, constant: -10),
            passwordTextField.heightAnchor.constraint(equalToConstant: 52),

            loginButton.leadingAnchor.constraint(equalTo: loginContainerView.leadingAnchor, constant: 10),
            loginButton.trailingAnchor.constraint(equalTo: loginContainerView.trailingAnchor, constant: -10),
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 24),

            loginButton.bottomAnchor.constraint(equalTo: loginContainerView.bottomAnchor, constant: -40)
        ])

    }

    private func alertValidationError(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let action = UIAlertAction(title: "Dismiss", style: .default) { _ in
            alert.dismiss(animated: true)
        }

        alert.addAction(action)
        present(alert, animated: true)
    }


    // When user tap Log In Button start login flow
    @objc
    private func didTapLoginButton() {

        guard let email = emailTextField.text, let password = passwordTextField.text,
            !email.isEmpty, !password.isEmpty else {
            self.alertValidationError(title: "Woops", message: "Please enter all information to login!")
            return }
        print("Email: \(email)\nPassword: \(password)")

    }

    // When user tap register button push RegisterVC on the screen
    @objc
    private func didTapRegisterButton() {
        let vc = RegisterVC()
        vc.title = "Create Account"
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension LoginVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        }
        else if textField == passwordTextField {
            didTapLoginButton()
        }
        return true
    }
}
