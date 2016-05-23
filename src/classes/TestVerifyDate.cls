@isTest
public class TestVerifyDate {
    @isTest static void testDate2LessThanDate1() {
        Date pri = VerifyDate.CheckDates(Datetime.now().date(),Datetime.now().addDays(-1).date());
        System.assertEquals(Date.newInstance(Datetime.now().date().year(), Datetime.now().date().month(), Date.daysInMonth(Datetime.now().date().year(), Datetime.now().date().month())), pri);
    }
    @isTest static void testDate2GreaterThanDate1_30Days() {
        Date pri = VerifyDate.CheckDates(Datetime.now().date(),Datetime.now().addDays(25).date());
        System.assertEquals(Date.newInstance(Datetime.now().date().year(), Datetime.now().date().month(), Date.daysInMonth(Datetime.now().date().year(), Datetime.now().date().month())), pri);
    }
    @isTest static void testDate2GreaterThanDate1_WithInRange() {
        Date pri = VerifyDate.CheckDates(Datetime.now().date(),Datetime.now().addDays(35).date());
        System.assertEquals(Datetime.now().addDays(35).date(), pri);
    }
}