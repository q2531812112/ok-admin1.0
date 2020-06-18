package com.oa.vo;

/**
 * @description:
 * @author: MagicXianyu
 * @date: 2020-06-16 9:02
 */
public class JsonData {

    private Integer code;
    private String msg;

    public JsonData(Integer code, String msg) {
        this.code = code;
        this.msg = msg;
    }

    public JsonData() {
    }

    public Integer getCode() {
        return code;
    }

    public void setCode(Integer code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }
}
