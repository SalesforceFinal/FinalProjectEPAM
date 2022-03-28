@IsTest
private class ScheduleBatchEveryDayTest {
    @IsTest
    static void testScheduleBatchEveryDay() {
        Test.startTest();
        String jobId = System.schedule('testScheduledApex',
        ScheduleBatchEveryDay.CRON_EXP,
            new ScheduleBatchEveryDay());
        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered,
            NextFireTime
            FROM CronTrigger WHERE id = :jobId];
        System.assertEquals(ScheduleBatchEveryDay.CRON_EXP,
            ct.CronExpression);
        System.assertEquals(0, ct.TimesTriggered);
        System.assertEquals('2022-03-29 00:00:00',
            String.valueOf(ct.NextFireTime));
        Test.stopTest();
    }
}