//
//  ScenarioManager.h
//  Senario
//
//  Created by Michal Jodko on 11/9/12.
//  Copyright (c) 2012 Ajlabs. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Scenario.h"
#import "Objective.h"
#import "Event.h"
#import "Location.h"

@protocol ScenarioManagerDelegate;

@interface ScenarioManager : NSObject <CLLocationManagerDelegate> {
    CLLocationManager *locationManager;
    Scenario *loadedScenario;
    Objective *currentObjective;
    NSUInteger currentObjectiveIndex;
    BOOL isPlaying;
    NSTimer *objectiveTimer;
    NSUInteger timeLeft, timeElapsed;
    CLLocation *lastLocation;
}

- (Scenario *)loadScenario:(NSString *)path;
- (void)runScenario;
- (void)stopScenario;

@property (nonatomic, strong) id<ScenarioManagerDelegate> delegate;

@end


@protocol ScenarioManagerDelegate <NSObject>

- (void)scenarioManager:(ScenarioManager *)scenarioManager didLoadObjective:(Objective *)objective;
- (void)scenarioManager:(ScenarioManager *)scenarioManager didFailWithError:(NSError *)error;
- (void)scenarioManager:(ScenarioManager *)scenarioManager timeLeftChanged:(NSUInteger)timeLeft;
- (void)scenarioManager:(ScenarioManager *)scenarioManager objectiveFailed:(Objective *)objective;
- (void)scenarioManager:(ScenarioManager *)scenarioManager eventOccurred:(Event *)event;
- (void)scenarioManager:(ScenarioManager *)scenarioManager locationUpdated:(CLLocation *)location;
- (void)scenarioManager:(ScenarioManager *)scenarioManager scenarioCompleted:(Scenario *)scenario;

@end
