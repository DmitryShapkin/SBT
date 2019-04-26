//
//  DSViewController.m
//  SBT-Lesson-21 SberPoisk
//
//  Created by Dmitry Shapkin on 19/04/2019.
//  Copyright © 2019 Dmitry Shapkin. All rights reserved.
//


#import "DSViewController.h"
#import "DSDataSource.h"
#import "DSPhotoCollectionViewCell.h"
#import "DSImageViewController.h"
#import "SberColor.h"

@import UserNotifications;


@interface DSViewController () <UISearchBarDelegate, UNUserNotificationCenterDelegate, CollectionViewItemDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) DSDataSource *flickrDataSource;
@property (nonatomic, copy) NSString *lastSearchQuery;

@end


@implementation DSViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureNotificationCenter];
    
    /** Подпишемся на UIApplicationDidEnterBackgroundNotification
     Пуш сработает через 5 секунд после выхода из приложения */
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(sendPush)
                                                name:UIApplicationDidEnterBackgroundNotification
                                              object:nil];

    self.view.backgroundColor = [SberColor darkGreenSberColor];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    UIImage *logo = [UIImage imageNamed:@"logoSber"];
    UIImageView *titleImageView = [[UIImageView alloc] initWithImage:logo] ;
    self.navigationItem.titleView = titleImageView;
    
    CGFloat screenWidth = UIScreen.mainScreen.bounds.size.width;
    CGFloat searchBarHeight = 50;
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, screenWidth, searchBarHeight)];
    [self.searchBar setPlaceholder:@"Введите запрос"];
    self.searchBar.barTintColor = [SberColor darkGreenSberColor];
    self.searchBar.layer.borderColor = [SberColor darkGreenSberColor].CGColor;
    self.searchBar.layer.borderWidth = 1;
    self.searchBar.delegate = self;
    [self.view addSubview:self.searchBar];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(15, 15, 15, 15);
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    [self.collectionView registerClass:[DSPhotoCollectionViewCell class]
        forCellWithReuseIdentifier:DSCellIdentifier];
    self.flickrDataSource = [[DSDataSource alloc] initWithWidth:screenWidth];
    self.flickrDataSource.collectionView = self.collectionView;
    self.flickrDataSource.delegate = self;
    self.collectionView.dataSource = self.flickrDataSource;
    self.collectionView.delegate = self.flickrDataSource;
    [self.collectionView setBackgroundColor:[UIColor whiteColor]];
    
    [self.view addSubview:self.collectionView];
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
          [self.collectionView.topAnchor constraintEqualToAnchor:self.searchBar.bottomAnchor],
          [self.collectionView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
          [self.collectionView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
          [self.collectionView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor]
    ]];
}

- (void)startSearch
{
    if ([self checkEnglishLetters])
    {
        [self.flickrDataSource showPicturesWithQuery:self.searchBar.text];
        [self.searchBar endEditing:YES];
        self.lastSearchQuery = self.searchBar.text;
    }
    else
    {
        [self showAlertWithTitle:@"Запрос не может быть обработан" message:@"По-русски писать нельзя. Пожалуйста, используйте английскую раскладку"];
    }
}

- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"Ок" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alertController dismissViewControllerAnimated:true completion:nil];
    }];
    [alertController addAction:alertAction];
    [self presentViewController:alertController animated:true completion:nil];
}

/** Проверка на английские буквы */
- (BOOL)checkEnglishLetters
{
    NSCharacterSet *englishLettersAndNumbers = [NSCharacterSet characterSetWithCharactersInString: @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"];
    NSCharacterSet *notLetters = [englishLettersAndNumbers invertedSet];
    NSRange range = [self.searchBar.text rangeOfCharacterFromSet:notLetters];
    return range.location == NSNotFound ? YES : NO;
}

- (UIEdgeInsets)safeAreaInsets
{
    static CGFloat kStatusBarHeight = 20;
    
    /** Решение с отступом от SafeArea */
    if (@available(iOS 11.0, *))
    {
        UIWindow *window = nil;
        id appDelegate = UIApplication.sharedApplication.delegate;
        if ([appDelegate respondsToSelector:@selector(window)])
        {
            window = [appDelegate window];
        }
        else
        {
            window = UIApplication.sharedApplication.keyWindow;
        }
        UIEdgeInsets safeAreaInsets = window.safeAreaInsets;
        CGFloat top = MAX(safeAreaInsets.top, kStatusBarHeight);
        return UIEdgeInsetsMake(top, safeAreaInsets.right, safeAreaInsets.bottom, safeAreaInsets.left);
    }
    
    return UIEdgeInsetsMake(kStatusBarHeight, 0, 0, 0);
}


#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self startSearch];
}


