//
//  MapAddressAppDelegate.h
//  MapAddress
//
//  Created by Dener Wilian Pereira do Carmo on 04/04/11.
//  Copyright 2011 Agence. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MapAddressViewController;

@interface MapAddressAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    MapAddressViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet MapAddressViewController *viewController;

@end

