//
//  ReceiverViewController.m
//  MorseTorch
//
//  Created by Reed Sweeney on 4/18/14.
//  Copyright (c) 2014 Reed Sweeney. All rights reserved.
//

#import "ReceiverViewController.h"
#import <GPUImage/GPUImage.h>

@interface ReceiverViewController ()

@property (strong, nonatomic) GPUImageVideoCamera *videoCamera;
@property (weak, nonatomic) IBOutlet UILabel *luminLabel;

@end

@implementation ReceiverViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    _videoCamera = [GPUImageVideoCamera new];
    _videoCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
    
    
    
    GPUImageLuminosity*lumin = [[GPUImageLuminosity alloc] init];
    [_videoCamera addTarget:lumin];
    
    
    
    [(GPUImageLuminosity *)lumin setLuminosityProcessingFinishedBlock:^(CGFloat luminosity, CMTime frameTime) {
        dispatch_async(dispatch_get_main_queue(), ^{
            _luminLabel.text = [NSString stringWithFormat:@"%f", luminosity];
        });

        NSLog(@"Lumin is %f ", luminosity);
    }];
    
    [_videoCamera startCameraCapture];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end









