package fr.unilim.iut;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

import java.util.LinkedList;

import org.junit.jupiter.api.Test;

class TestDoublures {
	@Test
	void test_UnPremierStub() {
		User user = mock(User.class);
		when(user.getLogin()).thenReturn("alice");
		System.out.println(user.getLogin());
		assertEquals("alice", user.getLogin());
		// assertEquals("bob", user.getLogin());
	}
	
	@Test
	void test_UnPremierMock() {
		User user = mock(User.class);
		when(user.getLogin()).thenReturn("alice");
		System.out.println(user.getLogin());
		System.out.println(user.getLogin());
		verify(user, times(2)).getLogin();	
	}
	
	@Test
	void test_OptionsVerification() {
		LinkedList<String> mockedList = mock(LinkedList.class);
		mockedList.add("once");
		mockedList.add("twice");
		mockedList.add("twice");
		mockedList.add("three times");
		mockedList.add("three times");
		mockedList.add("three times");
		//following two verifications work exactly the same - times(1) is used by default
		verify(mockedList).add("once");
		verify(mockedList, times(1)).add("once");
		//exact number of invocations verification
		verify(mockedList, times(2)).add("twice");
		verify(mockedList, times(3)).add("three times");
		//verification using never(). never() is an alias to times(0)
		verify(mockedList, never()).add("never happened");
		//verification using atLeast()/atMost()
		verify(mockedList, atLeastOnce()).add("three times");
		verify(mockedList, atLeast(2)).add("three times");
		verify(mockedList, atMost(5)).add("three times");
		}
}
