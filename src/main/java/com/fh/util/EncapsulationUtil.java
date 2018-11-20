package com.fh.util;

import java.util.ArrayList;
import java.util.List;

public class EncapsulationUtil {

    public static String encapsulateIds(List<String> idsList){
        if (idsList != null && idsList.size() != 0){
            StringBuffer idsStr = new StringBuffer();
            idsStr.append("(");
            for (int i=0; i<idsList.size(); i++){
                idsStr.append("'"+idsList.get(i).toString()+"',");
            }
            idsStr.delete(idsStr.length()-1,idsStr.length());
            idsStr.append(")");
            return idsStr.toString();
        }
        return null;
    }

}
