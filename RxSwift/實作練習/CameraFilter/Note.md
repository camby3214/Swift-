## Rx使用部分筆記

---

### 觀察在 `PhotosCollectionViewController` 選取的照片，並顯示在 `viewController` 中

- 在 `PhotosCollectionViewController` 宣告一個 `PublishSubject`（`selectedPhotoSubject`）以及宣告`selectedPhoto`用來回傳` selectedPhotoSubject`的觀察結果。

  ```swift
  private let selectedPhotoSubject = PublishSubject<UIImage>()
      
      var selectedPhoto: Observable<UIImage>{
          return selectedPhotoSubject.asObservable()
      }
  ```

  

- 在 `PhotosCollectionViewController` 點擊照片時，將照片回傳給觀察者。

  ```swift
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
          //省略...
              if !isDegradedImage {
                  if let image = image {
                      self?.selectedPhotoSubject.onNext(image)
                      self?.dismiss(animated: true, completion: nil)
                  }
              }
          }
      }
  ```

  

- 在`ViewController`跳轉頁面時訂閱`selectedPhoto`即可

```swift
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navC = segue.destination as? UINavigationController,
              let photosCVC = navC.viewControllers.first as? PhotosCollectionViewController
        else{
            fatalError("Segue destination is not found")
        }
        photosCVC.selectedPhoto.subscribe(onNext: { [weak self] photo in
            
            self?.updateUI(with: photo)
        }).disposed(by: disposeBag)
        
    }
```

### 將在 `FilterService` 套用濾鏡完畢的照片顯示在 `viewController` 中

- 建立一個`Observable`並將`applyFilter`（私有方法）處理完的照片發出給訂閱者。

  ```swift
  func applyFilter(to inputImage: UIImage) -> Observable<UIImage> {
          return Observable<UIImage>.create { observer in
              
              self.applyFilter(to: inputImage){ filteredImage in
                  observer.onNext(filteredImage)
              }
              return Disposables.create()
          }
      }
  ```

  

- 在`ViewController`訂閱即可

  ```swift
  FilterService().applyFilter(to: sourceImage)
              .subscribe(onNext:{ filterImage in
                  DispatchQueue.main.async {
                      self.phtoImageView.image = filterImage
                  }
              }).disposed(by: disposeBag)
  ```

  