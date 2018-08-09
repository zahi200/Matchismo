// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Zahi Ajami.

#import "SetCard.h"

@implementation SetCard

static const int kMatchSetScore = 1;

+ (NSUInteger)maxValidNumber {
  return 3;
}

+ (NSUInteger)minValidNumber {
  return 1;
}

+ (NSArray *)symbolOptions {
  return @[@"▲", @"●", @"◼︎"];
}

+ (NSArray *)shadingOptions {
  return @[@(0.0f), @(0.3f), @(1.0f)];
}

+ (NSArray *)colorOptions {
  return @[@"red", @"green", @"purple"];
}

+ (BOOL)isMatchingSet:(SetCard *)firstCard secondCard:(SetCard *)secondCard
            thirdCard:(SetCard *)thirdCard {
  return ([SetCard isMatchNumber:firstCard secondCard:secondCard thirdCard:thirdCard] &&
      [SetCard isMatchSymbol:firstCard secondCard:secondCard thirdCard:thirdCard] &&
      [SetCard isMatchShading:firstCard secondCard:secondCard thirdCard:thirdCard] &&
      [SetCard isMatchColor:firstCard secondCard:secondCard thirdCard:thirdCard]);
}

+ (BOOL)isMatchNumber:(SetCard *)firstCard secondCard:(SetCard *)secondCard
            thirdCard:(SetCard *)thirdCard {
  return [SetCard isAllSameOrDifferent:@[[NSNumber numberWithUnsignedInteger:firstCard.number],
                                         [NSNumber numberWithUnsignedInteger:secondCard.number],
                                         [NSNumber numberWithUnsignedInteger:thirdCard.number]]];
}

+ (BOOL)isMatchSymbol:(SetCard *)firstCard secondCard:(SetCard *)secondCard
            thirdCard:(SetCard *)thirdCard {
  return [SetCard isAllSameOrDifferent:@[[NSNumber numberWithUnsignedInteger:firstCard.symbol],
                                         [NSNumber numberWithUnsignedInteger:secondCard.symbol],
                                         [NSNumber numberWithUnsignedInteger:thirdCard.symbol]]];
}


+ (BOOL)isMatchShading:(SetCard *)firstCard secondCard:(SetCard *)secondCard
             thirdCard:(SetCard *)thirdCard {
  return [SetCard isAllSameOrDifferent:@[[NSNumber numberWithUnsignedInteger:firstCard.shading],
                                         [NSNumber numberWithUnsignedInteger:secondCard.shading],
                                         [NSNumber numberWithUnsignedInteger:thirdCard.shading]]];
}

+ (BOOL)isMatchColor:(SetCard *)firstCard secondCard:(SetCard *)secondCard
           thirdCard:(SetCard *)thirdCard {
  return [SetCard isAllSameOrDifferent:@[[NSNumber numberWithUnsignedInteger:firstCard.color],
                                         [NSNumber numberWithUnsignedInteger:secondCard.color],
                                         [NSNumber numberWithUnsignedInteger:thirdCard.color]]];
}

+ (BOOL)isAllSameOrDifferent:(NSArray *)values{
  if ([values count] <= 1) {
    return YES;
  }
  if ([values[0] isEqual:values[1]]){
    for (int i = 2; i < [values count]; i++) {
      if (![values[0] isEqual:values[i]]) {
        return NO;
      }
    }
  } else {
    for (int i = 0; i < [values count]; i++) {
      for (int j = i + 1; j < [values count]; j++) {
        if ([values[i] isEqual:values[j]]) {
          return NO;
        }
      }
    }
  }
  return YES;
}

- (NSString *)contents {
  return nil;
}

- (void)setNumber:(NSUInteger)number {
  if (number >= [SetCard minValidNumber] && number <= [SetCard maxValidNumber] ) {
    _number = number;
  }
}

- (void)setSymbol:(NSUInteger)symbol {
  if (symbol >= 1 && symbol <= [[SetCard symbolOptions] count]) {
    _symbol = symbol;
  }
}

- (void)setShading:(NSUInteger)shading {
  if (shading >= 1 && shading <= [[SetCard shadingOptions] count]) {
    _shading = shading;
  }
}

- (void)setColor:(NSUInteger)color {
  if (color >= 1 && color <= [[SetCard colorOptions] count]) {
    _color = color;
  }
}

- (int)match:(NSArray *)otherCards {
  if ([otherCards count] != 3) {
    return 0;
  }
  return [SetCard isMatchingSet:otherCards[0] secondCard:otherCards[1] thirdCard:otherCards[2]] ?
      kMatchSetScore : 0;
}

@end
