// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Zahi Ajami.

#import "SetCardGameViewController.h"
#import "SetCardDeck.h"

@implementation SetCardGameViewController

static const int kNumOfCardsInMatchSetGame = 3;

- (Deck *)createDeck {
  return [[SetCardDeck alloc] init];
}

- (NSUInteger)getNumOfCardsInMatch {
  return kNumOfCardsInMatchSetGame;
}

- (void)updateCardButtonUI:(Card *)card cardButton:(UIButton *)cardButton {
  if ([card isKindOfClass:[SetCard class]]) {
    SetCard *setCard = (SetCard *)card;
    [cardButton setAttributedTitle:[self getCardAttributedString:setCard] forState:UIControlStateNormal];
    
    cardButton.layer.borderWidth = (card.isChosen && !card.isMatched) ? 3 : 0;
    cardButton.layer.borderColor = [UIColor redColor].CGColor;

  }
}

- (NSAttributedString *)getCardAttributedString:(Card *)card {
  if (![card isKindOfClass:[SetCard class]]) {
    return nil;
  }
  SetCard *setCard = (SetCard *)card;
  
  // string for card
  NSMutableString *shape = (setCard.symbol >= 1 && setCard.symbol <=3) ?
      [SetCard symbolOptions][setCard.symbol - 1] : @"";
  NSMutableString *multipleShaped = [[NSMutableString alloc] init];
  for (int i = 1; i <= setCard.number ; i++) {
    [multipleShaped appendString:shape];
  }
  
  // color setting:
  NSString *colorString = (setCard.color >= 1 && setCard.color <= 3 ) ?
  [SetCard colorOptions][setCard.color - 1] : @"";
  UIColor *setCardColor;
  if ([colorString isEqualToString:@"red"]) {
    setCardColor = [UIColor redColor];
  } else if ([colorString isEqualToString:@"green"]) {
    setCardColor = [UIColor greenColor];
  } else if ([colorString isEqualToString:@"purple"]) {
    setCardColor = [UIColor purpleColor];
  }
  
  // shading
  UIColor *setCardColorWithShading;
  NSNumber *alphaValueNumber = (setCard.shading >= 1 && setCard.shading <=3) ?
  [SetCard shadingOptions][setCard.shading - 1] : nil;
  CGFloat alphaValue = [alphaValueNumber doubleValue];
  // (CGFloat)([SetCard shadingOptions][self.shading - 1])
  setCardColorWithShading = [setCardColor colorWithAlphaComponent:alphaValue];
  
  return [[NSMutableAttributedString alloc] initWithString:multipleShaped
          attributes:@{NSForegroundColorAttributeName : setCardColorWithShading,
                       NSStrokeWidthAttributeName : @-5,
                       NSStrokeColorAttributeName : setCardColor,
                       NSFontAttributeName : [UIFont  fontWithName:@"Palatino-Roman" size:25.0]
                       }];
  
  
}

@end
