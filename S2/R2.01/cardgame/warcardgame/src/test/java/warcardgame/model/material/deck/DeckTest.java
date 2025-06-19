package warcardgame.model.material.deck;

import static org.assertj.core.api.Assertions.assertThat;
import static org.junit.jupiter.api.Assertions.*;

import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;

import org.junit.jupiter.api.Test;

import warcardgame.model.material.Card;
import warcardgame.model.material.Rank;
import warcardgame.model.material.Suit;

class DeckTest {

	private static final Card ACE_OF_HEARTS = new Card(Rank.ACE, Suit.HEARTS);
	private static final Card KING_OF_DIAMONDS = new Card(Rank.KING, Suit.DIAMONDS);
	private static final Card QUEEN_OF_CLUBS = new Card(Rank.QUEEN, Suit.CLUBS);
	private static final Card TEN_OF_SPADES = new Card(Rank.TEN, Suit.SPADES);

	@Test
	void theDeckIsEmptyAtTheBeginning() {
		Deck deck = new Deck();
		assertTrue(deck.isEmpty());
	}
	
	@Test
	void theDeckIsNotEmptyWhenACardPutInTheDeck() {
		Deck deck = new Deck();
		Boolean isPut = deck.put(ACE_OF_HEARTS);
		
		assertTrue(isPut);
		assertFalse(deck.isEmpty());
	}
	
	@Test
	void deckHasOneCardWhenACardPutInAnEmptyDeck() {
		Deck deck = new Deck();
		Boolean isPut = deck.put(ACE_OF_HEARTS);
		
		assertTrue(isPut);
		assertFalse(deck.isEmpty());
		assertEquals(1, deck.remainingCards());
	}
	
	@Test
	void deckHasTwoCardsWhenTwoCardsPutInAnEmptyDeck() {
		Deck deck = new Deck();
		Boolean isPut = deck.put(ACE_OF_HEARTS, KING_OF_DIAMONDS);

		assertTrue(isPut);
		assertFalse(deck.isEmpty());
		assertEquals(2, deck.remainingCards());
	}
	
	@Test
	void returnFalseWhenNoCardPutInAnEmptyDeck() {
		Deck deck = new Deck();
		Boolean isPut = deck.put();
		
		assertFalse(isPut);
	}
	
	@Test
	void deckContainsTheRightCardsPutInAnEmptyDeck() {
		Deck deck = new Deck();
		Boolean isPut = deck.put(ACE_OF_HEARTS, KING_OF_DIAMONDS, QUEEN_OF_CLUBS, TEN_OF_SPADES);
		
		Collection<Card> cards = deck.cards();
		
		assertThat(cards).containsExactly(ACE_OF_HEARTS, KING_OF_DIAMONDS, QUEEN_OF_CLUBS, TEN_OF_SPADES)
						 .containsSequence(ACE_OF_HEARTS, KING_OF_DIAMONDS, QUEEN_OF_CLUBS, TEN_OF_SPADES);
	}
	
	@Test
	void deckIsEmptyWhenItIsCleared() {
		Deck deck = new Deck();
		deck.put(ACE_OF_HEARTS, KING_OF_DIAMONDS, QUEEN_OF_CLUBS, TEN_OF_SPADES);
		
		
		deck.clear();
		assertTrue(deck.isEmpty());
		assertThat(deck.remainingCards()).isZero();
	}
	
	@Test
	void aCollectionOfCardsCanBePutOnceInTheDeck() {
		Deck deck = new Deck();
		Collection<Card> newCards = Arrays.asList(ACE_OF_HEARTS, KING_OF_DIAMONDS, QUEEN_OF_CLUBS);
		Boolean isPut = deck.put(newCards);
		
		assertThat(deck.remainingCards()).isEqualTo(3);
		assertThat(deck.cards()).containsExactly(ACE_OF_HEARTS, KING_OF_DIAMONDS, QUEEN_OF_CLUBS)
								.containsSequence(ACE_OF_HEARTS, KING_OF_DIAMONDS, QUEEN_OF_CLUBS);
		
	}
	
	@Test
	void returnFalseWhenCardsCollectionOfDeckDoesNotChange() {
		Deck deck = new Deck();
		Collection<Card> newCards = new ArrayList<>();
		
		Boolean isPut = deck.put(newCards);
		
		assertFalse(isPut);
	}
	
	@Test 
	void theDeckIsEmptyAnCardIsOutTheDeskWhenACardIsDrawn() {
		Deck deck = new Deck();
		deck.put(ACE_OF_HEARTS);
		
		Card drawnCard = deck.draw();
		
		assertTrue(deck.isEmpty());
		assertThat(drawnCard).isEqualTo(ACE_OF_HEARTS);
	}
	
	@Test
	void firstCardOfTheDeckIsOutWhenDrawn() {
		Deck deck = new Deck();
		deck.put(KING_OF_DIAMONDS,ACE_OF_HEARTS,QUEEN_OF_CLUBS);
		
		Card drawnCard = deck.draw();
		
		assertThat(drawnCard).isEqualTo(KING_OF_DIAMONDS);
		assertThat(deck.remainingCards()).isEqualTo(2);
	}
	
	@Test
	void returnNullWhenDrawnWithAnEmptyDeck() {
		Deck deck = new Deck();
		
		Card drawnCard = deck.draw();
		
		assertThat(drawnCard).isNull();
	}
}
