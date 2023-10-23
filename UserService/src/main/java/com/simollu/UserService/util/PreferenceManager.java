package com.simollu.UserService.util;


import org.springframework.stereotype.Component;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Component
public class PreferenceManager {

    private final Map<String, List<String>> preferenceMap;

    public PreferenceManager() {
        preferenceMap = new HashMap<>();
        preferenceMap.put("독서", Arrays.asList("서점", "도서관", "도서대여점"));
        preferenceMap.put("걷기", Arrays.asList());
        preferenceMap.put("사진", Arrays.asList("인생네컷"));
        preferenceMap.put("쇼핑", Arrays.asList("마트", "백화점", "아트박스", "다이소"));
        preferenceMap.put("노래", Arrays.asList("노래방"));
        preferenceMap.put("휴식", Arrays.asList("카페"));
        preferenceMap.put("오락&게임", Arrays.asList("오락실", "PC방"));
    }

    public Map<String, List<String>> getPreferenceMap() {
        return preferenceMap;
    }


}
