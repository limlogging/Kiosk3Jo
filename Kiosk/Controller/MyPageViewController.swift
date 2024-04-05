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
    
    var topBag: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "bag"))
        imageView.tintColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var topEqual: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "equal"))
        imageView.tintColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var accountView: UIView = {
        let view = UIView()
        //view.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        //view.layer.borderWidth = 1
        //view.layer.cornerRadius = 5
        //view.clipsToBounds = true
        view.backgroundColor = #colorLiteral(red: 0.960784018, green: 0.9607844949, blue: 0.9693934321, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var accountLabel: UILabel = {
        let label = UILabel()
        label.text = "계정"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var accountLoginStatusLabel: UILabel = {
        let label = UILabel()
        label.text = "로그아웃"
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .blue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var lineView: UIView = {
        let view = UIView()
        view.layer.borderColor = #colorLiteral(red: 0.8078431487, green: 0.8078433871, blue: 0.8121486306, alpha: 1)
        view.layer.borderWidth = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
        
    var nameView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.960784018, green: 0.9607844949, blue: 0.9693934321, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var myNameLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var view1: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.960784018, green: 0.9607844949, blue: 0.9693934321, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var view2: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.960784018, green: 0.9607844949, blue: 0.9693934321, alpha: 1)
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
        print(ListManager.shared.list)
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
        view.addSubview(topBag)
        view.addSubview(topEqual)
        view.addSubview(accountView)
        view.addSubview(accountLabel)
        view.addSubview(accountLoginStatusLabel)
        view.addSubview(lineView)
        view.addSubview(nameView)
        view.addSubview(myNameLabel)
        
        view.addSubview(view1)
        view.addSubview(view2)
//        view.addSubview(profileImageView)
//        view.addSubview(profileImageChangeButton)
        
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            topView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.075),
            
            topLogo.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            topLogo.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: view.bounds.width * 0.05),
            
            topSearch.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            topSearch.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: view.bounds.width * 0.6),
            
            topBag.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            topBag.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: view.bounds.width * 0.75),
            
            topEqual.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            topEqual.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: view.bounds.width * 0.9),
            
            accountView.topAnchor.constraint(equalTo: topView.bottomAnchor),
            accountView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            accountView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            accountView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.075),
            
            accountLabel.centerYAnchor.constraint(equalTo: accountView.centerYAnchor),
            accountLabel.leadingAnchor.constraint(equalTo: accountView.leadingAnchor, constant: view.bounds.width * 0.05),
            
            accountLoginStatusLabel.centerYAnchor.constraint(equalTo: accountView.centerYAnchor),
            accountLoginStatusLabel.trailingAnchor.constraint(equalTo: accountView.trailingAnchor, constant: view.bounds.width * (-0.05)),
            
            lineView.topAnchor.constraint(equalTo: accountView.bottomAnchor),
            lineView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 1),
            
            nameView.topAnchor.constraint(equalTo: lineView.bottomAnchor),
            nameView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            nameView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            nameView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.15),
            
            myNameLabel.topAnchor.constraint(equalTo: nameView.topAnchor, constant: nameView.bounds.height * 0.5),
            myNameLabel.leadingAnchor.constraint(equalTo: nameView.leadingAnchor, constant: nameView.bounds.width * 0.5),
            
            view1.topAnchor.constraint(equalTo: myNameLabel.bottomAnchor, constant: 10),
            view1.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            view1.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            view1.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.15),
            
            view2.topAnchor.constraint(equalTo: view1.bottomAnchor, constant: 10),
            view2.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            view2.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            view2.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.15)
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
