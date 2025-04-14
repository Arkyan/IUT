package testspractice;

import static org.junit.jupiter.api.Assertions.*;


import org.junit.jupiter.api.Test;

class DateUtilsTest {

	@Test
	void should_be_a_PreJulianYear_before_1582_not_a_leap_year() {
		assertTrue(DateUtils.isPreJulianYear(1581));
		assertFalse(DateUtils.isLeapYear(1581));
	}
	
	@Test
	void should_be_not_a_PreJulianYear_after_1582() {
		assertFalse(DateUtils.isPreJulianYear(1582));
		assertFalse(DateUtils.isPreJulianYear(1852));
	}
	
	@Test
	void should_be_a_leap_year_when_divisible_by_400() {
		assertTrue(DateUtils.isLeapYear(2000));
		assertTrue(DateUtils.isLeapYear(1600));
		assertTrue(DateUtils.isLeapYear(2400));
	}
	
	@Test
	void should_be_a_leap_year_when_divisible_by_4_but_not_by_100 () {
		assertTrue(DateUtils.isLeapYear(2004));
		assertTrue(DateUtils.isLeapYear(2016));
		assertFalse(DateUtils.isLeapYear(2100));
	 }
	
	@Test
	void should_not_be_a_leap_year_when_divisible_by_100_but_not_by_400 () {
		assertFalse(DateUtils.isLeapYear(1900));
		assertFalse(DateUtils.isLeapYear(2100));
		assertFalse(DateUtils.isLeapYear(2200));
		assertFalse(DateUtils.isLeapYear(2300));
	}
	
	@Test
	void should_not_be_a_leap_year() {
		assertFalse(DateUtils.isLeapYear(2001));
		assertFalse(DateUtils.isLeapYear(2002));
		assertFalse(DateUtils.isLeapYear(2003));
		assertFalse(DateUtils.isLeapYear(2005));
		assertFalse(DateUtils.isLeapYear(2006));
		assertFalse(DateUtils.isLeapYear(2007));
		assertTrue(DateUtils.isLeapYear(2008));
		assertFalse(DateUtils.isLeapYear(2009));
		assertFalse(DateUtils.isLeapYear(2010));
		assertFalse(DateUtils.isLeapYear(2011));
		assertTrue(DateUtils.isLeapYear(2012));
		assertFalse(DateUtils.isLeapYear(2013));
		assertFalse(DateUtils.isLeapYear(2014));
		assertFalse(DateUtils.isLeapYear(2015));
		assertTrue(DateUtils.isLeapYear(2016));
	}

}

