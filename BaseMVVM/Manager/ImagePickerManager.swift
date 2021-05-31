//
//  CameraManager.swift
//  BaseMVVM
//
//  Created by Lê Thọ Sơn on 4/24/20.
//  Copyright © 2020 thoson.it. All rights reserved.
//

import RxSwift
import RxCocoa
import MobileCoreServices
import Photos

enum ImagePickerManagerError: Error {
    case accessDenied
    case accessRestricted
}

/*
 HOW TO USE:
 
 var imagePickerManager: ImagePickerManager?
 
 imagePickerManager = ImagePickerManager(from: ViewController)
 
 imagePickerManager.pickPhoto(from: sourceType).subscribe(onNext: { (image) in
 print("\(image)")
 }, onError: { error in
 print("error")
 }).disposed(by: self.disposeBag)
 
 */

class ImagePickerManager: NSObject {
    private var singelObserver: ((SingleEvent<UIImage?>) -> Void)?
    
    private weak var viewController: UIViewController?
    
    private let disposeBag = DisposeBag()
    
    init(from viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func pickPhoto(from sourceType: UIImagePickerController.SourceType) -> Observable<UIImage?> {
        return Single.create { single in
            switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .authorized: // The user has previously granted access to the camera.
                //                        self.setupCaptureSession()
                if UIImagePickerController.isSourceTypeAvailable(sourceType) {
                    DispatchQueue.main.async {
                        let picker = UIImagePickerController()
                        picker.sourceType = sourceType
                        picker.delegate = self
                        picker.allowsEditing = true
                        self.singelObserver = single
                        picker.mediaTypes = [kUTTypeImage as String]
                        picker.modalPresentationStyle = .fullScreen
                        self.viewController?.present(picker, animated: true, completion: nil)
                    }
                }
                break
            case .notDetermined:
                // The user has not yet been asked for camera access.
                AVCaptureDevice.requestAccess(for: .video) { granted in
                    // At this point an alert is provided to the user to provide access to camera. This will get invoked if a user responds to the alert
                    if granted {
                        self.pickPhoto(from: sourceType).subscribe(onNext: {(images) in
                            single(.success(images))
                        }, onError: { (error) in
                            single(.error(error))
                        }).disposed(by: self.disposeBag)
                    } else {
                        single(.error(ImagePickerManagerError.accessDenied))
                    }
                }
            case .denied:
                // The user has previously denied access.
                single(.error(ImagePickerManagerError.accessDenied))
            case .restricted:
                // The user can't grant access due to restrictions.
                single(.error(ImagePickerManagerError.accessRestricted))
            @unknown default:
                break
            }
            return Disposables.create { }
        }.asObservable()
    }
}

extension ImagePickerManager: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[.editedImage] as? UIImage else {
            return
        }
        singelObserver?(.success(image))
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        singelObserver?(.success(nil))
    }
}
