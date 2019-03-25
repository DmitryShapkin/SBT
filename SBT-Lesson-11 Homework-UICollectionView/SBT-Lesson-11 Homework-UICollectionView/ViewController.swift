//
//  ViewController.swift
//  SBT-Lesson-11 Homework-UICollectionView
//
//  Created by Dmitry Shapkin on 25/03/2019.
//  Copyright © 2019 Dmitry Shapkin. All rights reserved.
//


import UIKit


class ViewController: UIViewController
{
    fileprivate lazy var collectionView: UICollectionView = {
        
        let collectionViewLayout = AnimalCollectionViewLayout()
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: collectionViewLayout)
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.contentInset = UIEdgeInsets(top: 23, left: 16, bottom: 10, right: 16)
        collectionView.register(AnimalCollectionViewCell.self, forCellWithReuseIdentifier: "AnimalCollectionViewCell")
        
        return collectionView
    }()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if let layout = collectionView.collectionViewLayout as? AnimalCollectionViewLayout
        {
            layout.delegate = self
        }
        
        if let patternImage = UIImage(named: "mybackground.png")
        {
            view.backgroundColor = UIColor(patternImage: patternImage)
        }
        
        self.view.addSubview(collectionView)
    }
    
    open override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.frame
    }
}

extension ViewController: UICollectionViewDataSource
{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return animalsData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnimalCollectionViewCell", for: indexPath) as? AnimalCollectionViewCell
        {
            cell.animalNameLabel.text = animalsData[indexPath.item].name
            cell.someFactLabel.text = animalsData[indexPath.item].someFact
            cell.coverImageView.image = animalsData[indexPath.item].image
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 10)) / 2
        return CGSize(width: itemSize, height: itemSize)
    }
}

extension ViewController: AnimalLayoutDelegate
{
    func collectionView(_ collectionView: UICollectionView,
                        heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat
    {
        if let animalImage = animalsData[indexPath.item].image {
            return animalImage.size.height / 2
        }
        return 200.0
    }
}

/**
 Не знаю правильно ли я сделал, что создал такой массив тюплов.
 Буду очень рад обратной связи.
 */

fileprivate let animalsData: [(name: String, someFact: String, image: UIImage?)] = [
    ("Пёс", "Собаки понимают до 250 слов и жестов", UIImage(named: "dog.jpg")),
    ("Конь", "Лошади видят мир цветным, кроме красного и синего цвета", UIImage(named: "horse.jpg")),
    ("Пума?", "Пума способна развивать скорость до 65 км/ч", UIImage(named: "cougar.jpg")),
    ("Верблюд", "Произошел от арабского слова \"красота\"", UIImage(named: "camel.jpg")),
    ("Кенгуру", "Удар кенгуру является настолько мощным, что может убить взрослого человека", UIImage(named: "kangaroo.jpg")),
    ("Енот", "Свое потомство самка енота кормит 24 раза в день", UIImage(named: "raccoon.jpg")),
    ("Волк", "Волки способны различать больше, чем 200 млн запахов", UIImage(named: "wolf.jpg")),
    ("Хомяк", "Хомяк может за ночь преодолеть до 10 километров в своем колесе", UIImage(named: "hamster.jpg")),
    ("Ленивец", "Ленивцы спускаются с деревьев только затем, чтобы справить нужду", UIImage(named: "sloth.jpg")),
    ("Кот", "В среднем кошки тратят 2/3 суток на сон", UIImage(named: "cat.jpg")),
    ("Ящерица", "Некоторые ящерицы могут выстрелить в противника собственной кровью", UIImage(named: "lizard.jpg")),
    ("Голубь", "Голуби могут пролететь до 900 км в сутки, развивая скорость до 70 км/ч", UIImage(named: "pigeon.jpg")),
    ("Лиса", "Глубина лисьей норы достигает трех метров", UIImage(named: "fox.jpg")),
    ("Альпака", "Альпаки не имеют передних зубов на верхней челюсти", UIImage(named: "alpaca.jpg")),
    ("Лама", "Ламы плюются, если их разозлить", UIImage(named: "llama.jpg"))
]
