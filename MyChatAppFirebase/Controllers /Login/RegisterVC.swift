//
//  RegisterVC.swift
//  MyChatAppFirebase
//
//  Created by Ion Socol on 5/30/25.
//

import UIKit

class RegisterVC: UIViewController {

    private lazy var nameTextField: UITextField = {
        let v = Helpers.shared.getTextField(withPlaceHolder: "Name...")
        v.delegate = self
        v.translatesAutoresizingMaskIntoConstraints = false
        v.keyboardType = .emailAddress
        v.autocapitalizationType = .none
        return v
    }()

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

    private lazy var registerContainerView: UIView = {
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
        let sv = UIStackView(arrangedSubviews: [nameTextField, emailTextField, passwordTextField])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.spacing = 32
        sv.alignment = .fill
        sv.distribution = .fillEqually
        return sv
    }()



    private lazy var registerButton: UIButton = {
        let v = UIButton(type: .system)
        v.translatesAutoresizingMaskIntoConstraints = false
        v.setTitle("Create", for: .normal)
        v.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        v.setTitleColor(.white, for: .normal)
        v.backgroundColor = .systemBlue
        v.layer.cornerRadius = 12
        v.clipsToBounds = true
        v.addTarget(self, action: #selector(didTapRegisterButton), for: .touchUpInside)
        return v
    }()





    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Create Account"
        setupViews()
    }


    private func setupViews() {
        view.addSubview(registerContainerView)
        view.addSubview(logoImageView)
        registerContainerView.addSubview(textFieldStackView)
        registerContainerView.addSubview(registerButton)
        setupConsraints()
    }


    private func setupConsraints() {
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            logoImageView.heightAnchor.constraint(equalToConstant: 80),
            logoImageView.widthAnchor.constraint(equalToConstant: 80),

            registerContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            registerContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            registerContainerView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 40),



            nameTextField.leadingAnchor.constraint(equalTo: registerContainerView.leadingAnchor, constant: 10),
            nameTextField.trailingAnchor.constraint(equalTo: registerContainerView.trailingAnchor, constant: -10),
            nameTextField.topAnchor.constraint(equalTo: registerContainerView.topAnchor, constant: 40),
            nameTextField.heightAnchor.constraint(equalToConstant: 52),

            emailTextField.leadingAnchor.constraint(equalTo: registerContainerView.leadingAnchor, constant: 10),
            emailTextField.trailingAnchor.constraint(equalTo: registerContainerView.trailingAnchor, constant: -10),
            emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 40),
            emailTextField.heightAnchor.constraint(equalToConstant: 52),



            passwordTextField.leadingAnchor.constraint(equalTo: registerContainerView.leadingAnchor, constant: 10),
            passwordTextField.trailingAnchor.constraint(equalTo: registerContainerView.trailingAnchor, constant: -10),
            passwordTextField.heightAnchor.constraint(equalToConstant: 52),

            registerButton.leadingAnchor.constraint(equalTo: registerContainerView.leadingAnchor, constant: 10),
            registerButton.trailingAnchor.constraint(equalTo: registerContainerView.trailingAnchor, constant: -10),
            registerButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 24),

            registerButton.bottomAnchor.constraint(equalTo: registerContainerView.bottomAnchor, constant: -40)
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

    @objc
    private func didTapRegisterButton() {
        guard let name = nameTextField.text, let email = emailTextField.text, let password = passwordTextField.text,
            !name.isEmpty, !email.isEmpty, !password.isEmpty else {
            alertValidationError(title: "Woops", message: "Please enter all information to create an account!")
            return
        }
        print("Name: \(name)\nEmail: \(email)\nPassword: \(password)")
    }
}

extension RegisterVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameTextField {
            emailTextField.becomeFirstResponder()
        }
        else if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        }
        else if textField == passwordTextField {
            didTapRegisterButton()
        }
        return true
    }
}

