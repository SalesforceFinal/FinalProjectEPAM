public with sharing class ScheduleBatchEveryDay implements Schedulable {
    public static String CRON_EXP = '0 0 0 * * ?';
    public void execute(SchedulableContext ctx) {
        CleanOldTodosBatch cleanOldTodosBatch = new CleanOldTodosBatch();
        Database.executeBatch(cleanOldTodosBatch);
        ChangeCategoryBatch changeCategoryBatch = new ChangeCategoryBatch();
        Database.executeBatch(changeCategoryBatch);
    }
}