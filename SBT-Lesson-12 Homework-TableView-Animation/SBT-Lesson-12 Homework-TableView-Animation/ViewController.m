//
//  ViewController.m
//  SBT-Lesson-12 Homework-TableView-Animation
//
//  Created by Dmitry Shapkin on 26/03/2019.
//  Copyright © 2019 Dmitry Shapkin. All rights reserved.
//


#import "ViewController.h"
#import "AnimalTableViewCell.h"
#import <QuartzCore/QuartzCore.h>


@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<NSString *> *animalNames;
@property (nonatomic, strong) NSDictionary<NSString *, NSString *> *animalFacts;
@property (nonatomic, strong) NSDictionary<NSString *, UIImage *> *animalImages;
@property (nonatomic, strong) CAGradientLayer *gradientLayer;

@end


@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.view.contentMode = UIViewContentModeRedraw;
    //self.tableView.rowHeight = 120.f;
    
    [self.tableView registerClass:[AnimalTableViewCell class] forCellReuseIdentifier:NSStringFromClass([AnimalTableViewCell class])];
    [self.view addSubview:self.tableView];
    
    [self createAnimals];
    [self changeLayer];
    [self setupLayout];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.gradientLayer.frame = self.view.bounds;
}

- (void)setupLayout
{
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
          [self.tableView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
          [self.tableView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
          [self.tableView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
          [self.tableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor]
    ]];
}

- (void)changeLayer
{
    // Создадим цвета
    UIColor *topColor = [UIColor colorWithRed:230.0/255.0 green:240.0/255.0 blue:244.0/255.0 alpha:1.0];
    UIColor *bottomColor = [UIColor colorWithRed:136.0/255.0 green:172.0/255.0 blue:180.0/255.0 alpha:1.0];
    
    // Создадим градиент
    self.gradientLayer = [CAGradientLayer layer];
    self.gradientLayer.colors = [NSArray arrayWithObjects: (id)topColor.CGColor, (id)bottomColor.CGColor, nil];
    
    // Добавим градиент на вью
    [self.view.layer insertSublayer:self.gradientLayer atIndex:0];
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.animalNames.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    NSString *name = self.animalNames[indexPath.row];
    NSString *someFact = [self.animalFacts objectForKey:name];
    UIImage *image = [self.animalImages objectForKey:name];
    
    AnimalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AnimalTableViewCell class])];
   
    cell.titleLabel.text = name;
    cell.subtitileLabel.text = someFact;
    cell.coverImageView.image = image;
    
    return cell;
}


#pragma mark - UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

/**
 Анимация для ячеек.
    1. Ячейки "выпрыгивают" справа налево.
    2. Добавил вылет чуть сверху-справа.
    3. Добавил поворот.
 */

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIView *cellContentView  = [cell contentView];
    CGFloat rotationAngleDegrees = -30;
    CGFloat rotationAngleRadians = rotationAngleDegrees * (M_PI/180);
    CGPoint offsetPositioning = CGPointMake(500, -20.0);
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DRotate(transform, rotationAngleRadians, 0.0, 0.0, 1.0);
    transform = CATransform3DTranslate(transform, offsetPositioning.x, offsetPositioning.y, -50.0);
    cellContentView.layer.transform = transform;
    
    [UIView animateWithDuration:.65 delay:0.0 usingSpringWithDamping:0.85 initialSpringVelocity:.8 options:0 animations:^{
        cellContentView.layer.transform = CATransform3DIdentity;
    } completion: nil];
}


#pragma mark - Creation of animals

