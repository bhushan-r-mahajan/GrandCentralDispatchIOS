//
//  ViewController.swift
//  GCD
//
//  Created by Gadgetzone on 08/08/21.
//

import UIKit

class ViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    //MARK: - Properties
    
    var images = [UIImage]()
    let textlabel = UILabel()
    let imageURL = "https://c4.wallpaperflare.com/wallpaper/245/816/876/one-piece-monkey-d-luffy-trafalgar-law-ussop-wallpaper-preview.jpg"
    
    //MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        loadImages()
    }

    //MARK: - Configuration Functions

    func loadImages() {
        for _ in 1...50 {
            downloadImages()
        }
    }
    
    private func downloadImages() {
        DispatchQueue.global(qos: .utility).async { [weak self] in
            URLSession.shared.dataTask(with: URL(string: self!.imageURL)!) { [weak self] data, response, error in
                guard let self = self, let data = data, let image = UIImage(data: data) else { return }
                self.images.append(image)
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }.resume()
        }
    }
    
    //MARK: - CollectionView Delegate and Datasource Functions
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        cell.layer.shouldRasterize = true
        cell.layer.rasterizationScale = UIScreen.main.scale
        cell.image = images[indexPath.row]
        cell.backgroundColor = .clear
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width / 2, height: collectionView.frame.size.height / 4)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
}



