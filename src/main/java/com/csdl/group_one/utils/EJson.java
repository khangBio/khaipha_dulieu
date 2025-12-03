package com.csdl.group_one.utils;

import com.google.gson.*;
import com.csdl.group_one.configuration.CustomException;

import java.math.BigDecimal;
import java.text.Normalizer;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.regex.Pattern;

public class EJson {
    private JsonElement json;
    private Dictionary<String, String> errors;
    private ResponseBodyJson responseBodyJson;

    public EJson() {
        super();
        this.json = new JsonObject();
        this.errors = new Hashtable<String, String>();
    }

    public EJson(String source) {
        super();
        JsonParser jsonParser = new JsonParser();
        if (source != null && !source.isEmpty()) {
            this.json = jsonParser.parse(source);
        }
        this.errors = new Hashtable<String, String>();
    }

    public EJson(JsonObject source) {
        super();
        this.json = source;
        this.errors = new Hashtable<String, String>();
    }

    public EJson(ResponseBodyJson responseBodyJson) {
        super();
        this.json = new JsonObject();
        this.errors = new Hashtable<String, String>();
        this.responseBodyJson = responseBodyJson;
    }

    public void put(String key, Object value) {
        this.setValue(key, value);
    }

    public String jsonString() {
        return json != null ? setResponseBodyJson(json) : null;
    }

    public JsonObject jsonObject() {
        return json != null ? json.getAsJsonObject() : null;
    }

    public JsonArray jsonArray() {
        return json != null ? json.getAsJsonArray() : null;
    }

    public List<EJson> toArray() {
        List<EJson> result = new ArrayList<EJson>();
        for (int i = 0; i < json.getAsJsonArray().size(); i++) {
            result.add(new EJson(json.getAsJsonArray().get(i).getAsJsonObject()));
        }
        return result;
    }

    public String success() {
        setValue("result", "Success");
        setValue("msg", "OK");
        setValue("desc", "");
        return setResponseBodyJson(json);
    }

    public String success(String message) {
        setValue("result", "Success");
        setValue("msg", "OK");
        setValue("desc", message);
        return setResponseBodyJson(json);
    }

    public String error() {
        setValue("result", "Error");
        setValue("msg", "FAIL");
        setValue("desc", "Xuất hiện lỗi trong quá trình xử lý");
        if (errors.size() > 0)
            setValue("errors", errors);
        return setResponseBodyJson(json);
    }

    public String error(String message) {
        setValue("result", "Error");
        setValue("msg", "FAIL");
        setValue("desc", message);
        if (errors.size() > 0)
            setValue("errors", errors);
        return setResponseBodyJson(json);
    }

    public String error(String key, String message) {
        setValue(key, message);
        setValue("result", "Error");
        setValue("msg", "FAIL");
        setValue("desc", "");
        if (errors.size() > 0)
            setValue("errors", errors);
        return setResponseBodyJson(json);
    }

    public void addError(String key, String message) {
        errors.put(key, message);
    }

    private String setResponseBodyJson(JsonElement source) {
        String body = source.toString();
        if (responseBodyJson != null) {
            responseBodyJson.setBodyString(body);
        }
        return body;
    }

    public boolean hasValue(String key) {
        if (json.getAsJsonObject().get(key) == null) {
            return false;
        }
        if (json.getAsJsonObject().get(key).isJsonNull()) {
            return false;
        }
        if (json.getAsJsonObject().get(key).toString().equals("")) {
            return false;
        }
        return true;
    }

    public BigDecimal BigDecimal(String key) {
        return BigDecimal.valueOf(hasValue(key) ? json.getAsJsonObject().get(key).getAsBoolean() == true ? 1 : 0 : 0);
    }

    public String getString(String key) {
        return hasValue(key) ? json.getAsJsonObject().get(key).getAsString() : "";
    }

    public List<String> getArray(String key) {
        List<String> list = new ArrayList<String>();
        if (hasValue(key)) {
            JsonParser jsonParser = new JsonParser();
            JsonArray items = new JsonArray();
            JsonElement value = json.getAsJsonObject().get(key);
            if (value.isJsonArray()) {
                items = value.getAsJsonArray();
            } else {
                items = jsonParser.parse(value.getAsString()).getAsJsonArray();
            }

            for (int i = 0; i < items.size(); i++) {
                String item = items.get(i).getAsString();
                list.add(item);
            }
        }
        return hasValue(key) ? list : null;
    }

