// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Zahi Ajami.

#import "SetCardDeck.h"

@implementation SetCardDeck

- (instancetype)init {
  if (self = [super init]) {
    for (NSUInteger number = [SetCard minValidNumber]; number <= [SetCard maxValidNumber]; number++) {
      for (NSUInteger symbol = 1; symbol <= [[SetCard symbolOptions] count]; symbol++) {
        for (NSUInteger shading = 1; shading <= [[SetCard shadingOptions] count]; shading++) {
          for (NSUInteger color = 1; color <= [[SetCard colorOptions] count]; color++) {
            SetCard *newCard = [[SetCard alloc] init];
            newCard.number = number;
            newCard.symbol = symbol;
            newCard.shading = shading;
            newCard.color = color;
            [self addCard:newCard];
          }
        }
      }
    }
  }
  return self;
}

@end

