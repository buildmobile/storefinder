//
//  StoreFinderAppDelegate.h
//  StoreFinder
//
//  Created by Jack Herrington on 4/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StoreFinderViewController;

@interface StoreFinderAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet StoreFinderViewController *viewController;

@end