    public JsonObject getAsObject(){
        return json.getAsJsonObject();
    }

    public Long getLong(String key) {
        return hasValue(key) ? json.getAsJsonObject().get(key).getAsLong() : null;
    }

    public Integer getInt(String key) {
        return hasValue(key) ? json.getAsJsonObject().get(key).getAsInt() : null;
    }

    public BigDecimal getBigDecimal(String key) {
        return hasValue(key) ? json.getAsJsonObject().get(key).getAsBigDecimal() : null;
    }

    public Number getNumber(String key) {
        return hasValue(key) ? json.getAsJsonObject().get(key).getAsNumber() : null;
    }

    public boolean getBoolean(String key) {
        return hasValue(key) ? json.getAsJsonObject().get(key).getAsBoolean() : false;
    }

    public BigDecimal convertBooleanToBigDecimal(String key) {
        return BigDecimal.valueOf(hasValue(key) ? (json.getAsJsonObject().get(key).getAsBoolean() ? 1 : 0) : 0);
    }

    public Number convertBooleanToNumber(String key) {
        return hasValue(key) ? (json.getAsJsonObject().get(key).getAsBoolean() ? 1 : 0) : 0;
    }

    public Date getDate(String key) throws ParseException {
        if (!hasValue(key)) {
            return null;
        }
        SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
        return formatter.parse(getString(key));
    }

    public String getDateString(String key) throws ParseException {
        if (!hasValue(key)) {
            return null;
        }
        String strdate = getString(key);
        String result = "";
        if (!strdate.equals("")) {
            String[] arr = strdate.split("/");
            if (arr.length == 1){
                result = arr[0];
            }else if (arr.length == 2){
                result = arr[1] + "" + arr[0];
            }else {
                result = arr[2] + "" + arr[1] + "" + arr[0];
            }
        }
        return result;
    }

    public String getDateTimeString(String key) throws ParseException {
        if (!hasValue(key)) {
            return null;
        }
        String strdate = getString(key);
        String result = "";
        if (!strdate.equals("")) {
            String[] arr = strdate.split("/");
            result = arr[2] + "" + arr[1] + "" + arr[0] + "000000";
        }
        return result;
    }

    public Date getFromBirthday(String key) throws CustomException {
        if (!hasValue(key)) {
            return null;
        }
        String strDate = getString(key);
        if (strDate.equals("")) {
            return null;
        }
        if ((strDate.length() == 4 && Integer.parseInt(strDate) >= 9999) ||
                (strDate.length() == 7 && Integer.parseInt(strDate.substring(3)) >= 9999) ||
                (strDate.length() == 10 && Integer.parseInt(strDate.substring(6)) >= 9999)) {
            throw new CustomException(key, "Ngày không đúng định dạng");
        }
        Date result = new Date();
        try {
            if (strDate.length() == 4) {
                SimpleDateFormat dateConvert = new SimpleDateFormat("yyyy");
                dateConvert.setLenient(false);
                result = dateConvert.parse(strDate);
            } else if (strDate.length() == 7) {
                SimpleDateFormat dateConvert = new SimpleDateFormat("MM/yyyy");
                dateConvert.setLenient(false);
                result = dateConvert.parse(strDate);
            } else {
                SimpleDateFormat dateConvert = new SimpleDateFormat("dd/MM/yyyy");
                dateConvert.setLenient(false);
                result = dateConvert.parse(strDate);
            }
        } catch (Exception e) {
            throw new CustomException(key, "Ngày không đúng định dạng");
        }
        return result;
    }

    public Date getToBirthday(String key) throws CustomException {
        if (!hasValue(key)) {
            return null;
        }
        String strDate = getString(key);
        if (strDate.equals("")) {
            return null;
        }
        Calendar calendar = Calendar.getInstance();
        if ((strDate.length() == 4 && Integer.parseInt(strDate) >= 9999) ||
                (strDate.length() == 7 && Integer.parseInt(strDate.substring(3)) >= 9999) ||
                (strDate.length() == 10 && Integer.parseInt(strDate.substring(6)) >= 9999)) {
            throw new CustomException(key, "Ngày không đúng định dạng");
        }
        try {
            if (strDate.length() == 4) {
                SimpleDateFormat dateConvert = new SimpleDateFormat("yyyy");
                dateConvert.setLenient(false);
                Date result = dateConvert.parse(strDate);
                calendar.setTime(result);
                calendar.add(Calendar.YEAR, 1);
            } else if (strDate.length() == 7) {
                SimpleDateFormat dateConvert = new SimpleDateFormat("MM/yyyy");
                dateConvert.setLenient(false);
                Date result = dateConvert.parse(strDate);
                calendar.setTime(result);
                calendar.add(Calendar.MONTH, 1);
            } else {
                SimpleDateFormat dateConvert = new SimpleDateFormat("dd/MM/yyyy");
                dateConvert.setLenient(false);
                Date result = dateConvert.parse(strDate);
                calendar.setTime(result);
                calendar.add(Calendar.DATE, 1);
            }
        } catch (Exception e) {
            throw new CustomException(key, "Ngày không đúng định dạng");
        }
        return calendar.getTime();
    }

