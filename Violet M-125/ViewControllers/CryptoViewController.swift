//
//  CryptoViewController.swift
//  Violet M-125
//
//  Created by Иван Дрожжин on 12.08.2022.
//

import UIKit

class CryptoViewController: UIViewController {

    let workingMode = WorkingMode.encryption
    
    @IBOutlet weak var manipulationTextField: UITextField!
    @IBOutlet weak var keyTextField: UITextField!
    @IBOutlet weak var descriptionLabel: UILabel!
    //Лишние аутлеты будут реализованы в логике позже, в зависимости от нажатой кнопки будут открываться экраны с данными для шифровки или дешифровки
    
    @IBAction func cryptoButtonPressed() {
        var cryptoKey = Pressmark(key: "")
        var cryptoMessage = CryptoMessage(data: "", key: "")
        
        if manipulationTextField.text != "" {
            cryptoMessage.data = manipulationTextField.text ?? ""
            
            if keyTextField.text == "" || keyTextField.text == nil {
                NetworkManager.shared.fetchGeneratedKey { [weak self] result in
                    switch result {
                    case .success(let key):
                        cryptoKey = key
                        DispatchQueue.main.async { [weak self] in
                            self?.keyTextField.text = cryptoKey.key
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                        DispatchQueue.main.async { [weak self] in
                            self?.showAlert(with: "Введите ключ для шифровки вашего сообщения")
                        }
                    }
                }
            } else {
                cryptoMessage.key = keyTextField.text ?? ""
            }
        }
        
        switch workingMode {
        case .encryption:
            NetworkManager.shared.postMessage(
                with: cryptoMessage,
                to: Link.postEncrypt.rawValue
            ) { [weak self] cryptoData in
                
                switch cryptoData {
                case .success(let cryptoMessage):
                    DispatchQueue.main.async { [weak self] in
                        self?.manipulationTextField.text = (cryptoMessage as? CryptoMessage)?.data
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    DispatchQueue.main.async { [weak self] in
                        self?.showAlert(with: "Произошла ошибка при попытке зашифровать сообщение, повторите попытку позже")
                    }
                }
            }
        case .decryption:
            NetworkManager.shared.postMessage(with: cryptoMessage, to: Link.postDecrypt.rawValue) { [weak self] cryptoData in
                switch cryptoData {
                case .success(let cryptoMessage):
                    DispatchQueue.main.async { [weak self] in
                        self?.manipulationTextField.text = (cryptoMessage as? CryptoMessage)?.data
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    DispatchQueue.main.async { [weak self] in
                        self?.showAlert(with: "Произошла ошибка при попытке зашифровать сообщение, повторите попытку позже")
                    }
                }
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
//MARK: Private methods
extension CryptoViewController {
    private func showAlert(with message: String) {
        let alert = UIAlertController(
            title: "Ошибка ввода",
            message: message,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
