//
//  CardMatchingGame.m
//  Ex3
//
//  Created by Zahi Ajami on 29/07/2018.
//  Copyright © 2018 Lightricks. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards; // of Card
@property (nonatomic,strong) NSMutableArray *chosenCards; // of Card
@property (strong, nonatomic, readwrite) NSArray *chosenCardsInLastMove;
@end


@implementation CardMatchingGame

static const int kMismatchPenalty = 2;
static const int kMatchBonus = 4;
static const int kCostToChoose = 1;
static const int kDefaultMatchMode = 2;

- (NSMutableArray *)cards {
  if (!_cards) {
    _cards = [[NSMutableArray alloc] init];
  }
  return _cards;
}

- (NSMutableArray *)chosenCards {
  if (!_chosenCards) {
    _chosenCards = [[NSMutableArray alloc] init];
  }
  return _chosenCards;
}

- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck {
  return [self initWithCardCount:count usingDeck:deck matchMode:kDefaultMatchMode];
}

- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck
                        matchMode:(NSUInteger)mode {
  assert(mode==2 || mode==3);
  if (self = [super init]){
    for (int i=0; i<count; i++) {
      Card *card = [deck drawRandomCard];
      if (card) {
        [self.cards addObject:card];
      } else {
        self = nil;
        break;
      }
    }
  }
  self.numOfCardsInMatch = mode;
  return self;
}

- (NSArray *)chosenCardsInLastMove {
  if (!_chosenCardsInLastMove) {
    _chosenCardsInLastMove = [[NSArray alloc] init];
  }
  return _chosenCardsInLastMove;
}


- (Card *)cardAtIndex:(NSUInteger) index {
  return (index < [self.cards count]) ? self.cards[index] : nil;
}

- (void)matchCards {
  int matchScore = 0;

  for (Card *card in self.chosenCards) {
    matchScore += [card match:self.chosenCards];
  }
  
  if (matchScore > 0) {
    for (Card *chosenCard in self.chosenCards) {
      chosenCard.isMatched = YES;
    }
    self.chosenCards = nil; // TODO - is it OK ? won't be null pointer exceptions ?
    matchScore = kMatchBonus * matchScore / 2;
    self.score += matchScore;
  } else {
    Card *firstChosenCard = [self.chosenCards firstObject];
    firstChosenCard.isChosen = NO;
    [self.chosenCards removeObject:firstChosenCard];
    self.score -= kMismatchPenalty;
  }
}

- (void)chooseCardAtIndex:(NSUInteger) index {
  Card *card = [self cardAtIndex:index];

  if (!card.isMatched) {
    if (card.isChosen) {
      card.isChosen = NO;
      [self.chosenCards removeObject:card];
      self.chosenCardsInLastMove = [self.chosenCards copy];
    } else {
      [self.chosenCards addObject:card];
      self.chosenCardsInLastMove = [self.chosenCards copy];
      assert([self.chosenCards count] <= self.numOfCardsInMatch);
    
      if ([self.chosenCards count] == self.numOfCardsInMatch) {
          // check for any matching in self.chosenCards and calculate score accordingly
        [self matchCards];
      }
    
      self.score -= kCostToChoose;
      card.isChosen = YES;
    }
  }
}

@end
