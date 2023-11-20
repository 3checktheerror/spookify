package com.xmum.swe.enums;

public enum IdPos {
    ID_Begin(0),
    ID_APP_ENTITY(2),
    ID_ENTITY_NUM(4),
    ID_END(10);

    private int pos;

    IdPos(int _pos) {
        pos = _pos;
    }
    public int getPos() {
        return pos;
    }
}
