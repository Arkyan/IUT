package io.application.gui.console;

public enum Emoji {
    GIFT("🎁"),
    SMILE("😊"),
    WARNING("⚠️"),
    CHECK("✅"),
    ERROR("❌"),
    STAR("⭐"),
    FIRE("🔥"),
    EGG("🥚"),
    PARTY("🥳"),
    CHOCOLATE_BAR("🍫"),
    OK_HAND("👌"),
    THUMBS_UP("👍"),
    THUMBS_DOWN("👎"),
    GRINNING_FACE("😀"),
    HEART("❤️"),
    HEART_EYES("😍"),
    HUGGING_FACE("🤗"),
    ROLLING_EYES("🙄"),
    FACE_WITH_ROLLING_EYES("🙄"),
    FACE_WITH_TEARS_OF_JOY("😂"),
    FACE_WITH_MEDICAL_MASK("😷"),
    FACE_WITH_MONOCLE("🧐"),
    FACE_WITH_HAND_OVER_MOUTH("🤭"),
    FACE_WITH_RAISED_EYEBROW("🤨");



    private final String symbol;

    Emoji(String symbol) {
        this.symbol = symbol;
    }

    public String getSymbol() {
        return symbol;
    }

    @Override
    public String toString() {
        return symbol;
    }
}