- (void)createAnimals
{
    self.animalNames = @[@"Пёс", @"Конь", @"Пума?", @"Верблюд", @"Кенгуру", @"Енот", @"Волк", @"Хомяк", @"Ленивец", @"Кот", @"Ящерица", @"Голубь", @"Лиса", @"Альпака", @"Лама"];
    
    self.animalFacts = @{
          @"Пёс": @"Собаки понимают до 250 слов и жестов. Собаки понимают до 250 слов и жестов. Собаки понимают до 250 слов и жестов. Собаки понимают до 250 слов и жестов. ",
          @"Конь": @"Лошади видят мир цветным, кроме красного и синего цвета. Лошади видят мир цветным, кроме красного и синего цвета. Лошади видят мир цветным, кроме красного и синего цвета. Лошади видят мир цветным, кроме красного и синего цвета.",
          @"Пума?": @"Пума способна развивать скорость до 65 км/ч. Пума способна развивать скорость до 65 км/ч. Пума способна развивать скорость до 65 км/ч. Пума способна развивать скорость до 65 км/ч.",
          @"Верблюд": @"Произошел от арабского слова \"красота\". Произошел от арабского слова \"красота\". Произошел от арабского слова \"красота\". Произошел от арабского слова \"красота\".",
          @"Кенгуру": @"Удар кенгуру является настолько мощным, что может убить взрослого человека. Удар кенгуру является настолько мощным, что может убить взрослого человека. Удар кенгуру является настолько мощным, что может убить взрослого человека. Удар кенгуру является настолько мощным, что может убить взрослого человека.",
          @"Енот": @"Свое потомство самка енота кормит 24 раза в день. Свое потомство самка енота кормит 24 раза в день. Свое потомство самка енота кормит 24 раза в день. Свое потомство самка енота кормит 24 раза в день.",
          @"Волк": @"Волки способны различать больше, чем 200 млн запахов. Волки способны различать больше, чем 200 млн запахов. Волки способны различать больше, чем 200 млн запахов. Волки способны различать больше, чем 200 млн запахов.",
          @"Хомяк": @"Хомяк может за ночь преодолеть до 10 километров в своем колесе. Хомяк может за ночь преодолеть до 10 километров в своем колесе. Хомяк может за ночь преодолеть до 10 километров в своем колесе. Хомяк может за ночь преодолеть до 10 километров в своем колесе.",
          @"Ленивец": @"Ленивцы спускаются с деревьев только затем, чтобы справить нужду. Ленивцы спускаются с деревьев только затем, чтобы справить нужду. Ленивцы спускаются с деревьев только затем, чтобы справить нужду. Ленивцы спускаются с деревьев только затем, чтобы справить нужду.",
          @"Кот": @"В среднем кошки тратят 2/3 суток на сон. В среднем кошки тратят 2/3 суток на сон. В среднем кошки тратят 2/3 суток на сон. В среднем кошки тратят 2/3 суток на сон.",
          @"Ящерица": @"Некоторые ящерицы могут выстрелить в противника собственной кровью. Некоторые ящерицы могут выстрелить в противника собственной кровью. Некоторые ящерицы могут выстрелить в противника собственной кровью. Некоторые ящерицы могут выстрелить в противника собственной кровью.",
          @"Голубь": @"Голуби могут пролететь до 900 км в сутки, развивая скорость до 70 км/ч. Голуби могут пролететь до 900 км в сутки, развивая скорость до 70 км/ч. Голуби могут пролететь до 900 км в сутки, развивая скорость до 70 км/ч. Голуби могут пролететь до 900 км в сутки, развивая скорость до 70 км/ч.",
          @"Лиса": @"Глубина лисьей норы достигает трех метров. Глубина лисьей норы достигает трех метров. Глубина лисьей норы достигает трех метров. Глубина лисьей норы достигает трех метров.",
          @"Альпака": @"Альпаки не имеют передних зубов на верхней челюсти. Альпаки не имеют передних зубов на верхней челюсти. Альпаки не имеют передних зубов на верхней челюсти. Альпаки не имеют передних зубов на верхней челюсти.",
          @"Лама": @"Ламы плюются, если их разозлить. Ламы плюются, если их разозлить. Ламы плюются, если их разозлить. Ламы плюются, если их разозлить."
    };
    
    self.animalImages = @{
          @"Пёс": [UIImage imageNamed:@"dog.jpg"],
          @"Конь": [UIImage imageNamed:@"horse.jpg"],
          @"Пума?": [UIImage imageNamed:@"cougar.jpg"],
          @"Верблюд": [UIImage imageNamed:@"camel.jpg"],
          @"Кенгуру": [UIImage imageNamed:@"kangaroo.jpg"],
          @"Енот": [UIImage imageNamed:@"raccoon.jpg"],
          @"Волк": [UIImage imageNamed:@"wolf.jpg"],
          @"Хомяк": [UIImage imageNamed:@"hamster.jpg"],
          @"Ленивец": [UIImage imageNamed:@"sloth.jpg"],
          @"Кот": [UIImage imageNamed:@"cat.jpg"],
          @"Ящерица": [UIImage imageNamed:@"lizard.jpg"],
          @"Голубь": [UIImage imageNamed:@"pigeon.jpg"],
          @"Лиса": [UIImage imageNamed:@"fox.jpg"],
          @"Альпака": [UIImage imageNamed:@"alpaca.jpg"],
          @"Лама": [UIImage imageNamed:@"llama.jpg"]
    };
}


@end

