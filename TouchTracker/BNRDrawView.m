//
//  BNRDrawView.m
//  TouchTracker
//
//  Created by Kevin Candelaria on 10/16/14.
//  Copyright (c) 2014 Kevin Candelaria. All rights reserved.
//

#import "BNRDrawView.h"
#import "BNRLine.h"

@interface BNRDrawView ()
// @property (nonatomic, strong) BNRLine *currentLine;
@property (nonatomic, strong) NSMutableDictionary *linesInProgress;
@property (nonatomic, strong) NSMutableArray *finishedLines;
@end

@implementation BNRDrawView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        self.linesInProgress = [[NSMutableDictionary alloc] init];
        self.finishedLines = [[NSMutableArray alloc] init];
        self.backgroundColor = [UIColor grayColor];
        self.multipleTouchEnabled = YES;
    }
    return self;
}
- (void)strokeLine:(BNRLine *)line
{
    UIBezierPath *bp = [UIBezierPath bezierPath];
    bp.lineWidth = 10;
    bp.lineCapStyle = kCGLineCapRound;
    
    [bp moveToPoint:line.begin];
    [bp addLineToPoint:line.end];
    [bp stroke];
    
}
- (void)drawRect:(CGRect)rect
{
    [[UIColor blackColor] set];
    for(BNRLine *line in self.finishedLines){
        [self strokeLine:line];
    }
    
    for (NSValue *key in self.linesInProgress){
        [self strokeLine:self.linesInProgress[key]];
    }
    
    // if (self.currentLine){
    //     [[UIColor redColor] set];
    //     [self strokeLine:self.currentLine];
    // }
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    for(UITouch *t in touches){
        CGPoint location = [t locationInView:self];
        
        BNRLine *line = [[BNRLine alloc] init];
        line.begin = location;
        line.end = location;
        
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        self.linesInProgress[key] = line;
    }
    
    // CGPoint location = [t locationInView:self];
    
    // self.currentLine = [[BNRLine alloc] init];
    // self.currentLine.begin = location;
    // self.currentLine.end = location;
    
    [self setNeedsDisplay];
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    for (UITouch *t in touches){
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        BNRLine *line = self.linesInProgress[key];
        
        line.end = [t locationInView:self];
    }
    // UITouch *t = [touches anyObject];
    // CGPoint location = [t locationInView:self];
    
    // self.currentLine.end = location;
    
    [self setNeedsDisplay];
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    for (UITouch *t in touches){
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        BNRLine *line = self.linesInProgress[key];
        
        [self.finishedLines addObject:line];
        [self.linesInProgress removeObjectForKey:key];
    }
    // [self.finishedLines addObject:self.currentLine];
    
    // self.currentLine = nil;
    
    [self setNeedsDisplay]; 
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    for (UITouch *t in touches){
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        [self.linesInProgress removeObjectForKey:key];
    }
    [self setNeedsDisplay];
}
@end
