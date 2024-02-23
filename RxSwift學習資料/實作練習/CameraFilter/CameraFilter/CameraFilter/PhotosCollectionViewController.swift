//
//  PhotosCollectionViewController.swift
//  CameraFilter
//
//  Created by 李韋辰 on 2022/3/11.
//


import UIKit
import Photos
import RxSwift



class PhotosCollectionViewController: UICollectionViewController {
    
    private let selectedPhotoSubject = PublishSubject<UIImage>()
    
    var selectedPhoto: Observable<UIImage>{
        return selectedPhotoSubject.asObservable()
    }
    
    private var images = [PHAsset]()

    override func viewDidLoad() {
        super.viewDidLoad()
        populatePhotos()

    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedAsset = self.images[indexPath.row]
        PHImageManager.default().requestImage(for: selectedAsset, targetSize: CGSize(width: 300, height: 300), contentMode: .aspectFit, options: nil) { [weak self] image, info in
            guard let info = info else {return}
            let isDegradedImage = info["PHImageResultIsDegradedKey"] as! Bool
            
            if !isDegradedImage {
                if let image = image {
                    self?.selectedPhotoSubject.onNext(image)
                    self?.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as? PhotoCollectionViewCell else {
            fatalError("is not found")
        }
        let asset = self.images[indexPath.item]
        let manager = PHImageManager.default()
        
        manager.requestImage(for: asset, targetSize: CGSize(width: 100, height: 100), contentMode: .aspectFit, options: nil) { image, _ in
            DispatchQueue.main.async {
                cell.photoImageView.image = image
            }
        }
        
        return cell
    }
    
    
    private func populatePhotos(){
        //請求授權使用照片
        PHPhotoLibrary.requestAuthorization { [weak self] status in
            if status == .authorized {
                let assets = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: nil)
                //枚舉所有照片
                assets.enumerateObjects{(object, count, stop) in
                    self?.images.append(object)
                }
                //照片從最新開始排列
                self?.images.reversed()
                //畫面重整（只能在主執行序執行）
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
                
            }
        }
    }

    
}
