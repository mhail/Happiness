//
//  HappinessViewController.m
//  Happiness
//
//  Created by Matthew Hail on 6/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HappinessViewController.h"


@interface HappinessViewController () <FaceViewDataSource>
@property (nonatomic, weak) IBOutlet FaceView *faceView;
@end

@implementation HappinessViewController
@synthesize happiness = _happiness;
@synthesize faceView = _faceView;

-(float)smileForFaceView:(FaceView *)sender {
    return (self.happiness - 50) / 50.0;
}

- (void) setHappiness:(int)happiness {
    if (_happiness != happiness) {
        _happiness = happiness;
        [self.faceView setNeedsDisplay];
    }
}

- (void)setFaceView:(FaceView *)faceView {
    _faceView = faceView;
    [self.faceView addGestureRecognizer:[[UIPinchGestureRecognizer alloc] initWithTarget:self.faceView action:@selector(pinch:)]];
    
    [self.faceView addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleHappinessGesture:)]];
    
    self.faceView.dataSource = self;
}

-(void)handleHappinessGesture:(UIPanGestureRecognizer *)gesture {
    if(gesture.state == UIGestureRecognizerStateChanged || gesture.state == UIGestureRecognizerStateEnded ) {
        CGPoint translation = [gesture translationInView:self.faceView];
        self.happiness -= translation.y/2;
        [gesture setTranslation:CGPointZero inView:self.faceView];
    }
}

-(BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return YES;
}

@end
