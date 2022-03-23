@IsTest
private class CreateTodoEmailTest {
    @IsTest
    static void testHandleInboundEmailLater () {
        Messaging.InboundEmail email = new Messaging.InboundEmail() ;
        Messaging.InboundEnvelope envelope = new Messaging.InboundEnvelope();

        email.subject = 'Test Todo Email';
        email.plainTextBody = 'Test Todo Email';
        envelope.fromAddress = 'test@test.com';
        CreateTodoEmail todoEmail = new CreateTodoEmail();
        todoEmail.handleInboundEmail(email, envelope);
    }

    @IsTest
    static void testHandleInboundEmailToday () {
        Messaging.InboundEmail email = new Messaging.InboundEmail() ;
        Messaging.InboundEnvelope envelope = new Messaging.InboundEnvelope();

        email.subject = 'Test Todo Email';
        email.plainTextBody = 'Test Todo Email. Today.';
        envelope.fromAddress = 'test@test.com';
        CreateTodoEmail todoEmail = new CreateTodoEmail();
        todoEmail.handleInboundEmail(email, envelope);
    }

    @IsTest
    static void testHandleInboundEmailTomorrow () {
        Messaging.InboundEmail email = new Messaging.InboundEmail() ;
        Messaging.InboundEnvelope envelope = new Messaging.InboundEnvelope();

        email.subject = 'Test Todo Email';
        email.plainTextBody = 'Test Todo Email. Tomorrow.';
        envelope.fromAddress = 'test@test.com';
        CreateTodoEmail todoEmail = new CreateTodoEmail();
        todoEmail.handleInboundEmail(email, envelope);
    }
}