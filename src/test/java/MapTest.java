import org.junit.Test;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

public class MapTest {

    @Test
    public void test(){

        Map<String,Object> result = new HashMap<>();
        result.put("userName","小明");
        result.put("age","12");
        result.put("sex","男");
        Iterator<Map.Entry<String, Object>> iterator = result.entrySet().iterator();
        while (iterator.hasNext()){
            Map.Entry<String, Object> next = iterator.next();
            String key = next.getKey();
            Object value = next.getValue();
            System.out.println(key+value);
        }


    }
}
