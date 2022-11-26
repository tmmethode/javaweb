package java_action;

public class ChatHistory {
    int chatId;
    String message_sent;
    String timestamp;
    int from_userid;
    int to_userid;
    int status;

    public int getFrom_userid() {
        return from_userid;
    }

    public void setFrom_userid(int from_userid) {
        this.from_userid = from_userid;
    }

    public int getTo_userid() {
        return to_userid;
    }

    public void setTo_userid(int to_userid) {
        this.to_userid = to_userid;
    }

    public int getChatId() {
        return chatId;
    }

    public void setChatId(int chatId) {
        this.chatId = chatId;
    }

    public String getMessage_sent() {
        return message_sent;
    }

    public void setMessage_sent(String message_sent) {
        this.message_sent = message_sent;
    }

    public String getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(String timestamp) {
        this.timestamp = timestamp;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }
}