    public EJson getJSONObject(String key) {
        return hasValue(key) ? new EJson(json.getAsJsonObject().get(key).getAsJsonObject()) : null;
    }

    public List<EJson> getJSONArray(String key) {
        List<EJson> data = new ArrayList<EJson>();
        if (hasValue(key)) {
            JsonParser jsonParser = new JsonParser();
            JsonArray items = new JsonArray();
            JsonElement value = json.getAsJsonObject().get(key);
            if (value.isJsonArray()) {
                items = value.getAsJsonArray();
            } else {
                items = jsonParser.parse(value.getAsString()).getAsJsonArray();
            }

            for (int i = 0; i < items.size(); i++) {
                JsonObject item = items.get(i).getAsJsonObject();
                data.add(new EJson(item));
            }
        }
        return data;
    }

    private void setValue(String key, Object value) {
        Gson gson = new GsonBuilder().create();
        JsonElement element = gson.toJsonTree(value);
        json.getAsJsonObject().add(key, element);
    }


    public int getDateCompare(String dateStart, String dateEnd) {

        String strStart = getString(dateStart);
        String strEnd = getString(dateEnd);

        if (strStart.length() == 4 && (strStart.length() <= strEnd.length())) {

            if (strEnd.length() == 4) {
                return strStart.compareTo(strEnd);
            } else if (strEnd.length() == 7) {
                return strStart.compareTo(strEnd.substring(3));
            } else {
                return strStart.compareTo(strEnd.substring(6));
            }

        }
        if (strStart.length() == 7 && (strStart.length() <= strEnd.length())) {

            String temp = strStart.substring(3) + strStart.substring(0, 2);
            if (strEnd.length() == 7) {
                return temp.compareTo(strEnd.substring(3) + strEnd.substring(0, 2));
            } else {
                return temp.compareTo(strEnd.substring(6) + strEnd.substring(3, 5));
            }

        }
        if (strStart.length() == 10 && (strStart.length() <= strEnd.length())) {

            String temp = strStart.substring(6) + strStart.substring(3, 5) + strStart.substring(0, 2);
            return temp.compareTo(strEnd.substring(6) + strEnd.substring(3, 5) + strEnd.substring(0, 2));

        }

        if (strEnd.length() == 4 && (strEnd.length() <= strStart.length())) {

            if (strStart.length() == 4) {
                return strStart.compareTo(strEnd);
            } else if (strStart.length() == 7) {
                return strStart.substring(3).compareTo(strEnd);
            } else {
                return strStart.substring(6).compareTo(strEnd);
            }

        }
        if (strEnd.length() == 7 && (strEnd.length() <= strStart.length())) {

            String temp = strEnd.substring(3) + strEnd.substring(0, 2);
            if (strStart.length() == 7) {
                return (strStart.substring(3) + strStart.substring(0, 2)).compareTo(temp);
            } else {
                return (strStart.substring(6) + strStart.substring(3, 5)).compareTo(temp);
            }

        }
        if (strEnd.length() == 10 && (strEnd.length() <= strStart.length())) {

            String temp = strEnd.substring(6) + strEnd.substring(3, 5) + strEnd.substring(0, 2);
            return (strStart.substring(6) + strStart.substring(3, 5) + strStart.substring(0, 2)).compareTo(temp);

        }
        return Integer.parseInt(null);
    }

    public String getStringSearch(String key) {
        if (!hasValue(key)) {
            return "";
        }
        String str = getString(key);
        try {
            String temp = Normalizer.normalize(str, Normalizer.Form.NFD);
            Pattern pattern = Pattern.compile("\\p{InCombiningDiacriticalMarks}+");
            return pattern.matcher(temp).replaceAll("").replaceAll("Đ", "D").replace("đ", "").replaceAll("\\s","");
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return null;
    }
}
