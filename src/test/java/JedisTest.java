import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import redis.clients.jedis.Jedis;

public class JedisTest {
    @Test
    public void jdTest(){
        //连接linux的 Redis 服务
        Jedis jedis = new Jedis("192.168.239.129",7020);
        System.out.println("连接成功");
        jedis.set("lsm", "mengmeng");
        //查看服务是否运行
        System.out.println("服务正在运行: "+jedis.ping());
        // 获取存储的数据并输出
        System.out.println("redis 存储的字符串为: "+ jedis.get("lsm"));

    }
}
