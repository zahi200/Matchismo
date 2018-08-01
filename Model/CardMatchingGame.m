//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Zahi Ajami on 29/07/2018.
//  Copyright © 2018 Lightricks. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards; // of Card
@property (nonatomic,strong) NSMutableArray *chosenCards; // of Card
@property (nonatomic, strong, readwrite) NSString *currentStateText;
@end

@implementation CardMatchingGame


- (NSMutableArray *)cards
{
    if (!_cards){
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}

- (NSMutableArray *)chosenCards
{
    if (!_chosenCards){
        _chosenCards = [[NSMutableArray alloc] init];
    }
    return _chosenCards;
}

static const int DEFAULT_MATCH_MODE = 2;

- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck
{
    return [self initWithCardCount:count usingDeck:deck matchMode:DEFAULT_MATCH_MODE];
}

- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck
                        matchMode:(NSUInteger)mode {
  //TODO: verify that count is valid ?! (between 2 and 52?)
  assert(mode>=2 && mode<=3);
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

- (Card *)cardAtIndex:(NSUInteger) index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}


static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

- (void)matchCards
{
    int matchScore = 0;
    NSString *chosenCardsText = [self chosenCardsText];
    
    for (Card *card in self.chosenCards){
        matchScore += [card match:self.chosenCards];
    }
    
    if (matchScore > 0){
        for (Card *chosenCard in self.chosenCards){
            chosenCard.isMatched = YES;
        }
        self.chosenCards = nil; // TODO - is it OK ? won't be null pointer exceptions ?
        matchScore = MATCH_BONUS * matchScore / 2;
        self.score += matchScore;
        self.currentStateText = [NSString stringWithFormat:@"Matched %@for %d points", chosenCardsText, matchScore];
    } else {
        Card *firstChosenCard = [self.chosenCards firstObject];
        firstChosenCard.isChosen = NO;
        [self.chosenCards removeObject:firstChosenCard];
        self.score -= MISMATCH_PENALTY;
        self.currentStateText = [NSString stringWithFormat:@"%@don't match! %d points penalty!", chosenCardsText, MISMATCH_PENALTY];
    }
}


- (NSString *)chosenCardsText
{
    NSString *text = @"";
    
    for (Card *card in self.chosenCards){
        text = [text stringByAppendingString:[card.contents stringByAppendingString:@" "]];
    }
    
    return text;
}


- (void)chooseCardAtIndex:(NSUInteger) index
{
    Card *card = [self cardAtIndex:index];
    
    if (!card.isMatched){
        if (card.isChosen){
            card.isChosen = NO;
            [self.chosenCards removeObject:card];
            self.currentStateText = [self chosenCardsText];
        } else {
            [self.chosenCards addObject:card];
            assert([self.chosenCards count] <= self.numOfCardsInMatch);
            
            if ([self.chosenCards count] == self.numOfCardsInMatch) {
                // check for any matching in self.chosenCards and calculate score accordingly
                [self matchCards];
            } else if ([self.chosenCards count] < self.numOfCardsInMatch){
                self.currentStateText = [self chosenCardsText];
            }
            
            self.score -= COST_TO_CHOOSE;
            card.isChosen = YES;
        }
    }
}


/* OLD VERSION FROM LECTURE - MATCHING 2 CARDS ONLY
- (void)chooseCardAtIndex:(NSUInteger) index
{
    Card *card = [self cardAtIndex:index];
    
    if (!card.isMatched){
        if (card.isChosen){
            card.isChosen = NO;
        } else {
            // match against other chosen cards
            for (Card *otherCard in self.cards){
                if (otherCard.isChosen && !otherCard.isMatched){
                    int matchScore = [card match:@[otherCard]];
                    if (matchScore){
                        self.score += matchScore * MATCH_BONUS;
                        card.isMatched = YES;
                        otherCard.isMatched = YES;
                    } else {
                        self.score -= MISMATCH_PENALTY;
                        otherCard.isChosen = NO;
                    }
                    break;
                }
            }
            self.score -= COST_TO_CHOOSE;
            card.isChosen = YES;
        }
    }
}
*/

@end
