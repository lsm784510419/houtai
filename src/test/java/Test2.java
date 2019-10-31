public class Test2 {
    public static void main(String[] args) {
        //递归阶乘
        System.out.println(jc(8));
        //斐波那契数列
        System.out.println(FB(10));
    }
    public static int jc(int a){
        /**
         * 阶乘的规律
         * 0的阶乘是1
         * 1的阶乘是1
         * 2的阶乘是1*2
         * 3的阶乘是1*2*3
         * 依次类推
         * 5！代表5的阶乘
         */
            if ( a==0 || a==1){
                return 1;
            }else{
                return a * jc(a-1);
            }
    }
    //斐波那契数列
    public static long FB(int a){
        /**
         * 规律
         * 1,1,2,3,5,8,13,21
         * 如果求第7位数的话就是第6位数和第5位数的和
         */
        if (a==1 || a==2){
            return 1;
        }else{
            return FB(a-2)+FB(a-1);
        }
    }
}
