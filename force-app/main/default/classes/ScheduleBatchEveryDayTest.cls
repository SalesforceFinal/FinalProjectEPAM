@IsTest
private class ScheduleBatchEveryDayTest {
    @IsTest
    static void testScheduleBatchEveryDay() {
        Test.startTest();
        String jobId = System.schedule('testScheduledApex',
        ScheduleBatchEveryDay.CRON_EXP,
            new ScheduleBatchEveryDay());
        Test.stopTest();
        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered,
            NextFireTime
            FROM CronTrigger WHERE id = :jobId];
        System.assertEquals(ScheduleBatchEveryDay.CRON_EXP,
            ct.CronExpression);
        System.assertEquals(0, ct.TimesTriggered);
    }
}