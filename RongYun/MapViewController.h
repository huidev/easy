//
//  MapViewController.h
//  RongYun
//
//  Created by 乐米科技 on 6/6/15.
//  Copyright (c) 2015 zwh. All rights reserved.
//

#import "BaseViewController.h"
#import <BaiduMapAPI/BMapKit.h>
#import <CoreLocation/CoreLocation.h>
typedef enum {
    MAP_NAVIGATION,
    MAP_LOCATION_EDIT,
}MAP_TYPE;
@interface MapViewController : BaseViewController<BMKMapViewDelegate,BMKLocationServiceDelegate,BMKGeneralDelegate>
{
    
    BMKLocationService* _locService;
}
@property (weak, nonatomic) IBOutlet BMKMapView *mapView;
@property (assign, nonatomic)MAP_TYPE type;
@property (strong, nonatomic)NSString *annotationTitle;
@property (assign, nonatomic)CLLocationCoordinate2D local;
@end
