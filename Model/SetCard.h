// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Zahi Ajami.

#import "Card.h"
#import <UIKit/UIKit.h>

@interface SetCard : Card

/*
typedef NS_ENUM(NSInteger, ShadingType) {
  Solid,
  Striped,
  Open
};

typedef NS_ENUM(NSInteger, CardColorType) {
  Red,
  Green,
  Purple
};

typedef NS_ENUM(NSInteger, SymbolType) {
  Circle,
  Square,
  Triangle
};
 */

/// The following 4 properties describe a set card:
/// number is 1, 2 or 3
@property (nonatomic) NSUInteger number;
/// symbol is ▴, ● or ▪︎
@property (nonatomic) NSUInteger symbol;
/// shading is solid, striped or open
@property (nonatomic) NSUInteger shading;
/// color is red, green or purple
@property (nonatomic) NSUInteger color;

+ (NSUInteger)maxValidNumber;
+ (NSUInteger)minValidNumber;
+ (NSArray *)symbolOptions;
+ (NSArray *)shadingOptions;
+ (NSArray *)colorOptions;

@end


