//
//  MYMapViewController.m
//  MYUtils
//
//  Created by sunjinshuai on 2017/11/21.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "MYMapViewController.h"
#import "UINavigationController+PopGesture.h"
#import <MapKit/MapKit.h>

@interface MYMapViewController ()
@end

@implementation MYMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configMapView];
}

- (void)configMapView {
    MKMapView *mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:mapView];
    
    // mapView需要支持侧滑返回
    [self my_addPopGestureToView:mapView];
}

@end
