//
//  DSImageViewController.m
//  SBT-Lesson-21 SberPoisk
//
//  Created by Dmitry Shapkin on 19/04/2019.
//  Copyright © 2019 Dmitry Shapkin. All rights reserved.
//


#import "DSImageViewController.h"
#import "SberColor.h"


@interface DSImageViewController ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) CIFilter *fiter;

@end


typedef NS_ENUM(NSInteger, DSImageFilter)
{
    Sepia,
    Vignette,
    Noir
};


@implementation DSImageViewController

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.imageView = [UIImageView new];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupUserInterface];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = @"Фильтры";
}

- (void)setupUserInterface
{
    self.view.backgroundColor = UIColor.whiteColor;
    CGFloat width = UIScreen.mainScreen.bounds.size.width;

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:self.imageURL]];
        if (!data)
        {
            // TODO: Показать сообщение об ошибке
            return;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
                self.imageView.image = [UIImage imageWithData:data];
        });
    });

    self.imageView.frame = CGRectMake(15, 15, width - 30, width - 30);
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.layer.masksToBounds = YES;
    self.imageView.layer.cornerRadius = 15.f;
    
    UIView *shadowView = [UIView new];
    shadowView.frame = CGRectMake(15, 15, width - 30, width - 30);
    shadowView.layer.shadowRadius = 30.f;
    shadowView.layer.shadowColor = [UIColor blackColor].CGColor;
    shadowView.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    shadowView.layer.shadowOpacity = 0.5f;
    shadowView.layer.masksToBounds = NO;
    UIEdgeInsets shadowInsets = UIEdgeInsetsMake(0, 0, -0.1f, 0);
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:UIEdgeInsetsInsetRect(shadowView.bounds, shadowInsets)];
    shadowView.layer.shadowPath = shadowPath.CGPath;
    
    [self.view addSubview:shadowView];
    [self.view addSubview:self.imageView];
    
    UIButton* firstButton = [self createButtonWithTitle:@"Сепия"];
    firstButton.center = CGPointMake(self.view.center.x, self.imageView.bounds.size.height + firstButton.bounds.size.height + 15);
    [firstButton addTarget:self action:@selector(applySepiaFilter) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:firstButton];
    
    UIButton* secondButton = [self createButtonWithTitle:@"Виньетка"];
    secondButton.center = CGPointMake(self.view.center.x, self.imageView.bounds.size.height + secondButton.bounds.size.height * 2 + 15 * 2);
    [secondButton addTarget:self action:@selector(applyVignetteFilter) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:secondButton];
    
    UIButton* thirdButton = [self createButtonWithTitle:@"Нуар"];
    thirdButton.center = CGPointMake(self.view.center.x, self.imageView.bounds.size.height + thirdButton.bounds.size.height * 3 + 15 * 3);
    [thirdButton addTarget:self action:@selector(applyNoirFilter) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:thirdButton];
}

- (void)setImage:(UIImage *)image
{
    [self.imageView setImage:image];
}

- (UIButton *)createButtonWithTitle:(NSString *)title
{
    UIButton *filterButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [filterButton.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:18.0]];
    [filterButton.titleLabel setTextColor:[UIColor whiteColor]];
    filterButton.contentEdgeInsets = UIEdgeInsetsMake(15, 20, 15, 20);
    filterButton.backgroundColor = [SberColor darkGreenSberColor];
    filterButton.layer.cornerRadius = 26.f;
    [filterButton setTitle:title forState:UIControlStateNormal];
    [filterButton sizeToFit];
    filterButton.layer.shadowRadius = 15.f;
    filterButton.layer.shadowColor = [SberColor darkGreenSberColor].CGColor;
    filterButton.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    filterButton.layer.shadowOpacity = 0.3f;
    filterButton.layer.masksToBounds = NO;
    UIEdgeInsets shadowInsets = UIEdgeInsetsMake(0, 0, -0.2f, 0);
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:UIEdgeInsetsInsetRect(filterButton.bounds, shadowInsets)];
    filterButton.layer.shadowPath = shadowPath.CGPath;
    
    return filterButton;
}


#pragma mark - Filters

- (void)applySepiaFilter
{
    [self applyFilter:Sepia];
}

- (void)applyVignetteFilter
{
    [self applyFilter:Vignette];
}

- (void)applyNoirFilter
{
    [self applyFilter:Noir];
}

- (void)applyFilter:(DSImageFilter)filter
{
    CIContext *imageContext = [CIContext contextWithOptions:nil];
    CIImage *image = [[CIImage alloc]initWithImage:self.imageView.image];
    CIFilter *imageFilter = [[CIFilter alloc] init];
    
    switch (filter)
    {
        case Sepia:
        {
            imageFilter = [CIFilter filterWithName:@"CISepiaTone" keysAndValues: kCIInputImageKey, image, @"inputIntensity", @1, nil];
            break;
        }
        case Vignette:
        {
            imageFilter = [CIFilter filterWithName:@"CIVignette" keysAndValues: kCIInputImageKey,image, nil];
            [imageFilter setDefaults];
            [imageFilter setValue: image forKey: @"inputImage"];
            [imageFilter setValue: [NSNumber numberWithFloat: 1.0] forKey: @"inputIntensity"];
            [imageFilter setValue: [NSNumber numberWithFloat: 10.00 ] forKey: @"inputRadius"];
            break;
        }
        case Noir:
        {
            imageFilter = [CIFilter filterWithName:@"CIPhotoEffectNoir" keysAndValues: kCIInputImageKey,image, nil];
            break;
        }
        default:
            break;
    }
    CIImage *result = [imageFilter valueForKey: @"outputImage"];
    CGImageRef cgImageRef = [imageContext createCGImage:result fromRect:[result extent]];
    UIImage *targetImage = [UIImage imageWithCGImage:cgImageRef];
    self.imageView.image = targetImage;
}

@end