#pragma mark - CollectionViewItemDelegate

- (void)pushViewControllerWithImageUrl:(NSString *)url
{
    DSImageViewController *imageViewController = [DSImageViewController new];
    imageViewController.imageURL = url;
    [self.navigationController pushViewController:imageViewController animated:YES];
}


#pragma mark - Local Push Notifications

- (void)sendPush
{
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    if (self.lastSearchQuery) /**< Выполним первый пуш только если был какой-либо запрос от пользователя */
    {
        [self sheduleLocalNotification];
    }
    [self sheduleLocalNotificationSecond];
}

- (void)sheduleLocalNotification
{
    NSString *identifier = @"DSNotificationId";
    UNMutableNotificationContent *content = [UNMutableNotificationContent new];
    content.title = @"Напоминание!";
    content.body = [NSString stringWithFormat:@"Вы давно не искали %@", self.lastSearchQuery];
    NSDictionary *dict = @{@"query": [NSString stringWithFormat:@"%@", self.lastSearchQuery]};
    content.userInfo = dict;
    content.sound = [UNNotificationSound defaultSound];
    content.badge = @([self giveNewBadgeNumber] + 1);
    UNNotificationAttachment *attachment = [self imageAttachment];
    if (attachment)
    {
        content.attachments = @[attachment];
    }
    UNNotificationTrigger *whateverTrigger = [self intervalTrigger:5];
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:identifier
                                                                          content:content trigger:whateverTrigger];
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error)
     {
         if (error)
         {
             NSLog(@"Чот пошло не так... %@",error);
         }
     }];
}

- (void)sheduleLocalNotificationSecond
{
    UNMutableNotificationContent *content = [UNMutableNotificationContent new];
    content.title = @"Второе напоминание!";
    content.body = [NSString stringWithFormat:@"Вы еще не искали Сбербанк"];
    content.sound = [UNNotificationSound defaultSound];
    content.badge = @([self giveNewBadgeNumber] + 1);
    NSDictionary *dict = @{
                           @"query": [NSString stringWithFormat:@"%@", @"Sberbank"]
                           };
    content.userInfo = dict;
    UNNotificationTrigger *whateverTrigger = [self intervalTrigger:15];
    NSString *identifier = @"DSNotificationIdSecond";
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:identifier
                                                                          content:content trigger:whateverTrigger];
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    [center addNotificationRequest:request withCompletionHandler:nil];
}

- (UNTimeIntervalNotificationTrigger *)intervalTrigger:(NSInteger)seconds
{
    return [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:seconds repeats:NO];
}


#pragma mark - ContentType

- (NSInteger)giveNewBadgeNumber
{
    return [UIApplication sharedApplication].applicationIconBadgeNumber;
}

- (UNNotificationAttachment *)imageAttachment
{
    NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"sberCat" withExtension:@"png"];
    NSError *error;
    UNNotificationAttachment *attachment = [UNNotificationAttachment attachmentWithIdentifier:@"pushImage" URL:fileURL options:nil error:&error];
    
    return attachment;
}


#pragma mark - UNUserNotificationCenterDelegate

- (void)userNotificationCenter:(UNUserNotificationCenter *)center
       willPresentNotification:(UNNotification *)notification
         withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler
{
    if (completionHandler)
    {
        completionHandler(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge);
    }
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center
didReceiveNotificationResponse:(UNNotificationResponse *)response
         withCompletionHandler:(void(^)(void))completionHandler
{
    UNNotificationContent *content = response.notification.request.content;
    if (content.userInfo[@"query"])
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
        NSString *query = content.userInfo[@"query"];
        self.searchBar.text = query;
        [self startSearch];
    }
    
    if (completionHandler)
    {
        completionHandler();
    }
}

- (void)configureNotificationCenter
{
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    center.delegate = self;
    UNAuthorizationOptions options = UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge;
    [center requestAuthorizationWithOptions:options
                          completionHandler:^(BOOL granted, NSError * _Nullable error) {
                              if (!granted)
                              {
                                  NSLog(@"Доступ не дали");
                              }
                          }];
}

@end
