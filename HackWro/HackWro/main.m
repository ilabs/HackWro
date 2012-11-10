//
//  main.m
//  HackWro
//
//  Created by Paweł Nużka on 09.11.2012.
//  Copyright (c) 2012 ploomworks. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HWAppDelegate.h"

int main(int argc, char *argv[])
{
    //@autoreleasepool {
        @try{
            return UIApplicationMain(argc, argv, nil, NSStringFromClass([HWAppDelegate class]));
    } @catch (NSException* exception) {
        NSLog(@"Uncaught exception: %@", exception.description);
        NSLog(@"Stack trace: %@", [exception callStackSymbols]);
    }
	
        
   // }
}
