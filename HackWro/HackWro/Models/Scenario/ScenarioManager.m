//
//  ScenarioManager.m
//  Senario
//
//  Created by Michal Jodko on 11/9/12.
//  Copyright (c) 2012 Ajlabs. All rights reserved.
//

#import "ScenarioManager.h"
#import "Parser.h"

#define LOCATION_TOLERANCE 10.0

@interface ScenarioManager (Hidden)

- (void)loadObjectiveAtIndex:(NSUInteger)index;
- (BOOL)checkReachCondition:(CLLocation *)location;

@end

@implementation ScenarioManager

#pragma mark - Initializer

- (id)init {
    if((self = [super init])) {
        locationManager = [CLLocationManager new];
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.delegate = self;
        isPlaying = NO;
    }
    
    return self;
}


#pragma mark - Scenarios

- (Scenario *)loadScenario:(NSString *)path {
    isPlaying = NO;
    [locationManager stopUpdatingLocation];
    
    NSDictionary *dictionary = [Parser parseXML:path];
    
    if(dictionary) {
        loadedScenario = [[Scenario alloc] initWithDictionary:[dictionary objectForKey:@"scenario"]];
    } else {
        loadedScenario = nil;
    }
    
    return loadedScenario;
}

- (void)runScenario {
    if(loadedScenario.objectives.count > 0) {
        [self loadObjectiveAtIndex:0];
        isPlaying = YES;
        [locationManager startUpdatingLocation];
    } else {
        [self.delegate scenarioManager:self didFailWithError:[NSError errorWithDomain:@"ScenarioManager" code:-1 userInfo:[NSDictionary dictionaryWithObject:@"No objectives found!" forKey:NSLocalizedDescriptionKey]]];
        isPlaying = NO;
    }
}

- (void)stopScenario {
    isPlaying = NO;
    [locationManager startUpdatingLocation];
}

- (void)objectiveTimerTicked:(NSTimer *)timer {
    if(currentObjective.timeLimit > 0) {
        timeLeft--;
        [self.delegate scenarioManager:self timeLeftChanged:timeLeft];
        
        if(timeLeft == 0) {
            [self.delegate scenarioManager:self objectiveFailed:currentObjective];
            [self stopScenario];
            return;
        }
    }
    
    timeElapsed++;
    
    for(Event *event in currentObjective.events) {
        if(event.didOccur) {
            continue;
        }
        
        if((event.type == EVENT_TYPE_DELAYED_MESSAGE) && (event.delay <= timeElapsed)) {
            [self.delegate scenarioManager:self eventOccurred:event];
            event.didOccur = YES;
        }
    }
    
    if(lastLocation) {
        [self checkReachCondition:lastLocation];
    }
}

- (void)loadObjectiveAtIndex:(NSUInteger)index {
    currentObjectiveIndex = index;
    currentObjective = [loadedScenario.objectives objectAtIndex:index];
    
    for(Event *event in currentObjective.events) {
        event.didOccur = NO;
    }
    
    
    [self.delegate scenarioManager:self didLoadObjective:currentObjective];
    timeLeft = currentObjective.timeLimit;
    
    if(timeLeft > 0) {
        [self.delegate scenarioManager:self timeLeftChanged:timeLeft];
    }
    
    timeElapsed = 0;
    objectiveTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(objectiveTimerTicked:) userInfo:nil repeats:YES];
}


#pragma mark - CLLocationManagerDelegate methods

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    [self.delegate scenarioManager:self locationUpdated:newLocation];
    lastLocation = newLocation;
    
    if(![self checkReachCondition:newLocation]) {
        for(Event *event in currentObjective.events) {
            if(event.didOccur) {
                continue;
            }
            
            if((event.type == EVENT_TYPE_LOCATION_MESSAGE) && ([event.location distanceFromCLLocation:newLocation] <= LOCATION_TOLERANCE)) {
                [self.delegate scenarioManager:self eventOccurred:event];
                event.didOccur = YES;
            }
        }
    }
}

- (BOOL)checkReachCondition:(CLLocation *)location {
    double distance = [currentObjective.targetLocation distanceFromCLLocation:location];
    
    if(distance <= LOCATION_TOLERANCE) {
        if(currentObjective.targetLocation.reachEvent) {
            [self.delegate scenarioManager:self eventOccurred:currentObjective.targetLocation.reachEvent];
        }
        
        [locationManager stopUpdatingLocation];
        [objectiveTimer invalidate];
        
        if(currentObjectiveIndex == loadedScenario.objectives.count - 1) {
            [self.delegate scenarioManager:self scenarioCompleted:loadedScenario];
            isPlaying = NO;
        } else {
            [self loadObjectiveAtIndex:(currentObjectiveIndex + 1)];
            [locationManager startUpdatingLocation];
        }
        
        return YES;
    }
    
    return NO;
}

@end
