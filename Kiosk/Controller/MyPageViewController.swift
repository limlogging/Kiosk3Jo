//
//  MyPageViewController.swift
//  Kiosk
//
//  Created by imhs on 4/4/24.
//

import UIKit
import MobileCoreServices

class MyPageViewController: UIViewController {
    var topView: UIView = {
        let view = UIView()
        //view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var topLogo: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "apple.logo"))
        imageView.tintColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var topSearch: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        imageView.tintColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var profileView: UIView = {
        let view = UIView()
        view.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemPink
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var profileImageChangeButton: UIButton = {
        let button = UIButton()
        button.setTitle("사진변경", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        button.addTarget(self, action: #selector(changeImage(_:)), for: .touchUpInside)
        return button
    }()
    
    let imagePicker: UIImagePickerController! = UIImagePickerController()
    var captureImage: UIImage!
    var videoURL: URL!
    var flagImageSave = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        profileUI()
    }
    
    @objc func changeImage(_ sender: UIButton) {
        if (UIImagePickerController.isSourceTypeAvailable(.photoLibrary)) {
            flagImageSave = false
            
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.mediaTypes = ["public.image"]
            imagePicker.allowsEditing = true
            
            present(imagePicker, animated: true, completion: nil)
        }
        else {
            myAlert("사진 앨범에 접근 할 수 없음", message: "애플리케이션이 사진 앨범에 접근할 수 없습니다. ")
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func myAlert(_ title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    func profileUI() {
        view.addSubview(topView)
        view.addSubview(topLogo)
        view.addSubview(topSearch)
//        view.addSubview(profileView)
//        view.addSubview(profileImageView)
//        view.addSubview(profileImageChangeButton)
        
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            topView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.05),
            
            topLogo.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            topLogo.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: view.bounds.width * 0.1),
            
            topSearch.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            topSearch.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: view.bounds.width * 0.7)
            
//            profileView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
//            profileView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
//            profileView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
//            profileView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2),
//            
//            profileImageView.topAnchor.constraint(equalTo: profileView.topAnchor, constant: 10 ),
//            profileImageView.leadingAnchor.constraint(equalTo: profileView.leadingAnchor, constant: 10),
//            //profileImageView.bottomAnchor.constraint(equalTo: profileView.bottomAnchor, constant: -10),
//            //profileImageView.bottomAnchor.constraint(equalTo: profileImageChangeButton.topAnchor, constant: -10),
//            profileImageView.widthAnchor.constraint(equalTo: profileView.widthAnchor, multiplier: 0.4),
//            
//            profileImageChangeButton.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 5),
//            profileImageChangeButton.leadingAnchor.constraint(equalTo: profileView.leadingAnchor, constant: 10),
//            profileImageChangeButton.bottomAnchor.constraint(equalTo: profileView.bottomAnchor, constant: -10),
//            profileImageChangeButton.heightAnchor.constraint(equalToConstant: 20),
//            profileImageChangeButton.widthAnchor.constraint(equalTo: profileImageView.widthAnchor)
        ])
    }
}

extension MyPageViewController: UINavigationControllerDelegate {
    
}
extension MyPageViewController: UIImagePickerControllerDelegate {
    // MARK: - 사진 선택
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let mediaType = info[UIImagePickerController.InfoKey.mediaType] as! NSString

        if mediaType.isEqual(to: "public.image" as String) {
            captureImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage

            if flagImageSave {
                UIImageWriteToSavedPhotosAlbum(captureImage, self, nil, nil)
            }

            profileImageView.image = captureImage
        }
        else if mediaType.isEqual(to: "public.movie" as String) {
            if flagImageSave {
                videoURL = (info[UIImagePickerController.InfoKey.mediaURL] as! URL)

                UISaveVideoAtPathToSavedPhotosAlbum(videoURL.relativePath, self, nil, nil)
            }
        }

        self.dismiss(animated: true, completion: nil)
    }
}
