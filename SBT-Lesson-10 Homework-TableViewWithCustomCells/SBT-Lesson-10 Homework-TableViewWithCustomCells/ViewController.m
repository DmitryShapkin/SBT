//
//  ViewController.m
//  SBT-Lesson-10 Homework-TableViewWithCustomCells
//
//  Created by Dmitry Shapkin on 20/03/2019.
//  Copyright © 2019 Dmitry Shapkin. All rights reserved.
//

#import "ViewController.h"
#import "Worker.h"
#import "CellProtocol.h"
#import "CustomTableViewCellOne.h"
#import "CustomTableViewCellTwo.h"


@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<NSString *> *animals;
@property (nonatomic, strong) NSMutableArray<Worker *> *workers;
@property (nonatomic, strong) NSMutableArray<NSString *> *strings;
@property (nonatomic, strong) UITableViewCell<CellProtocol> *cell;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 120.f;
    
    [self.tableView registerClass:[CustomTableViewCellOne class] forCellReuseIdentifier:NSStringFromClass([CustomTableViewCellOne class])];
    [self.tableView registerClass:[CustomTableViewCellTwo class] forCellReuseIdentifier:NSStringFromClass([CustomTableViewCellTwo class])];
    
    [self.view addSubview:self.tableView];
    
    [self createWorkers];
}

- (void)createWorkers
{
    self.workers = [[NSMutableArray alloc] init];
    
    NSArray *professions = @[@"Doctor", @"Businessman", @"UX Designer", @"Sales Manager", @"Junior Developer", @"Teacher", @"Middle Developer", @"Builder", @"Senior Developer", @"Team Lead", @"Product Owner", @"Painter", @"Driver", @"Accountant", @"Singer"];
    
    NSArray *names = @[@"Harold Smith", @"Harold Thompson", @"Harold Davis", @"Harold Williams", @"Harold Johnson", @"Haroldina Anderson", @"Harold Sanchez", @"Harold Scott", @"Harold Turner", @"Harold Morris", @"Harold Cook", @"Harold Roberts", @"Harold Morgan", @"Harold Cox", @"Harold Sanders"];
    
    NSArray *photos = @[[UIImage imageNamed:@"Doctor.jpg"],
                        [UIImage imageNamed:@"Businessman.jpg"],
                        [UIImage imageNamed:@"UXDesigner.jpg"],
                        [UIImage imageNamed:@"SalesManager.jpg"],
                        [UIImage imageNamed:@"Junior.jpg"],
                        [UIImage imageNamed:@"Teacher.jpg"],
                        [UIImage imageNamed:@"MiddleDeveloper.jpg"],
                        [UIImage imageNamed:@"Builder.jpg"],
                        [UIImage imageNamed:@"SeniorDeveloper.jpg"],
                        [UIImage imageNamed:@"TeamLead.jpg"],
                        [UIImage imageNamed:@"ProductOwner.jpg"],
                        [UIImage imageNamed:@"Painter.jpg"],
                        [UIImage imageNamed:@"Driver.jpg"],
                        [UIImage imageNamed:@"Accountant.jpg"],
                        [UIImage imageNamed:@"Singer.jpg"]
                        ];
    
    for (int i = 0; i < [names count]; i++) {
        Worker *worker = [Worker new];
        worker.name = names[i];
        worker.profession = professions[i];
        worker.photoImage = photos[i];
        
        [self.workers addObject:worker];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.workers.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if (indexPath.row % 2) {
        self.cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CustomTableViewCellOne class])];
    } else {
        self.cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CustomTableViewCellTwo class])];
    }
    
    Worker *worker = self.workers[indexPath.row];
    self.cell.coverImageView.image = worker.photoImage;
    self.cell.titleLabel.text = worker.name;
    self.cell.subtitileLabel.text = worker.profession;

    return self.cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Worker *worker = self.workers[indexPath.row];
    
    NSString *name = worker.name;
    NSString *profession = worker.profession;
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:name message:profession preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *confirmActionButton = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];

    // Add photo to UIAlertController
    UIAlertAction *imageAction = [UIAlertAction actionWithTitle:@"" style:UIAlertActionStyleDefault handler:nil];
    [imageAction setValue:[[self fitImage:worker.photoImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forKey:@"image"];
    [alertController addAction:imageAction];

    [alertController addAction:confirmActionButton];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (UIImage*)fitImage:(UIImage*)image {
    CGSize newSize = CGSizeMake(248, 248);
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
